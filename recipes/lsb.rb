unless node['lsb']['codename']
  include_recipe 'apt'
  package('lsb-release').run_action(:install)
  ohai('reload lsb').run_action(:reload)
end

fail 'node[lsb][codename] still not available' unless node['lsb']['codename']
