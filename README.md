## CI/CD Pipeline

Простой CI/CD pipeline для сборки и деплоя приложения.

### Что делает

- Сборка Docker-образов backend и frontend
- Пуш в локальный registry
- Деплой на сервер через SSH + docker compose
- Версионирует артефакты (образы) через хэш коммита

### Стек

- GitHub Actions
- Docker
- Self-hosted runner
- Local Docker Registry

### Flow

1. Commit → trigger pipeline
2. Build images (backend, frontend)
3. Push в registry
4. SSH на сервер
5. Обновление контейнеров через docker compose
