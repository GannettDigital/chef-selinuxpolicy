# Manages a port assignment in SELinux
# See http://docs.fedoraproject.org/en-US/Fedora/13/html/SELinux_FAQ/index.html#id3715134

property :port, [Integer, String], name_property: true
property :protocol, String, equal_to: %w(tcp udp)
property :secontext, String
property :allow_disabled, [true, false], default: true

attribute :port, kind_of: [Integer, String], name_attribute: true
attribute :protocol, kind_of: String, equal_to: %w(tcp udp)
attribute :secontext, kind_of: String
