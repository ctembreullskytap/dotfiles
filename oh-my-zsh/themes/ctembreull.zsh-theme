local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

alias hgi='hg incoming'
alias hgl='hg pull -u'

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg_bold[magenta]%}hg:(%{$fg[red]%}"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg_bold[red]%}✘"
ZSH_THEME_HG_PROMPT_CLEAN="%{$fg_bold[green]%} "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✘"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[yellow]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}"


if [ "x$OH_MY_ZSH_HG" = "x" ]; then
  OH_MY_ZSH_HG="hg"
fi

function in_hg {
  if [[ -d .hg ]] || $(hg summary > /dev/null 2>&1); then
    echo 1
  fi
}

function in_git {
  if [[ -d .git ]] ||
}

function hg_dirty_choose {
  if [ $(in_hg) ]; then
    hg status 2> /dev/null | command grep -Eq '^\s*[ACDIM!?L]'
    if [ $pipestatus[-1] -eq 0 ]; then
      # Grep exits with 0 when "One or more lines were selected", return "dirty".
      echo $1
    else
      # Otherwise, no lines were found, or an error occurred. Return clean.
      echo $2
    fi
  fi
}

function hg_dirty {
  hg_dirty_choose $ZSH_THEME_HG_PROMPT_DIRTY $ZSH_THEME_HG_PROMPT_CLEAN
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo ' ❯'
}

function hg_get_repo_name {
  if [ $(in_hg) ]; then
    GRANDDADDY=$(cd ../; pwd)
    if [ -L $GRANDDADDY ]; then
      REPO=$(readlink "$GRANDDADDY")
    else
      REPO=$(basename "$GRANDDADDY")
    fi
  fi
  echo "$REPO"
}

function hg_get_branch_name() {
  if [ $(in_hg) ]; then
    echo $(hg branch)
  fi
}

function hg_get_current_patch_name() {
  if [ $(in_hg) ]; then
    echo $(hg qtop)
  fi
}

function hg_patch_info {
  DEFAULT_PROMPT="%{$fg_bold[black]%}No patches%{$reset_color%}"
  if [ $(in_hg) ]; then
    PATCH_LIST=$(hg prompt --angle-brackets "<patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_applied(%{$reset_color%})>")
  fi
  if [ -z $PATCH_LIST ]; then
    echo $DEFAULT_PROMPT
  else
    echo $PATCH_LIST
  fi
}

function hg_prompt_info {
  if [ $(in_hg) ]; then
    echo "%{$fg_bold[magenta]%}$OH_MY_ZSH_HG:%{$reset_color%}(%{$fg_bold[red]%}$(hg_get_repo_name)%{$reset_color%}/%{$fg[green]%}$(hg_get_branch_name)%{$reset_color%})\n   $(hg_patch_info)%{$reset_color%}"
  fi
}

PROMPT='
${ret_status} %{$fg_bold[yellow]%}%n@%m%{$reset_color%} %{$fg[cyan]%}%2C%{$reset_color%} $(git_prompt_info)$(hg_prompt_info)
$(hg_dirty)$(prompt_char)%{$reset_color%} '
