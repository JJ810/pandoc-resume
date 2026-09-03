---
title: Jesse Pinzon
subtitle: Senior AI Engineer
pdf-engine: xelatex
shift-heading-level-by: -1
header-includes:
 - \setcounter{secnumdepth}{-1}
---

```{=html}
<p class="contact">Miami, FL | 305-224-0514 | <a href="mailto:jesse.pinzon.813@gmail.com">jesse.pinzon.813@gmail.com</a> | <a href="https://github.com/jj810">github.com/jj810</a></p>
```

```{=latex}
\begin{center}
{\fontsize{9.25}{9.7}\selectfont\color{ResumeContact} Miami, FL \textbar{} 305-224-0514 \textbar{} \href{mailto:jesse.pinzon.813@gmail.com}{jesse.pinzon.813@gmail.com} \textbar{} \href{https://github.com/jj810}{github.com/jj810}\par}
\vspace{6pt}
\end{center}
```

## Professional Summary

```{=latex}
\fontsize{10}{10.5}\selectfont\color{ResumeBody}\setlength{\parskip}{4pt}
```

Senior AI Engineer with 10 years of experience building and operating production machine learning, NLP, and generative AI systems at Microsoft and JPMorgan Chase. Proven record delivering enterprise RAG applications, real-time risk models, scalable inference services, and MLOps platforms that improve model quality, operating cost, and release speed. Hands-on technical leader experienced in architecture, mentoring, responsible AI, security, model governance, and cross-functional delivery.

## Technical Skills

```{=latex}
\fontsize{10}{10.5}\selectfont\color{ResumeBody}\setlength{\parskip}{2.5pt}
```

**Languages:** Python, SQL, Java, Bash

**AI / ML:** PyTorch, scikit-learn, XGBoost, Hugging Face Transformers, NLP, deep learning, ranking, RAG, embeddings, vector and hybrid search, prompt engineering, LLM evaluation, SHAP

**Data Engineering:** Pandas, NumPy, Apache Spark, Databricks, Kafka, Airflow, data quality, feature engineering

**Cloud / MLOps:** Azure Machine Learning, Azure OpenAI Service, Azure AI Search, AKS, AWS SageMaker, S3, EC2, MLflow, Docker, Kubernetes, Terraform, Azure DevOps, Jenkins, CI/CD

**Applications / Monitoring:** FastAPI, Flask, REST APIs, ONNX Runtime, Redis, PostgreSQL, SQL Server, Application Insights, Prometheus, Grafana

**Leadership / Governance:** AI architecture reviews, technical mentoring, responsible AI, model risk management, privacy, security, incident response, Agile delivery

## Professional Experience

```{=latex}
\fontsize{10.5}{11}\selectfont\color{ResumeCompanyMeta}\setlength{\parskip}{1.5pt}
\renewcommand{\textbf}[1]{{\fontsize{10.5}{11}\selectfont\textcolor{ResumeBody}{\bfseries #1}}}
```

**MICROSOFT** — Redmond, WA / Remote

```{=latex}
\nopagebreak
\fontsize{10}{10.5}\selectfont\color{ResumeBody}
```

**Senior AI Engineer** · *Sep 2023 – Present*

- Lead **AI/ML system design** and delivery for a six-engineer squad building enterprise **Generative AI, LLM-powered, and NLP** assistants; own **architecture, engineering standards**, roadmap execution, and alignment with product, security, privacy, and applied research.
- Architected a **multi-tenant RAG platform** with **Azure OpenAI Service**, **Azure AI Search hybrid/vector retrieval**, Semantic Kernel, FastAPI, Redis, and **AKS/Kubernetes**; adopted across multiple internal teams and reduced median time to find approved technical content by 37%.
- Established offline and online **LLM evaluation, prompt testing, and guardrails** covering **retrieval recall@k, groundedness, answer relevance, refusal behavior**, safety, latency, and cost; raised the grounded-answer pass rate from 78% to 91% and cut reported hallucination incidents by 40%.
- Optimized **LLM inference and model serving** through **model routing, token budgeting, semantic caching, batching, and autoscaling**; reduced p95 latency by 31% and cost per request by 27% while maintaining 99.9% availability.
- Standardized **MLOps/LLMOps, CI/CD, infrastructure as code**, model and prompt versioning, canary deployment, and observability with **Azure DevOps, Terraform, MLflow, Application Insights, and Prometheus**; shortened release lead time from 15 business days to 5.
- Mentor five engineers, lead **system design, architecture, and code reviews**, and maintain reusable **AI reference architectures** adopted by three product teams; promoted from AI Engineer after two years of sustained **technical leadership** and delivery.

