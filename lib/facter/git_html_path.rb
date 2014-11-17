# git_html_path.rb
Facter.add('git_html_path') do
  case Facter.value(:osfamily)
  when 'windows'
    setcode 'git --html-path 2>nul'
  else
    setcode 'git --html-path 2>/dev/null'
  end
end

