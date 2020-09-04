#!/bin/bash

status_en=$(acpi | grep -Eo "Charging|Discharging")
time_str=$(acpi | grep -Eo "[0-9]*:[0-9]*:[0-9]*")

status_ru="Null"

if [ $status_en == "Charging" ]; then status_ru="Заряжается";
else status_ru="Разряжается";
fi

notify-send -t 1500 -i dialog-info "$status_ru" "Осталось $time_str"
