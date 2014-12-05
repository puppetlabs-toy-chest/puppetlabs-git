# Fact: git_exec_path
#
# Purpose: get git's exec path
#
# Resolution:
#   Uses git's --exec-path flag
#
# Caveats:
#   none
#
# Notes:
#   None
Facter.add('git_exec_path') do
  case Facter.value(:osfamily)
  when 'windows'
    setcode 'git --exec-path 2>nul'
  else
    setcode 'git --exec-path 2>/dev/null'
  end
end

