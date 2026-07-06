# 基于 Claude Skill 的竞品动态追踪与智能对标分析系统

本项目是企业实训项目，目标是构建一个竞品情报智能分析系统：从公开舆情数据中采集竞品动态，围绕价格战、新品发布、负面舆情三类维度进行结构化解析，通过 Claude + LangChain + RAG + Multi-Agent 生成情报卡片、风险提示和竞争态势简报。

## 项目信息

- 项目名称：基于 Claude Skill 的竞品动态追踪与智能对标分析系统实战
- 项目类型：企业实训小组项目
- 当前本地开发者：柯云超（2413575）
- 技术路线：Claude API、LangChain、Claude Skill、RAG、Multi-Agent、FastAPI、Chroma/FAISS
- 当前阶段：第 1 天，完成项目说明、技术设计、工程规范和初始开发环境搭建

## 目录结构

```text
competitor-intel-system/
├── main.py                  # FastAPI 服务入口
├── modules/                 # 核心业务模块
│   ├── agents.py            # 价格、新品、舆情 Agent 基础结构
│   ├── prompts.py           # Prompt 模板集中管理
│   ├── rag_chain.py         # RAG 文档加载与检索占位实现
│   └── utils.py             # 通用工具函数
├── data/
│   ├── raw/                 # 原始公开舆情数据
│   ├── processed/           # 清洗后的结构化数据
│   └── reports/             # 生成的竞争态势简报
├── chroma_db/               # 向量数据库持久化目录
├── docs/                    # 项目文档、日志、规范和周期表
├── report/                  # 实习报告与需求规格说明书
├── summer_env/              # Claude API 连通性检查脚本
├── .env.example             # 环境变量模板
├── pyproject.toml           # Python 依赖配置
└── verify_env.py            # Claude + LangChain pipe 连通性测试
```

## 环境配置

1. 安装基础环境：

   ```powershell
   uv sync --python 3.11
   ```

2. 复制并填写环境变量：

   ```powershell
   Copy-Item .env.example .env
   ```

   至少需要配置：

   ```dotenv
   ANTHROPIC_API_KEY=your-api-key
   ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
   ANTHROPIC_MODEL=deepseek-v4-flash
   ```

3. 运行连通性测试：

   ```powershell
   uv run python verify_env.py
   ```

## 今日环境检查结果

执行命令：

```powershell
uv run python verify_env.py
```

检查结果：

- Claude/Anthropic 兼容接口已连通。
- Base URL：`https://api.deepseek.com/anthropic`
- 模型：`deepseek-v4-flash`
- LangChain pipe：`prompt | llm | parser` 调用成功。
- API Key 已通过 `.env` 读取，文档不记录明文密钥。

## 运行服务

安装依赖后可启动 FastAPI：

```powershell
uv run uvicorn main:app --reload
```

常用接口：

- `GET /health`：服务健康检查
- `POST /analysis/run`：运行竞品分析占位流程

请求示例：

```json
{
  "competitor": "竞品A",
  "dimensions": ["price", "product", "sentiment"],
  "period": "today"
}
```

## 当前已完成

- 梳理竞品情报系统业务功能。
- 编写 Claude + LangChain + Multi-Agent + RAG + FastAPI 五层架构说明。
- 明确竞品配置、舆情采集、三类 Agent、风险预警、报告生成、知识库和可视化接口等核心模块。
- 制定迭代开发、小组敏捷协作和分阶段交付模式。
- 明确目录结构、安全规范、Prompt 管理、数据规范、代码规范和文档规范。
- 搭建 Python 虚拟环境和 `.env` 配置。
- 完成 Claude API 连通性测试。
- 创建 `main.py`、`modules/`、`data/`、`chroma_db/` 等项目骨架。

## 后续计划

- 补充公开舆情测试数据。
- 完成数据清洗、来源留存和结构化解析逻辑。
- 接入 Chroma 或 FAISS，构建 RAG 向量知识库。
- 实现价格监控 Agent、新品检测 Agent、负面舆情 Agent。
- 封装 Claude Skill 描述文件和结构化输出 Schema。
- 完成 FastAPI 核心接口、报告生成和前端可视化对接。
