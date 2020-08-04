function battery_charge {
  bat_percent=`acpi | awk -F ':' {'print $2;'} | awk -F ',' {'print $2;'} | sed -e "s/\s//" -e "s/%.*//"`

  if [ $bat_percent -lt 20 ]; then local bat_color='%B%F{red}'
  elif [ $bat_percent -lt 50 ]; then local bat_color='%B%F{yellow}'
  else local bat_color='%B%F{green}'
  fi

  echo  $bat_color$bat_percent%%'%F{default}%b'
}

if [[ $UID -eq 0 ]]; then
	local user_color=red
else
	local user_color=green
fi

local user_host='%B%F{$user_color}%n%F{default}%b'
local user_symbol='%B%F{$user_color}~>%F{default}%b'
time='%B%F{cyan}%*%F{default}%b'

local current_dir='%B%F{blue}%~%F{default}%b'
local git_branch='%B%F{yellow}$(git_prompt_info)%F{default}%b'

PROMPT="
${user_host} ${time} \$(battery_charge) ${current_dir}
${git_branch} ${user_symbol} "

