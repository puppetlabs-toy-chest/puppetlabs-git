# Fact: git_html_path
#
# Purpose: get git's html path
#
# Resolution:
#   Uses git's --html-path flag
#
# Caveats:
#   none
#
# Notes:
#   None
Facter.add('git_html_path') do
  case Facter.value(:osfamily)
  when 'windows'
    setcode 'git --html-path 2>nul'
  else
    setcode 'git --html-path 2>/dev/null'
  end
end

