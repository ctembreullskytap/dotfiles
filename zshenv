export UBUNTU_NAME=xenial
export ANSIBLE_PYTHON_INTERPRETER=/usr/bin/python3
export RAILS_ENV=development

alias srcwfe="cd /var/www/skytap/wfe_dev"
alias srcweb="cd /var/www/skytap/current/web"
alias srcnode="cd /var/www/skytap/current/ui"
if [ -f /usr/local/nvm/nvm.sh ]; then source /usr/local/nvm/nvm.sh; fi

export PATH=/home/vagrant/.rbenv/bin:/home/vagrant/.rbenv/shims:$PATH
export RBENV_ROOT="/home/vagrant/.rbenv"
eval "$(rbenv init -)"

export PATH=/home/vagrant/.evm/scripts/evm:/home/vagrant/.kiex/bin/kiex:$PATH
source /home/vagrant/.evm/scripts/evm && [[ -s "/home/vagrant/.kiex/scripts/kiex" ]] && source "/home/vagrant/.kiex/scripts/kiex"
evm default 20.0 && kiex use elixir-1.6.5 --default

alias skygreps="source ~/skygrep-venv/bin/activate"

export JENKINS_WEB_USER=ctembreull
export JENKINS_WEB_URI="http://10.128.4.1:8080"
export JENKINS_ES_URI="http://10.0.90.1:8080"

alias ll='ls -alF'
alias lh='ls -alh'
alias la='ls -A'
alias l='ls -CF'

alias show_web_log="tail -f /var/log/skytap-web.log"
alias startall="srcwfe && rake service:all:start"
alias stopall="srcwfe && rake service:all:stop"
alias startbase="srcwfe && rake service:push:start && rake service:proxy:start"


# Add an "alert" for long-running commands. Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

