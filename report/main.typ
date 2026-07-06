#import "imports.typ": info, tip, success, tree-list, tblr, rows, cells, hline
#import "template.typ": internship-report, info-line, report-card

#show: internship-report.with(
  stu-num: "2310766",
  stu-name: "姓名",
  grade: "2023级",
  major: "软件工程",
  department: "软件学院",
  course: "企业实训",
  instructor: "指导教师",
  date: "2025年  7 月  24 日",
  abstract: [
    本报告围绕企业实训课程中的“基于 Claude Skill 的竞品动态追踪与智能对标分析系统实战”项目展开，按照学校本科实习报告模板梳理实习目的和要求、实习时间地点、实习单位和部门、实习内容以及实习总结等核心内容。报告结合项目实践过程，记录了从 Claude 与 LangChain 基础学习、公开舆情数据采集、RAG 向量知识库搭建，到 Claude Skill 封装、多 Agent 分析、FastAPI 服务化和系统联调的完整训练链条。

    项目以竞品情报分析为业务场景，围绕价格战、新品发布、负面舆情三大监控维度，构建能够从公开数据源中提取竞品动态、与本企业数据进行结构化对标，并生成竞争态势简报的智能分析系统。报告在版式上保留 Typst 模板的展示能力，包括彩色提示块、结构化表格、模块树和代码片段等元素，便于形成正式提交材料。
  ],
  keywords: "企业实训；Claude Skill；竞品情报；LangChain；RAG；Multi-Agent；FastAPI",
)

= 实习目的和要求

== 实习目的

本次企业实训以“基于 Claude Skill 的竞品动态追踪与智能对标分析系统实战”为综合项目，目标是掌握以 Claude 大模型为智能核心、LangChain 为工程框架的大模型应用开发方法。通过项目训练，我们需要理解 LLM 调用、Prompt Engineering、RAG 检索增强生成、Multi-Agent 协作、FastAPI 服务化和系统部署等完整技术链条。

项目业务目标是构建一套面向企业竞品情报场景的智能分析平台。系统围绕价格战、新品发布、负面舆情三类核心维度，从公开舆情中识别竞品动态，结合本企业基准数据进行对标分析，输出包含机会点、威胁点和行动建议的竞争态势简报。

#report-card("实训目标概览", rgb("#2f6f9f"))[
  本报告按学校实习模板组织内容，重点覆盖实习目的、时间地点、单位部门、实习内容和实习总结五个部分。项目内容参考课程 PDF 和 docs 目录中的工程规范、开发周期表与立项材料，突出 Claude Skill、RAG、Multi-Agent、FastAPI 和竞品情报分析业务链路。
]

#info[
  该项目不是普通聊天机器人，而是围绕公开数据采集、证据检索、结构化对标和简报生成构建的端到端竞品情报系统。
]

== 实习要求

实训过程中，每位同学需要掌握 Claude 模型调用、LangChain 核心模块、RAG 知识库构建、Prompt 模板设计、Claude Skill 描述文件编写、Agent 工具调用和 FastAPI 接口封装等基本能力。项目阶段要求参与竞品主体和监控维度设计、公开舆情数据处理、情报分析链路实现、系统联调测试和成果展示。

同时，项目要求所有竞品分析结论必须绑定原始公开数据源，禁止凭空生成分析结论；API Key、模型地址和 Prompt 模板等关键配置必须统一管理，避免硬编码；团队需按实训要求提交程序员日志、例会记录、立项材料和结项汇报。

= 实习时间、地点

#info-line("时间", "2025年6月30日-2025年7月26日")
#info-line("地点", "南开大学津南校区综合实验楼 A314")

