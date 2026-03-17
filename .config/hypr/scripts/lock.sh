#!/usr/bin/env bash

# lock.sh — с отладкой

WALL_DIR="$HOME/.config/hypr/Pupsiki"
LAST="$HOME/.last_wallpaper"
TARGET="$HOME/.cache/hyprlock-bg"
FALLBACK="$WALL_DIR/fallback.jpg"          # поменяй на eso1.jpg или любое существующее, если fallback.jpg нет

echo "=== DEBUG: lock.sh started ===" >&2

# 1. Проверяем существование и размер .last_wallpaper
if [ -s "$LAST" ]; then
    echo "  OK: $LAST существует и не пустой (size > 0)" >&2
    raw_content=$(cat "$LAST")
    echo "  Сырое содержимое файла: '$raw_content'" >&2

    filename=$(echo "$raw_content" | tr -d '[:space:]\n\r\t')
    echo "  После очистки: filename='$filename'" >&2

    if [ -z "$filename" ]; then
        echo "  ОШИБКА: после tr filename пустой → fallback" >&2
        ln -sf "$FALLBACK" "$TARGET"
    else
        full_path="$WALL_DIR/$filename"
        echo "  Проверяем существование: $full_path" >&2
        if [ -f "$full_path" ]; then
            echo "  OK: файл существует → создаём ссылку" >&2
            ln -sf "$full_path" "$TARGET"
        else
            echo "  ОШИБКА: файл НЕ существует ($full_path) → fallback" >&2
            ln -sf "$FALLBACK" "$TARGET"
        fi
    fi
else
    echo "  ОШИБКА: $LAST НЕ существует или пустой → fallback" >&2
    ln -sf "$FALLBACK" "$TARGET"
fi

# Финальная проверка: что в итоге в ссылке?
if [ -L "$TARGET" ]; then
    real_path=$(readlink -f "$TARGET")
    echo "  Итоговая ссылка: $TARGET → $real_path" >&2
    if [ -f "$real_path" ]; then
        echo "  OK: реальный файл существует" >&2
    else
        echo "  ПИЗДЕЦ: ссылка битая!" >&2
    fi
else
    echo "  ОШИБКА: $TARGET не является ссылкой!" >&2
fi

echo "=== DEBUG end ===" >&2

hyprlock
