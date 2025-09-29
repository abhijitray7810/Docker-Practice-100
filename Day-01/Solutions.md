# 365-Day DevOps Journey 🚀

> Consistency beats intensity—one small experiment every day for a year.

---

## 📌 Overview
This repo logs my daily DevOps practice.  
Each folder is one day; each commit is a 30-minute hands-on sprint.  
Tools, commands, successes and failures are all pushed here so you can copy-paste, laugh, improve or roast.

---

## 📆 Quick Stats
| Metric        | Value |
|---------------|-------|
| Days done     | 51    |
| Days left     | 314   |
| Clouds broken | 3     |
| Coffee mugs   | 71    |

---

## 🗂️ Repo Layout
```
.
├── day-001  # initial Git + GitHub setup
├── day-002  # Markdown linting with pre-commit
...
├── day-051  # Docker multi-stage + BuildKit cache mounts
└── README.md
```

Inside every `day-XXX` folder:
- `README.md` – what I tried, what broke, what I learned
- `assets/` – screenshots, logs, yaml samples
- `Makefile` – one-command replay of the experiment (where possible)

---

## 🧰 Tool-chain so far
- **OS**: Ubuntu 22.04 LTS & CentOS 7
- **IaC**: Terraform, Ansible
- **CI/CD**: GitLab-CI, GitHub Actions
- **Containers**: Docker, BuildKit, dive
- **Orchestration**: Kubernetes (k3d), Helm, Argo CD
- **Monitoring**: Prometheus, Grafana, Alertmanager
- **Cloud**: AWS free tier (VPC, EC2, IAM, S3, RDS)

---

## 🏃‍♂️ Day 51 Highlights
| Task | Before | After |
|------|--------|-------|
| Image size | 138 MB | 23 MB |
| Build time (no cache) | 2 m 14 s | — |
| Build time (cache mount) | — | 37 s |

**Trick:**  
```dockerfile
RUN --mount=type=cache,target=/var/cache/apt \
    apt update && apt install -y nginx
```

---

## 🎯 Tomorrow
- Convert the same pipeline into a Kubernetes Job
- Let Argo CD auto-sync the new image tag
- Try `kustomize` image transformer for the first time

---

## 🤝 How to use this repo
1. Clone it
2. Pick any day, `cd` in, run `make` (or copy the commands)
3. Open an issue or PR if you spot a better way

---

## 📜 License
MIT – do whatever you want, just don't blame me if you blow up prod 😉

---

**Keep shipping, keep learning!**  
Happy hacking 🖤
```