#figure(
  tblr(
    columns: 3,
    header-rows: 1,
    align: (center, center, left),
    rows(within: "header", 0, fill: aqua.lighten(65%), hooks: strong),
    rows(within: "body", calc.even, fill: gray.lighten(86%)),
    cells(((0, 0), end), inset: 7pt),
    hline(y: 0, stroke: 0.8pt),
    hline(y: 1, stroke: 0.5pt),
    hline(y: end, stroke: 0.8pt),
    [阶段], [时间], [主要任务],
    [环境与数据准备], [第 1-5 天], [完成开发环境搭建、竞品列表设定、监控维度规则设计、公开舆情测试数据采集和 RAG 基础向量库搭建],
    [Prompt 与 Agent 基础], [第 6-10 天], [完成竞品情报提取 Prompt、Function Calling 实践、RAG 问答链和项目立项材料],
    [系统开发与联调], [第 11-16 天], [完成 Multi-Agent 开发、LCEL 管道、LangSmith 追踪、FastAPI 接口和前后端联调],
    [测试与交付], [第 17-20 天], [完成全链路测试、Docker 容器化、系统部署演示、最终汇报和交付材料整理],
  ),
  caption: [实习阶段安排],
)

= 实习单位和部门

#info-line("实习单位", "中软国际信息技术有限公司")
#info-line("所属部门", "南开大学软件学院")
#info-line("项目名称", "基于 Claude Skill 的竞品动态追踪与智能对标分析系统实战")

#figure(
  grid(
    columns: (1fr, 2.4fr),
    gutter: 1.2em,
    align: horizon,
    image("./img/NKU-logo.png", width: 85%),
    tip(title: "单位与部门")[
      实习单位承担企业级项目训练，学院负责课程组织与过程管理。本项目以竞品情报分析为业务牵引，综合训练大模型应用开发、工程规范执行、团队协作和成果交付能力。
    ],
  ),
  caption: [实习组织关系示意],
)

= 实习内容

本次实训围绕企业竞品情报分析业务展开。项目以公开舆情数据为输入，以 Claude 大模型和 LangChain 工程框架为核心，构建从数据采集、清洗、向量化、检索增强，到多 Agent 分析、结构化对标和简报生成的完整系统。

在学习准备阶段，我们系统学习了 LLM 基本原理、Claude 模型系列能力边界、LangChain Chains / Agents / RAG / Memory / Callbacks 等核心模块，以及 FastAPI 后端服务开发方法。通过课程讲解和实践任务，我们逐步理解了如何将大模型能力嵌入稳定的软件工程流程。

在项目实现阶段，系统首先需要维护竞品主体和监控规则，围绕价格战、新品发布、负面舆情三大维度配置关键词、阈值和数据源。随后通过 LangChain Document Loaders 或本地导入方式采集公开舆情数据，并完成去重、正文抽取、时间标准化和来源留存。

数据进入 RAG 流程后，系统使用文本分块策略和向量数据库构建竞品情报知识库。分析阶段通过价格监控 Agent、新品检测 Agent、舆情分析 Agent 并行处理检索结果，并借助 LCEL 管道汇总为统一的竞品情报卡片。最后，系统结合本企业基准数据生成 SWOT 对标结果、机会点、威胁点和竞争态势简报。

#report-card("技术栈说明", rgb("#7a8f2a"))[
  系统围绕 Claude 模型、LangChain 编排、RAG 知识库、Claude Skill、多 Agent、FastAPI 服务、前端看板、Docker 部署和 LangSmith 追踪构建。各模块通过明确接口协作，保证情报结论可追踪、可复核、可展示。
]

