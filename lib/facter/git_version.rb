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
Facter.add('git_version') do
  git_version_cmd = 'git --version 2>&1'
  git_version_result = Facter::Util::Resolution.exec(git_version_cmd)
  setcode do
    git_version_result.to_s.lines.first.strip.split(/version/)[1].strip unless git_version_result.nil?
  end
end

