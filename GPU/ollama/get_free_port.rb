#!/usr/bin/env ruby
require "socket";
puts Addrinfo.tcp("", 0).bind {|s| s.local_address.ip_port}