**AI Engineer** · *Sep 2021 – Aug 2023*

- Built **deep learning and NLP pipelines** for document classification and semantic search using **Python, PyTorch, Hugging Face Transformers**, **Azure Machine Learning, Azure Cognitive Search, and ONNX Runtime**; improved top-5 relevance by 18% and reduced manual case routing by 32%.
- Productionized and deployed **NLP model APIs** as **Dockerized microservices on AKS/Kubernetes** with **MLflow, Azure DevOps, and API Management**; scaled to millions of monthly inference requests with 99.9% availability and sub-200 ms p95 latency.
- Engineered **data pipelines** and **active-learning/weak-labeling workflows** in **Databricks and Apache Spark**; reduced manually labeled examples by 35% while keeping F1 within one percentage point of the fully supervised baseline.
- Optimized **deep learning inference** with **ONNX Runtime quantization and batching**, reducing CPU inference time by 43% and hosting cost by 22% without material loss in F1.
- Partnered with data scientists to convert experimental notebooks into tested **production Python services with automated model/data monitoring and rollback controls**.

```{=latex}
\vspace{2pt}
\Needspace{14\baselineskip}
\fontsize{10.5}{11}\selectfont\color{ResumeCompanyMeta}
\renewcommand{\textbf}[1]{{\fontsize{10.5}{11}\selectfont\textcolor{ResumeBody}{\bfseries #1}}}
```

**JPMORGAN CHASE & CO.** — Tampa, FL

```{=latex}
\nopagebreak
\fontsize{10}{10.5}\selectfont\color{ResumeBody}
```

**Machine Learning Engineer** · *Aug 2018 – Aug 2021*

- Designed a **near-real-time ML risk-scoring system** using **Python, XGBoost, Spark Structured Streaming, Kafka, Java services, and Kubernetes**; processed 3,500+ events per second and reduced false-positive alerts by 23% while holding fraud recall constant.
- Built and evolved model training, validation, registry, and deployment pipelines with **Airflow, SageMaker, S3, Docker, Jenkins,** and **later MLflow**; cut the validation-to-production cycle from six weeks to two and strengthened reproducibility and auditability.
- Implemented **production model monitoring**, **data-quality, drift, bias, and explainability controls** using **population stability index, Kolmogorov-Smirnov tests, SHAP, and champion/challenger analysis**; reduced model-related incidents by 28%.
- Led a four-engineer **system modernization** workstream migrating **nightly batch scoring to near-real-time services**; coordinated **architecture and delivery** across fraud operations, compliance, cybersecurity, and platform engineering.
- Mentored three junior engineers and established **code review, model validation, and release-readiness standards** adopted by two fraud analytics squads.

**Software Engineer – Machine Learning** · *Aug 2016 – Jul 2018*

- Built scalable **Python, SQL, and Apache Spark** **data pipelines and feature-engineering workflows** across 5+ TB of transaction and customer data; reduced end-to-end preparation time from 9 hours to 3.5 hours.
- Developed and evaluated **supervised machine learning models** using **logistic regression, random forest, XGBoost, and scikit-learn**; improved fraud ROC-AUC from 0.91 to 0.94 and reduced manual review volume by 12%.
- Deployed **model inference through Flask REST APIs and batch-scoring jobs**; added **unit and integration tests** and automated controlled builds and releases with **Jenkins CI/CD**.
- Automated **model performance monitoring** and monthly reporting for risk and compliance stakeholders, eliminating approximately 20 hours of recurring manual work per reporting cycle.

## Education

```{=latex}
\fontsize{10}{10.5}\selectfont\color{ResumeEduSecondary}\setlength{\parskip}{1pt}
\renewcommand{\textbf}[1]{\textcolor{ResumeBody}{\bfseries #1}}
```

**Bachelor of Science in Computer Science** — Florida International University, Miami, FL · May 2016

```{=latex}
\color{ResumeBody}
```

Relevant coursework: Artificial Intelligence, Machine Learning, Data Mining, Data Structures and Algorithms, Databases, Probability and Statistics, Linear Algebra, and Software Engineering.
