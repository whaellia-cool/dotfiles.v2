#!/bin/bash
# conky-toggle — включает/выключает Conky
# Работает с любым количеством экземпляров Conky
# Можно привязать к горячей клавише (Super+C, например)

# Путь к твоему основному конфигу Conky (измени, если нужно!)
CONKY_CONFIG="$HOME/.config/conky/conky.conf"
# Если у тебя несколько конфигов — можно указать массив:
# CONKY_CONFIGS=("$HOME/.config/conky/main.conf" "$HOME/.config/conky/clock.conf")

# Альтернатива: если хочешь запускать просто "conky" без -c (использует ~/.conkyrc по умолчанию)
# CONKY_CONFIG=""

# Проверяем, запущен ли хоть один conky
if pgrep -x conky > /dev/null; then
    echo "Conky запущен → выключаем..."
    killall conky
    # Если нужно убить жёстко (редко требуется):
    # killall -9 conky
else
    echo "Conky выключен → запускаем..."
    if [ -n "$CONKY_CONFIG" ] && [ -f "$CONKY_CONFIG" ]; then
        conky -c "$CONKY_CONFIG" & disown
    else
        # Просто conky (берёт ~/.conkyrc)
        conky & disown
    fi

    # Вариант для нескольких конфигов (раскомментируй, если нужно):
    # for cfg in "${CONKY_CONFIGS[@]}"; do
    #     [ -f "$cfg" ] && conky -c "$cfg" & disown
    # done
fi

exit 0
