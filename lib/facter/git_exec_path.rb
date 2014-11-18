# git_exec_path.rb
Facter.add('git_exec_path') do
  case Facter.value(:osfamily)
  when 'windows'
    setcode 'git --exec-path 2>nul'
  else
    setcode 'git --exec-path 2>/dev/null'
  end
end

