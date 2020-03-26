local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

function battery_charge {
  bat_percent=`acpi | awk -F ':' {'print $2;'} | awk -F ',' {'print $2;'} | sed -e "s/\s//" -e "s/%.*//"`

  if [ $bat_percent -lt 20 ]; then cl='%{$terminfo[bold]$fg[red]%}'
  elif [ $bat_percent -lt 50 ]; then cl='%{$terminfo[bold]$fg[yellow]%}'
  else cl='%{$terminfo[bold]$fg[green]%}'
  fi

  echo  $cl\[$bat_percent%%\]'%F{default}'
}

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m%{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
    local user_symbol='$'
fi

bord_h='%{$terminfo[bold]$fg[yellow]%}┌─%{$reset_color%}'
bord_l='%{$terminfo[bold]$fg[yellow]%}└─>%{$reset_color%}'
time='%{$terminfo[bold]$fg[cyan]%}[%*]%{$reset_color%}'

local current_dir='%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'
local git_branch='%{$terminfo[bold]$fg[red]%}$(git_prompt_info)%{$reset_color%}'

RPROMPT="${time} %B$(battery_charge)%b"
PROMPT="
${bord_h} ${user_host} ${current_dir} ${git_branch}
${bord_l} %B${user_symbol}%b "

