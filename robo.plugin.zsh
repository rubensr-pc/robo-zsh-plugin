#compdef _robo robo

# Zsh completion script for Robo.
#
# version: 0.1.0
# github:  https://github.com/rubensr-pc/robo-zsh-plugin
#
# To make things faster:
# zstyle ':completion::*:robo:*:' use-cache on

function _robo {
  local curcontext="$curcontext" state line
  integer ret=1
  typeset -A opt_args

  _arguments -C \
    '--raw[output raw command help]' \
    '(-)'{-h,--help}'[display help message]' \
    '(-q --quiet)'{-q,--quiet}'[quiet]' \
    '(-)'{-V,--version}'[display version]' \
    '(--no-ansi)--ansi[force ANSI output]' \
    '(--ansi)--no-ansi[disable ANSI output]' \
    {-n,--no-interaction}'[no interaction]' \
    '--simulate[show what would happen]' \
    '(-vv -vvv --verbose)-v[normal verbosity]' \
    '(-v -vvv --verbose)-vv[more verbose]' \
    '(-v -vv)'{-vvv,--verbose}'[debug]' \
    '--format=[output format]:format:->formats' \
    '--progress-delay=[number of seconds to show progress bar]' \
    '1: :->cmd' \
    '*:: :->help-or-argument'

  case $state in
    formats)
      _values 'formats' txt xml json md && ret=0
      ;;
    cmd)
      _robo_get_command_list && ret=0
      ;;
    help-or-argument)
      curcontext=${curcontext%:*:*}:robo-${words[1]//:/_}:
      case $words[1] in
        help)
          _robo_get_command_list && ret=0
          ;;
        *)
          _files && ret=0
          ;;
      esac
      ;;
  esac

  return ret
}

#(( $+functions[_robo_cache_policy] )) ||
function _robo_cache_policy() {
  typeset -a old

  [[ RoboFile.php -nt "$1" ]] && return 0

  # cache for a week
  old=( "$1"(Nm+7) )
  (( $#old )) && return 0

  return 1
}

#(( $+functions[_robo_get_command_list] )) ||
function _robo_get_command_list {
  local cache_policy

  zstyle -s ":completion::complete:robo::" cache-policy cache_policy
  if [[ -z "$cache_policy" ]]; then
    zstyle ":completion::complete:robo::" cache-policy _robo_cache_policy
  fi

  if type "robo" &> /dev/null && [[ -f RoboFile.php ]]; then
    local cacheid="robo:${PWD//\//_}"
    if _cache_invalid "$cacheid" || ! _retrieve_cache "$cacheid"; then
      setopt extendedglob
      local -a lines cmds
      lines=(${(f)"$(_call_program list-commands robo list 2>&1)"})
      lines=(${(M)${lines[$((${lines[(i)*commands:]} + 1)),-1]}:# *})
      cmds=(${${${lines##([[:space:]]##)}%%[[:space:]]*}//:/\\:})
      _store_cache "$cacheid" cmds
    fi
    _describe -t robo-commands 'robo command' cmds
  fi
}

# Local Variables:
# mode: Shell-Script
# sh-indentation: 2
# indent-tabs-mode: nil
# sh-basic-offset: 2
# End:
# vim: ft=zsh sw=2 ts=2 et
