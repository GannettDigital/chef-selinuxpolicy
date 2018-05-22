include Chef::SELinuxPolicy::Helpers

# Support whyrun
def whyrun_supported?
  true
end

use_inline_resources

# Compile and deploy module (also upgrade)
action :deploy do
  filename = "semodule-#{new_resource.name}"
  f = file "#{Chef::Config[:file_cache_path]}/#{filename}.te" do
    content new_resource.content
    # notifies :run, "execute[semodule-deploy-#{new_resource.name}]"
    only_if { use_selinux }
  end

  e = execute "semodule-deploy-#{new_resource.name}" do
    # action ( new_resource.force ? :run : :nothing )
    command "/usr/bin/make -f /usr/share/selinux/devel/Makefile #{filename}.pp && /usr/sbin/semodule -i #{filename}.pp"
    only_if { f.updated_by_last_action? || new_resource.force || (shell_out("/usr/sbin/semodule -l | grep '^#{new_resource.name}\\s'").stdout == '') }
    cwd Chef::Config[:file_cache_path]
    only_if { use_selinux }
  end
end

# remove module
action :remove do
  execute "semodule-remove-#{new_resource.name}" do
    command "/usr/sbin/semodule -r #{new_resource.name}"
    only_if "/usr/sbin/semodule -l | grep '^#{new_resource.name}\\s'"
    only_if { use_selinux }
  end
end