#figure(
  tblr(
    columns: 3,
    header-rows: 1,
    align: (center, center, left),
    rows(within: "header", 0, fill: green.lighten(70%), hooks: strong),
    rows(within: "body", calc.even, fill: gray.lighten(86%)),
    cells(((0, 0), end), inset: 7pt),
    hline(y: 0, stroke: 0.8pt),
    hline(y: 1, stroke: 0.5pt),
    hline(y: end, stroke: 0.8pt),
    [模块], [技术], [作用],
    [大模型基础], [Claude Haiku / Sonnet / Opus], [分别承担快速摘取、深度对标和复杂简报生成],
    [应用编排], [LangChain / LCEL], [组织 Chains、Agents、Tools、Memory 和分析管道],
    [知识检索], [RAG + Chroma / FAISS], [保存舆情向量索引，支持语义检索和来源溯源],
    [能力封装], [Claude Skill], [沉淀竞品情报分析 Skill、输入规范和结构化输出格式],
    [后端服务], [FastAPI], [封装 RESTful API，支持系统集成和前端调用],
    [观测部署], [LangSmith / Docker], [追踪推理链路、定位问题并支持容器化交付],
  ),
  caption: [项目核心技术栈],
)

#figure(
  tree-list[
    - 竞品情报智能分析系统
      - 竞品配置模块
        - 竞品主体管理
        - 监控维度配置
        - 数据源管理
      - 数据处理模块
        - 公开舆情采集
        - 文本清洗
        - 来源溯源
      - RAG 知识库
        - 文本分块
        - 向量化入库
        - 语义检索
      - 智能分析模块
        - 价格监控 Agent
        - 新品检测 Agent
        - 舆情分析 Agent
      - 简报与看板模块
        - 对标分析
        - 态势简报
        - Agent 推理追踪
  ],
  caption: [项目模块树],
)

```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class AnalysisRequest(BaseModel):
    competitor: str
    dimensions: list[str]
    period: str

@app.post("/analysis/run")
def run_competitor_analysis(request: AnalysisRequest):
    """Run RAG retrieval and multi-agent competitor analysis."""
    return {
        "competitor": request.competitor,
        "dimensions": request.dimensions,
        "status": "queued",
        "output": "intel_cards + benchmark_report",
    }
```

= 实习总结：收获、体会以及实习建议等

回顾整个实习过程，从最初的项目启动、技术学习，到后期的模块开发、接口联调和成果展示，我对大模型应用系统的工程化落地有了更完整的认识。这个项目不仅要求模型能够生成文本，更要求系统具备数据来源、检索证据、推理链路、接口规范和交付材料，才能支撑一个可信的业务场景。

技术方面，我更加熟悉了 Claude API、LangChain 编排、RAG 知识库、多 Agent 协作、Prompt 模板管理和 FastAPI 服务化等内容。业务方面，我认识到竞品情报分析不能只依赖模型主观生成，必须围绕公开数据源、证据引用和结构化对标结果建立可信链路。

团队协作方面，项目让我体会到需求拆解、接口约定、Prompt 统一管理、日志记录和每日例会的重要性。今后类似项目可以在前期进一步明确数据源范围、输出 Schema、测试样例和验收指标，这样能够减少后期联调成本，也能提升最终答辩展示的稳定性。

#report-card("后续建议", rgb("#b56b3b"))[
  建议在实训初期统一竞品主体、监控维度、数据源格式和 Prompt 模板；中期固定接口联调和 LangSmith 追踪节奏；后期补齐测试记录、部署说明、用户手册和简报样例，确保系统可运行、结果可追踪、材料可提交。
]

#success(title: "总结")[
  本报告已围绕“基于 Claude Skill 的竞品动态追踪与智能对标分析系统实战”展开，覆盖学校实习报告要求，并保留 Typst 模板的图表、提示块、代码和模块树展示能力。
]

#pagebreak()

= 参考文献

+ Anthropic. Claude Documentation. #link("https://docs.anthropic.com/")[https://docs.anthropic.com/].
+ LangChain. LangChain Documentation. #link("https://docs.langchain.com/")[https://docs.langchain.com/].
+ FastAPI. FastAPI Documentation. #link("https://fastapi.tiangolo.com/")[https://fastapi.tiangolo.com/].
+ Chroma. Chroma Docs. #link("https://docs.trychroma.com/")[https://docs.trychroma.com/].
+ LangSmith. LangSmith Documentation. #link("https://docs.smith.langchain.com/")[https://docs.smith.langchain.com/].
