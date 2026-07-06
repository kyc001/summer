from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path


@dataclass
class IntelDocument:
    doc_id: str
    text: str
    source: str
    competitor: str = ""
    dimension: str = ""


def load_raw_texts(raw_dir: str | Path = "data/raw") -> list[IntelDocument]:
    raw_path = Path(raw_dir)
    documents: list[IntelDocument] = []
    for path in sorted(raw_path.glob("*.txt")):
        documents.append(
            IntelDocument(
                doc_id=path.stem,
                text=path.read_text(encoding="utf-8"),
                source=str(path),
            )
        )
    return documents


def retrieve_by_keyword(
    documents: list[IntelDocument],
    keyword: str,
    limit: int = 5,
) -> list[IntelDocument]:
    normalized = keyword.lower()
    matches = [doc for doc in documents if normalized in doc.text.lower()]
    return matches[:limit]
