from __future__ import annotations

from anthropic.lib.bedrock import AnthropicBedrock, AnthropicBedrockMantle

from .common import env_value, is_configured, load_environment, print_heading, response_to_text


def _has_bedrock_credentials() -> bool:
    return any(
        [
            is_configured("AWS_BEARER_TOKEN_BEDROCK"),
            is_configured("AWS_PROFILE"),
            is_configured("AWS_ACCESS_KEY_ID") and is_configured("AWS_SECRET_ACCESS_KEY"),
        ]
    )


def _optional_env(name: str) -> str | None:
    value = env_value(name)
    return value or None


def main() -> int:
    load_environment()

    if not _has_bedrock_credentials():
        print(
            "Bedrock extras are installed. Set AWS_PROFILE, AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY, "
            "or AWS_BEARER_TOKEN_BEDROCK in .env to run the Bedrock verification."
        )
        return 0

    transport = env_value("ANTHROPIC_BEDROCK_TRANSPORT", "mantle").lower()
    model = env_value("ANTHROPIC_BEDROCK_MODEL", "claude-sonnet-5")
    region = env_value("AWS_REGION", "us-east-1")
    prompt = env_value(
        "ANTHROPIC_TEST_PROMPT",
        "Confirm the Bedrock environment is configured correctly in one short sentence.",
    )

    print_heading("Bedrock")
    print(f"Transport: {transport}")
    print(f"Region: {region}")
    print(f"Model: {model}")

    try:
        if transport == "mantle":
            client = AnthropicBedrockMantle(
                aws_region=region,
                aws_profile=_optional_env("AWS_PROFILE"),
                aws_access_key=_optional_env("AWS_ACCESS_KEY_ID"),
                aws_secret_key=_optional_env("AWS_SECRET_ACCESS_KEY"),
                aws_session_token=_optional_env("AWS_SESSION_TOKEN"),
                api_key=_optional_env("AWS_BEARER_TOKEN_BEDROCK"),
            )
        elif transport == "runtime":
            client = AnthropicBedrock(
                aws_region=region,
                aws_profile=_optional_env("AWS_PROFILE"),
                aws_access_key=_optional_env("AWS_ACCESS_KEY_ID"),
                aws_secret_key=_optional_env("AWS_SECRET_ACCESS_KEY"),
                aws_session_token=_optional_env("AWS_SESSION_TOKEN"),
                api_key=_optional_env("AWS_BEARER_TOKEN_BEDROCK"),
            )
        else:
            print("ANTHROPIC_BEDROCK_TRANSPORT must be either 'mantle' or 'runtime'.")
            return 1

        response = client.messages.create(
            model=model,
            max_tokens=256,
            messages=[{"role": "user", "content": prompt}],
        )
    except Exception as exc:
        print(f"Bedrock verification failed: {exc}")
        return 1

    print("Bedrock request succeeded.")
    print(response_to_text(response.content))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
