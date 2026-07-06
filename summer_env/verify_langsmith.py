from __future__ import annotations

import time

from langchain_anthropic import ChatAnthropic
from langsmith import Client, traceable, tracing_context

from .common import (
    env_value,
    is_configured,
    load_environment,
    print_heading,
    require_value,
    response_to_text,
)


def main() -> int:
    load_environment()

    if not is_configured("LANGSMITH_API_KEY"):
        print("LangSmith package is installed. Set LANGSMITH_API_KEY in .env to run the traced verification.")
        return 0

    if not is_configured("ANTHROPIC_API_KEY"):
        print("Set ANTHROPIC_API_KEY in .env before running the LangSmith verification.")
        return 0

    model = require_value("ANTHROPIC_MODEL")
    prompt = env_value(
        "ANTHROPIC_TEST_PROMPT",
        "Confirm the LangSmith tracing setup in one short sentence.",
    )
    project_name = env_value("LANGSMITH_PROJECT", "summer-anthropic-lab")

    print_heading("LangSmith")
    client = Client(api_key=require_value("LANGSMITH_API_KEY"))
    llm = ChatAnthropic(model=model, max_tokens=256)

    @traceable(name="verify_langsmith", run_type="chain")
    def run_check(user_prompt: str) -> str:
        response = llm.invoke(user_prompt)
        return response_to_text(response.content)

    try:
        with tracing_context(project_name=project_name, enabled=True):
            text = run_check(prompt)
    except Exception as exc:
        print(f"LangSmith verification failed: {exc}")
        return 1

    print(f"Using project: {project_name}")
    print(text)

    latest_run = None
    for _ in range(5):
        runs = list(client.list_runs(project_name=project_name, limit=1))
        if runs:
            latest_run = runs[0]
            break
        time.sleep(1)

    if latest_run is None:
        print("Trace upload may still be in flight. Check the LangSmith UI if you do not see it immediately.")
        return 0

    print(f"Latest run id: {latest_run.id}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
