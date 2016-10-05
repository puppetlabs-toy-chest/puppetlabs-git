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
  setcode do
    git = Facter::Util::Resolution.which('git')
    if git
      # On macOS, /usr/bin/git exists by default but is not actually git;
      # instead it is a stub to git inside of the active Xcode directory.
      # If there isn't one, calling git spawns an unwanted GUI prompt to
      # install the Xcode command line tools.
      if (git == '/usr/bin/git') && (Facter.value(:kernel) == 'Darwin')
        # check if it is really git
        Facter::Util::Resolution.exec('/usr/bin/xcode-select -p')
        gitmissing = true if $CHILD_STATUS.exitstatus.nonzero?
      end
      unless gitmissing
        git_version_cmd = 'git --version 2>&1'
        git_version_result = Facter::Util::Resolution.exec(git_version_cmd)
        git_version_result.to_s.lines.first.strip.split(/version/)[1].strip
      end
    end
  end
end
