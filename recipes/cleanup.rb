script 'apt cleanup' do
  interpreter 'bash'
  user 'root'
  code <<-EOH
    apt-get -y autoremove
    apt-get -y autoclean
  EOH
end
