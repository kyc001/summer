from __future__ import annotations

from langchain_anthropic import ChatAnthropic
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate

from .common import (
    env_value,
    load_environment,
    mask_secret,
    print_heading,
    require_value,
    response_to_text,
)


def main() -> int:
    load_environment()

    try:
        api_key = require_value("ANTHROPIC_API_KEY")
        model = require_value("ANTHROPIC_MODEL")
    except ValueError as exc:
        print(exc)
        return 1

    prompt = env_value(
        "ANTHROPIC_TEST_PROMPT",
        "Confirm the environment is configured correctly in one short sentence.",
    )
    base_url = env_value("ANTHROPIC_BASE_URL")

    print_heading("Anthropic")
    print(f"Loaded ANTHROPIC_API_KEY: {mask_secret(api_key)}")
    if base_url:
        print(f"Using base URL: {base_url}")
    print(f"Using model: {model}")

    llm = ChatAnthropic(model=model, max_tokens=256, base_url=base_url or None)
    chain = ChatPromptTemplate.from_messages(
        [
            ("system", "You are a concise environment verification assistant."),
            ("human", "{prompt}"),
        ]
    ) | llm | StrOutputParser()

    try:
        response = chain.invoke({"prompt": prompt})
    except Exception as exc:
        print(f"Anthropic pipe request failed: {exc}")
        return 1

    print("Anthropic pipe request succeeded.")
    print(response_to_text(response))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
