#!/bin/bash

# Проверяем, передан ли аргумент (путь к папке)
if [ $# -eq 0 ]; then
    echo "Ошибка: Укажите папку для бэкапа."
    echo "Пример: $0 /etc/nginx"
    exit 1
fi

SOURCE_DIR="$1"

# Проверяем, существует ли папка
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Ошибка: Папка '$SOURCE_DIR' не найдена!"
    exit 1
fi

echo "Начинаю бэкап папки: $SOURCE_DIR"

# 1. Создаем папку для бэкапов, если её нет (-p не выдаст ошибку, если она уже есть)
BACKUP_DIR="/tmp/backups"
mkdir -p "$BACKUP_DIR"

# 2. Получаем только имя папки (без полного пути) для красивого имени архива
DIR_NAME=$(basename "$SOURCE_DIR")

# 3. Генерируем дату для уникального имени файла
DATE=$(date '+%Y-%m-%d_%H-%M-%S')

# 4. Формируем итоговое имя архива
ARCHIVE_NAME="${DIR_NAME}_backup_${DATE}.tar.gz"

# 5. Создаем архив
# -c (create) -z (gzip) -f (file) -C (перейти в папку перед архивацией)
tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" -C "$(dirname "$SOURCE_DIR")" "$DIR_NAME"

echo "Архив успешно создан: $BACKUP_DIR/$ARCHIVE_NAME"

# Удаляем архивы, которые старше 7 дней (по времени изменения файла)
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +7 -delete
