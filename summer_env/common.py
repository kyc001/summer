from __future__ import annotations

import os
from typing import Any

from dotenv import load_dotenv


PLACEHOLDER_PREFIXES = ("replace-", "your-", "<")


def load_environment() -> None:
    load_dotenv()


def env_value(name: str, default: str = "") -> str:
    return os.getenv(name, default).strip()


def is_placeholder(value: str) -> bool:
    normalized = value.strip().lower()
    if not normalized:
        return True
    return normalized.startswith(PLACEHOLDER_PREFIXES)


def is_configured(name: str) -> bool:
    return not is_placeholder(env_value(name))


def mask_secret(secret: str) -> str:
    if len(secret) < 12:
        return "***configured***"
    return f"{secret[:8]}...{secret[-4:]}"


def response_to_text(content: Any) -> str:
    if isinstance(content, str):
        return content
    if isinstance(content, list):
        parts: list[str] = []
        for block in content:
            if isinstance(block, dict) and block.get("type") == "text":
                parts.append(str(block.get("text", "")).strip())
            elif hasattr(block, "text"):
                parts.append(str(block.text).strip())
            else:
                parts.append(str(block).strip())
        return "\n".join(part for part in parts if part)
    return str(content)


def require_value(name: str) -> str:
    value = env_value(name)
    if is_placeholder(value):
        raise ValueError(f"{name} is not configured in .env")
    return value


def print_heading(title: str) -> None:
    print(f"== {title} ==")
