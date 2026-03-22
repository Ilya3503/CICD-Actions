#!/bin/bash

# Адрес вашего локального registry
REGISTRY=192.168.136.10:5000
# Название репозитория внутри registry
REPO=devops-cicd-demo
# Количество последних версий, которые оставляем
KEEP_LAST=3

# Функция для удаления старых образов
cleanup() {
  local image=$1
  echo "Cleaning old tags for $image..."

  # Получаем все теги, сортируем по алфавиту (reverse = последние версии первыми), оставляем только последние KEEP_LAST
  TAGS=$(curl -s http://$REGISTRY/v2/$REPO/$image/tags/list | jq -r ".tags | sort | reverse | .[$KEEP_LAST:] // empty")

  for tag in $TAGS; do
    echo "Deleting $image:$tag"
    # Получаем digest, чтобы можно было удалить
    DIGEST=$(curl -s -I -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
      "http://$REGISTRY/v2/$REPO/$image/manifests/$tag" | grep Docker-Content-Digest | awk '{print $2}' | tr -d $'\r')
    if [ ! -z "$DIGEST" ]; then
      curl -X DELETE "http://$REGISTRY/v2/$REPO/$image/manifests/$DIGEST"
    fi
  done
}

# Удаляем старые backend образы
cleanup backend

# Удаляем старые frontend образы
cleanup frontend