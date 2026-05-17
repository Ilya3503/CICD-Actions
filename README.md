# CI/CD Pipeline (GitHub Actions + Self-hosted Runner)

### Архитектура

```
GitHub repo
    │  push в main
    ▼
Self-hosted Runner ──► Docker build ──► Local Registry (192.168.136.12:5000)
                                                │
                                                │ docker pull
                                                ▼
                                        Prod-сервер (192.168.136.11)
                                        docker compose up -d
```

### Что делает пайплайн

1. **Build** — собирает образы backend и frontend, тегирует двумя тегами: `:${{ github.sha }}` (для отката) и `:latest` (для удобства).
2. **Push** — пушит оба тега в локальный registry.
3. **Deploy** — по SSH тянет нужный образ на прод-сервер, перезапускает контейнеры через `docker compose --force-recreate`.