# git_html_path.rb
Facter.add('git_html_path') do
  setcode 'git --html-path 2>/dev/null'
end
