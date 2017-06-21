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
  if Facter.value(:git_version)
    null_path = case Facter.value(:osfamily)
                when 'windows'
                  'nul'
                else
                  '/dev/null'
                end
    git_exec_path_cmd = "git --exec-path 2>#{null_path}"
    setcode do
      Facter::Util::Resolution.exec(git_exec_path_cmd)
    end
  end
end
