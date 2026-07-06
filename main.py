from __future__ import annotations

from typing import Literal

try:
    from fastapi import FastAPI
    from pydantic import BaseModel, Field
except ImportError as exc:  # pragma: no cover - used before dependencies are installed
    raise SystemExit(
        "FastAPI dependencies are not installed. Run `uv sync --python 3.11` first."
    ) from exc

from modules.agents import run_competitor_analysis


class AnalysisRequest(BaseModel):
    competitor: str = Field(..., description="Competitor company, product, or brand name.")
    dimensions: list[Literal["price", "product", "sentiment"]] = Field(
        default_factory=lambda: ["price", "product", "sentiment"],
        description="Monitoring dimensions to analyze.",
    )
    period: str = Field("today", description="Analysis period, such as today, weekly, or monthly.")


app = FastAPI(
    title="Competitor Intelligence Analysis System",
    description="Claude Skill based competitor tracking and intelligent benchmarking service.",
    version="0.1.0",
)


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok", "service": "competitor-intel-system"}


@app.post("/analysis/run")
def run_analysis(request: AnalysisRequest) -> dict[str, object]:
    cards = run_competitor_analysis(
        competitor=request.competitor,
        dimensions=list(request.dimensions),
        period=request.period,
    )
    return {
        "competitor": request.competitor,
        "period": request.period,
        "cards": [card.to_dict() for card in cards],
    }
