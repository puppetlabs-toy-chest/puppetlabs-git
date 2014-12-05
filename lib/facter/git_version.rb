output = %x{git --version 2>&1}

if $?.exitstatus and output.match(/git version ((\d+\.){2,}\d+).*/)
  Facter.add('git_version') do
    setcode do
      $1
    end
# Fact: git_version
#
# Purpose: get git's current version
#
# Resolution:
#   Uses git's --version flag and parses the result from 'version'
#
# Caveats:
#   none
#
# Notes:
#   None
  end
end
