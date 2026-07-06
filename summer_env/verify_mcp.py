from __future__ import annotations

from langchain_anthropic import ChatAnthropic

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

    try:
        from anthropic.lib.tools.mcp import mcp_tool  # noqa: F401
    except ImportError as exc:
        print(f"MCP helpers are not available: {exc}")
        return 1

    print_heading("MCP")
    print("MCP helper import succeeded.")

    if not is_configured("ANTHROPIC_MCP_SERVER_URL"):
        print("Set ANTHROPIC_MCP_SERVER_URL in .env to run a remote MCP verification.")
        return 0

    if not is_configured("ANTHROPIC_API_KEY"):
        print("Set ANTHROPIC_API_KEY in .env before running the MCP verification.")
        return 0

    model = require_value("ANTHROPIC_MODEL")
    prompt = env_value(
        "ANTHROPIC_MCP_PROMPT",
        "List the tools available from the configured MCP server and summarize them in one short paragraph.",
    )
    server = {
        "type": "url",
        "name": env_value("ANTHROPIC_MCP_SERVER_NAME", "example-mcp"),
        "url": require_value("ANTHROPIC_MCP_SERVER_URL"),
    }
    token = env_value("ANTHROPIC_MCP_SERVER_BEARER_TOKEN")
    if token:
        server["authorization_token"] = token

    llm = ChatAnthropic(model=model, max_tokens=256, mcp_servers=[server])

    try:
        response = llm.invoke(prompt)
    except Exception as exc:
        print(f"MCP verification failed: {exc}")
        return 1

    print("MCP request succeeded.")
    print(response_to_text(response.content))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
