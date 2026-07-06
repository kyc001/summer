from __future__ import annotations

from dataclasses import dataclass, field


@dataclass
class IntelCard:
    competitor: str
    dimension: str
    summary: str
    impact_level: str
    evidence_refs: list[str] = field(default_factory=list)
    action_items: list[str] = field(default_factory=list)

    def to_dict(self) -> dict[str, object]:
        return {
            "competitor": self.competitor,
            "dimension": self.dimension,
            "summary": self.summary,
            "impact_level": self.impact_level,
            "evidence_refs": self.evidence_refs,
            "action_items": self.action_items,
        }


def run_price_agent(competitor: str, period: str) -> IntelCard:
    return IntelCard(
        competitor=competitor,
        dimension="price",
        summary=f"{competitor} 在 {period} 周期内需要重点追踪促销、降价和套餐变化。",
        impact_level="medium",
        evidence_refs=["data/raw/*"],
        action_items=["补充价格类公开来源", "对比本企业同类产品价格区间"],
    )


def run_product_agent(competitor: str, period: str) -> IntelCard:
    return IntelCard(
        competitor=competitor,
        dimension="product",
        summary=f"{competitor} 在 {period} 周期内需要关注新品发布、功能迭代和版本更新。",
        impact_level="medium",
        evidence_refs=["data/raw/*"],
        action_items=["整理新品关键词", "抽取功能变化并生成对标矩阵"],
    )


def run_sentiment_agent(competitor: str, period: str) -> IntelCard:
    return IntelCard(
        competitor=competitor,
        dimension="sentiment",
        summary=f"{competitor} 在 {period} 周期内需要监控投诉、负面报道和用户集中反馈。",
        impact_level="medium",
        evidence_refs=["data/raw/*"],
        action_items=["保留负面舆情来源", "按严重程度标注风险等级"],
    )


AGENT_MAP = {
    "price": run_price_agent,
    "product": run_product_agent,
    "sentiment": run_sentiment_agent,
}


def run_competitor_analysis(
    competitor: str,
    dimensions: list[str],
    period: str,
) -> list[IntelCard]:
    cards: list[IntelCard] = []
    for dimension in dimensions:
        agent = AGENT_MAP.get(dimension)
        if agent is None:
            continue
        cards.append(agent(competitor, period))
    return cards
