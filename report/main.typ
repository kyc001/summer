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
    本报告围绕企业实训课程中的求职规划助手项目展开，按照学校本科实习报告模板梳理实习目的和要求、实习时间地点、实习单位和部门、实习内容以及实习总结等核心内容。报告结合项目实践过程，记录了从开发环境配置、基础技术学习，到岗位数据检索、向量推荐、接口封装和团队联调的完整训练链条。

    在版式上，模板保留 demo.typ 中较强的展示能力，包括学校标识、彩色提示块、结构化表格、模块树和代码片段等元素；同时新增摘要、目录和参考文献，便于正式提交时形成更加完整的学术报告结构。
  ],
  keywords: "企业实训；求职规划助手；LangChain；FastAPI；向量检索",
)

= 实习目的和要求

== 实习目的

这次企业实训分为两个阶段。前期主要进行知识学习和小项目练习，目标是熟悉大模型应用开发流程、LangChain 的基本用法，以及前后端协作机制。通过这些基础训练，我们逐步掌握了从数据处理、模型调用到 API 封装的完整开发链条。

后期进入综合项目阶段，围绕“求职规划助手”进行分工合作，完成职位搜索、简历生成、HR 模拟和面试安排等模块。整个过程不仅提升了技术能力，也锻炼了团队协作、项目管理和系统思维。

#report-card("实训目标概览", rgb("#2f6f9f"))[
  本报告按学校实习模板组织内容，重点覆盖实习目的、时间地点、单位部门、实习内容和实习总结五个部分。版式表现力参考 demo.typ，保留图注、彩色提示块、结构化表格、代码片段和树状流程等常用报告元素。
]

#info[
  后续正式写作时，可以把这里扩展为课程背景、个人目标、团队目标和项目交付要求。
]

== 实习要求

实训过程中，每位同学需要掌握 LangChain、FastAPI、ChromaDB 等核心工具的基本使用方法，并能独立完成一个小模块的开发。项目阶段要求参与需求分析、模块实现、联调测试和答辩展示，确保个人工作能够顺利接入团队系统。

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
    [准备学习], [第 1-2 周], [完成环境配置、LangChain 入门、小项目练习和接口调用训练],
    [综合开发], [第 3-4 周], [围绕求职规划助手开展模块开发、联调测试和项目答辩],
  ),
  caption: [实习阶段安排],
)

= 实习单位和部门

#info-line("实习单位", "中软国际信息技术有限公司")
#info-line("所属部门", "南开大学软件学院")
#info-line("项目名称", "基于多 Agent 多阶段流程的求职规划助手")

#figure(
  grid(
    columns: (1fr, 2.4fr),
    gutter: 1.2em,
    align: horizon,
    image("./img/NKU-logo.png", width: 85%),
    tip(title: "单位与部门")[
      实习单位承担企业级项目训练，学院负责课程组织与过程管理。正式报告中可以继续补充企业简介、部门职责、个人分工和项目背景。
    ],
  ),
  caption: [实习组织关系示意],
)

= 实习内容

本次实训围绕人工智能在实际业务场景下的创新应用展开。项目以真实企业级任务为主线，贯穿人工智能工程应用、软件系统开发、团队协作和职业素养提升等多重目标，较为完整地还原了软件项目研发过程中的工作场景。

在学习准备阶段，我们系统学习了大语言模型原理、LangChain 框架、FastAPI 服务开发、前端交互以及数据库基本操作。通过教师讲解和实践任务，我们逐步熟悉了开发环境、接口调用方式和团队协作流程，为后续项目开发打下基础。

在项目开发阶段，我主要参与职位搜索与数据存储相关模块。该模块需要完成岗位数据采集、清洗、结构化存储、语义向量化和检索接口封装。系统使用关系型数据库保存结构化字段，同时使用向量数据库支持语义检索与智能推荐，从而兼顾传统筛选和大模型语义理解能力。

开发过程中，我重点关注数据表设计、接口规范、检索效率和异常处理。通过分批写入、索引设计、接口参数校验和日志记录，模块能够较稳定地支撑分页查询、条件检索和相似职位推荐等业务需求。

#report-card("技术栈说明", rgb("#7a8f2a"))[
  系统围绕后端 API、前端交互、关系型数据库、向量数据库和大模型服务构建。不同组件通过清晰接口协作，便于模块独立开发和后续维护。
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
    [后端服务], [FastAPI], [提供职位检索、推荐和数据管理接口],
    [应用编排], [LangChain], [组织模型调用、工具调用和链式流程],
    [结构化存储], [SQLite], [保存职位、公司、搜索历史等结构化数据],
    [语义检索], [ChromaDB], [存储 embedding 并支持相似职位推荐],
    [前端展示], [Vue3 / Streamlit], [提供交互式页面和调试界面],
  ),
  caption: [项目核心技术栈],
)

#figure(
  tree-list[
    - 智能求职规划助手
      - 职位搜索模块
        - 数据采集
        - SQL 检索
        - 向量推荐
      - 简历生成模块
      - HR 模拟模块
      - 面试安排模块
  ],
  caption: [项目模块树],
)

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/jobs/search")
def search_jobs(keyword: str, location: str | None = None):
    """Return structured results and semantic recommendations."""
    return {
        "keyword": keyword,
        "location": location,
        "source": "sqlite + chromadb",
    }
```

= 实习总结：收获、体会以及实习建议等

回顾整个实习过程，从最初的系统学习、项目立项，到后期的技术攻关、模块集成和答辩展示，我获得了宝贵的工程实践经验。这段经历让我将课堂中学习到的软件工程方法、数据库知识和人工智能应用真正放到一个完整项目中验证和吸收。

技术方面，我更加熟悉了现代 Web 服务开发、大模型应用集成、数据库设计和向量检索等内容。团队协作方面，我也体会到需求沟通、接口约定、文档维护和进度同步对项目落地的重要性。

今后类似实习项目可以在前期进一步加强需求拆解和接口设计，尽早明确模块边界、数据格式和测试标准。这样既能减少后续联调成本，也能让团队成员更清楚各自工作的上下游关系。

#report-card("后续建议", rgb("#b56b3b"))[
  建议在实习初期统一项目文档、接口规范和测试标准；在项目中期固定周会与代码评审节奏；在项目后期补齐部署说明、用户手册和复盘材料。
]

#success(title: "总结")[
  这份模板既覆盖学校实习报告要求，也保留实验报告模板的展示能力。后续只需要替换封面信息、扩写各节正文，并按实际项目补充图表即可。
]

#pagebreak()

= 参考文献

+ LangChain. LangChain Documentation. #link("https://docs.langchain.com/")[https://docs.langchain.com/].
+ FastAPI. FastAPI Documentation. #link("https://fastapi.tiangolo.com/")[https://fastapi.tiangolo.com/].
+ Chroma. Chroma Docs. #link("https://docs.trychroma.com/")[https://docs.trychroma.com/].
+ SQLite. SQLite Documentation. #link("https://sqlite.org/docs.html")[https://sqlite.org/docs.html].
