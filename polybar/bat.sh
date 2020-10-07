#!/bin/bash

perc_str=$(acpi | grep -Eo "[0-9]{1,3}%")
perc_num=$(echo $perc_str | grep -Eo "[0-9]{1,3}")
status=$(acpi | grep -Eo "Charging|Discharging|Full")

icon="null"
if [ $status == "Charging" ]; then icon=" ";
elif ((perc_num >= 90)); then icon=" ";
elif ((perc_num >= 60)); then icon=" ";
elif ((perc_num >= 40)); then icon=" ";
elif ((perc_num >= 20)); then icon=" "
else icon=" ";
fi

if [ $status == "Discharging" ] && ((perc_num < 10)); then notify-send -t 2000 -i dialog-warning "Внимание!" "Низкий уровень заряда!";
elif ([ $status == "Charging" ] || [ $status == "Full" ]) && ((perc_num > 90)); then notify-send  -t 2000 -i dialog-info "Зарядка завершена!";
fi

echo "$icon$perc_str"
