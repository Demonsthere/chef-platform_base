execute 'Remove current source lists' do
  command 'rm -f sources.list sources.list~'
  cwd '/etc/apt'
  action :run
end

execute 'Deleting apt preferences ... ' do
  command 'find /etc/apt/sources.list.d/ -type f -delete'
  action :run
end

execute 'Deleting apt preferences ... ' do
  command 'find /etc/apt/preferences.d/ -type f -delete'
  action :run
end

['300-unstable', '600-testing', '900-stable'].each do |pref|
  cookbook_file 'pref-' + pref do
    path '/etc/apt/preferences.d/' + pref
    mode '0644'
    owner 'root'
    group 'root'
    action :create_if_missing
  end
end

['stable.list', 'testing.list', 'unstable.list'].each do |list|
  cookbook_file list do
    path '/etc/apt/sources.list.d/' + list
    mode '0644'
    owner 'root'
    group 'root'
    action :create_if_missing
  end
end
