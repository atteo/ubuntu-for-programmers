
# Use GRC only for following commands

set -U grc_plugin_execs ant blkid cvs diff docker docker docker-machine env id ip iostat \
	gcc g++ ifconfig make mount mtr netstat tail traceroute \
       wdiff        last lsattr lsblk lspci lsmod lsof getfacl getsebool ulimit uptime nmap \
       fdisk findmnt free semanage sar ss sysctl systemctl stat showmount tune2fs tcpdump  \
       vmstat w who iptables ldap php pv

for executable in $grc_plugin_execs
    if type -q $executable
        alias $executable "grc $executable"
    end
end


