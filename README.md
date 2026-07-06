# Summer Anthropic-Compatible Environment

This workspace is configured around `uv`, Python `3.11`, and an Anthropic-compatible chat endpoint. The default example targets DeepSeek's Anthropic-compatible API.

## Quick start

1. Install the base environment:

   ```powershell
   uv sync --python 3.11
   ```

2. Install every optional integration:

   ```powershell
   uv sync --python 3.11 --extra full
   ```

3. Fill in the secrets and account-specific values in `.env`.

   ```dotenv
   ANTHROPIC_API_KEY=your-api-key
   ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
   ANTHROPIC_MODEL=deepseek-v4-flash
   ```

4. Run the pipe check:

   ```powershell
   uv run python verify_env.py
   ```

   The check builds a LangChain runnable pipe:

   ```python
   prompt | llm | parser
   ```

5. Run optional integration checks only after filling their own credentials:

   ```powershell
   uv run python -m summer_env.verify_langsmith
   uv run python -m summer_env.verify_bedrock
   uv run python -m summer_env.verify_mcp
   ```

## Optional integrations

- `LangSmith` uses `LANGSMITH_API_KEY`, `LANGSMITH_TRACING`, and `LANGSMITH_PROJECT`.
- `Bedrock` defaults to the newer `mantle` transport. Switch `ANTHROPIC_BEDROCK_TRANSPORT` to `runtime` only if you want the classic Bedrock runtime and have a Bedrock model ID.
- `MCP` expects a remote MCP server URL and an optional bearer token.

## Project files

- `verify_env.py`: base Anthropic + LangChain connectivity check.
- `summer_env/verify_langsmith.py`: traced request plus LangSmith API verification.
- `summer_env/verify_bedrock.py`: Amazon Bedrock verification for Mantle or Runtime.
- `summer_env/verify_mcp.py`: MCP helper import check and optional remote MCP request.
