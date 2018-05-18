# Creates a module based on a source directory

ruby_block 'fail-module-dir' do
  action :nothing
  block do
    raise 'Fail block was invoked'
  end
end
selinux_policy_module 'testo' do
  directory_source 'testo'
end
execute 'trigger-fail-module-dir' do
  not_if 'semodule -l | grep -w "^testo"'
  notifies :run, 'ruby_block[fail-module-dir]', :immediate
end
