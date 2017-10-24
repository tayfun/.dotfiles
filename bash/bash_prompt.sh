#!/bin/bash -x
#
# DESCRIPTION:
#
#   Set the bash prompt according to:
#    * the active virtualenv
#    * the branch/status of the current git repository
#
# LINEAGE:
#
#   Based on work by woods
#   https://gist.github.com/31967
#   
#   and insin:
#   https://gist.github.com/insin/1425703

# The various escape codes that we can use to color our prompt.
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[1;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[1;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

# Determine the branch/state information for this git repository.
function set_git_branch {
  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"
  if [ ! $? -eq 0 ]; then
    BRANCH=''
    return
  fi 

  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "working tree clean" ]]; then
    state="${LIGHT_GREEN}✓"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}○"
  else
    state="${LIGHT_RED}✗"
  fi

  # Get the name of the branch.
  branch_pattern="^(# )?On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[2]}
  fi

  # Set the final branch string.
  BRANCH="${LIGHT_GREEN}| ${branch} ${state} ${LIGHT_GREEN}|"
}

# Determine active Python virtualenv details.
function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
    PYTHON_VIRTUALENV=""
  else
    PYTHON_VIRTUALENV="(`basename \"$VIRTUAL_ENV\"`) "
  fi
}

# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PYTHON_VIRTUALENV variable.
  set_virtualenv

  # Set the BRANCH variable.
  set_git_branch

  # Set the bash prompt variable.
  # \w is current working directory. See: http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html
  if [ -n "${BRANCH}" ]; then
    PS1="${LIGHT_GREEN}\w ${LIGHT_RED}${PYTHON_VIRTUALENV}${BRANCH}
${BLUE}\$${COLOR_NONE} "
  else
    PS1="${LIGHT_GREEN}\w ${LIGHT_RED}${PYTHON_VIRTUALENV}${BLUE}\$${COLOR_NONE} "
  fi
}

# To test this uncomment following line.
# set_bash_prompt
# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
