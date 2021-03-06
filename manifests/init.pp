# Class: dnsclient
#
# This module manages /etc/resolv.conf
#
# Requires: $nameservers and $dnssearchpath which should be set in the site manifest
#
# Sample Usage: included in generic class that applies to all systems
#
class dnsclient {

    if $nameservers {
        file { "/etc/resolv.conf": 
            content => template("dnsclient/resolv.conf.erb"),
        } # file
    } #if
    if $dnssearchpath {
        case $operatingsystem {
            Ubuntu, Debian: {
                    file { "/etc/dhcp3/dhclient.conf": 
                            content => template("dnsclient/dhclient.conf.erb"),
                    } # file
            }
            CentOS, RedHat: {
                    file { "/etc/dhclient.conf": 
                            content => template("dnsclient/dhclient.conf.erb"),
                    } # file
            }
        }
    } #if
} # class dnsclient
