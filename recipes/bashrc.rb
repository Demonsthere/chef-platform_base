cookbook_file 'bash.bashrc' do
  path '/etc/bash.bashrc'
  mode '0644'
  owner 'root'
  group 'root'
end
