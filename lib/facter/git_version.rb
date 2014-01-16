# git_version
output = %x{git --version 2>&1}

if $?.exitstatus and output.match(/git version ((\d+\.){2,}\d+).*/)
  Facter.add('git_version') do
    setcode do
      $1
    end
  end
end
