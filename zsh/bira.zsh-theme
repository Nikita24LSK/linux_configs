# ZSH Theme - Preview: https://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

function battery_charge {
  # Battery 0: Discharging, 94%, 03:46:34 remaining
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
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi
local git_branch='$(git_prompt_info)%{$reset_color%}'

RPROMPT="${time} %B$(battery_charge)%b"
PROMPT="
${bord_h} ${user_host} ${current_dir}
${bord_l} %B${user_symbol}%b "

