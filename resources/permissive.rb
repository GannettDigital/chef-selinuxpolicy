# a resource for managing selinux permissive contexts

property :name, String, name_property: true
property :allow_disabled, [true, false], default: true

attribute :name, kind_of: String, name_attribute: true
