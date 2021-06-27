                  ####################################################################################################
                  #                                        Check.sh                                                   #
                  # Written by Catalin Caldararu.                                                                     #
                  # If any bug, report to me                                                                          #
                  #                                                                                                   #
                  #                                                                                                   #
                  #                                                                                                   #
                  ####################################################################################################

#!/bin/bash

tput clear
trap ctrl_c INT
function ctrl_c() {
        echo "**You pressed Ctrl+C...Exiting"
        exit 0;
}
#
echo "###############################################"
echo          "Verificare Prod Servers:"
echo "###############################################"
echo
echo "###############################################"
echo
echo "OK....$HOSTNAME..lets move on...wait for it to finish:"
echo
sleep 3
echo
echo "Script Starts ;)"
START=$(date +%s)
echo
echo -e "\e[0;33m 1. Linux Kernel Information////// \e[0m"
echo
uname -a
echo
echo "###############################################"
echo
echo -e "\e[0;33m 2. Current User and ID information////// \e[0m"
echo
whoami
echo
id
echo
echo "###############################################"
echo
echo -e "\e[0;33m 3.  Linux Distribution Information///// \e[0m"
echo
lsb_release -a
echo
echo "###############################################"
echo
echo -e "\e[0;33m 4. List Current Logged In Users///// \e[0m"
echo
w
echo
echo "###############################################"
echo
echo -e "\e[0;33m 5. $HOSTNAME Uptime Information///// \e[0m"
echo
uptime
echo
echo "###############################################"
echo
echo -e "\e[0;33m 6. Running Services///// \e[0m"
echo
service --status-all |grep "+"
echo
echo "###############################################"
echo
echo -e "\e[0;33m 7. Active Internet Connections and Open Ports///// \e[0m"
echo
netstat -tulpn
echo
echo "###############################################"
echo
echo -e "\e[0;33m 8. Check Available Space///// \e[0m"
echo
df -h
echo
echo "###############################################"
echo
echo -e "\e[0;33m 9. Check Memory///// \e[0m"
echo
free -h
echo
echo "###############################################"
echo
echo -e "\e[0;33m 10. History (Commands)///// \e[0m"
echo
history | tail -25 | nl
echo
echo "###############################################"
echo
echo -e "\e[0;33m 11. Network Interfaces///// \e[0m"
echo
ifconfig -a
echo
echo "###############################################"
echo
echo -e "\e[0;33m 12. IPtable Information///// \e[0m"
echo
iptables -L -n -v
echo
echo "###############################################"
echo
echo -e "\e[0;33m 13. Check Running Processes///// \e[0m"
echo
ps -a
echo
echo "###############################################"
echo
echo -e "\e[0;33m 14. Check SSH Configuration///// \e[0m"
echo
cat /etc/ssh/sshd_config
echo
echo "###############################################"
echo -e "\e[0;33m 15. List All Packages Installed///// \e[0m"
apt-cache pkgnames | tail -4
echo
echo "###############################################"
echo
echo -e "\e[0;33m 16. Network Parameters///// \e[0m"
echo
cat /etc/sysctl.conf
echo
echo "###############################################"
echo
echo -e "\e[0;33m 17. Password Policies///// \e[0m"
echo
cat /etc/pam.d/common-password
echo
echo "###############################################"
echo
echo -e "\e[0;33m 18. Check your Source List File///// \e[0m"
echo
cat /etc/apt/sources.list
echo
echo "###############################################"
echo
echo -e "\e[0;33m 19. Check for Broken Dependencies///// \e[0m"
echo
apt-get check
echo
echo "###############################################"
echo
echo -e "\e[0;33m 20. MOTD Banner Message///// \e[0m"
echo
cat /etc/motd
echo
echo "###############################################"
echo
echo -e "\e[0;33m 21. List User Names///// \e[0m"
echo
cat /etc/passwd | grep bash
echo
echo "###############################################"
echo
echo -e "\e[0;33m 22. Check for Null Passwords///// \e[0m"
echo
users="$(cut -d: -f 1 /etc/passwd)"
for x in $users
do
passwd -S $x |grep "NP"
done
echo
echo "###############################################"
echo
echo -e "\e[0;33m 23. IP Routing Table///// \e[0m"
echo
route -n
echo
echo "###############################################"
echo
echo -e "\e[0;33m 24. Kernel Messages///// \e[0m"
echo
dmesg | tail -4
echo
echo "###############################################"
echo
echo -e "\e[0;33m 25. Check Upgradable Packages///// \e[0m"
echo
#apt list --upgradeable
echo
echo "###############################################"
echo
echo -e "\e[0;33m 26. CPU/System Information///// \e[0m"
echo
lscpu
echo
echo "###############################################"
echo
echo -e "\e[0;33m 27. TCP wrappers///// \e[0m"
echo
cat /etc/hosts.allow
echo "///////////////////////////////////////"
echo
cat /etc/hosts.deny
echo
echo "###############################################"
echo
echo -e "\e[0;33m 28. Failed login attempts///// \e[0m"
echo
cat /var/log/auth.log | tail -15
echo
echo "###############################################"
journalctl -u sshd | tail -10 | nl
echo
echo "###############################################"
echo
END=$(date +%s)
DIFF=$(( $END - $START ))
echo Script completed in $DIFF seconds :
echo
echo Executed on :
date
echo
lsof -i -P -n | grep LISTEN

iptables -L -n -v
systemctl status sshd --no-pager
# Check Load Average
loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
echo -e "Load Average :" $tecreset $loadaverage

echo -e "Check System Uptime"
tecuptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo -e "System Uptime Days/(HH:MM) :" $tecreset $tecuptime

# Check RAM and SWAP Usages
free -h | grep -v + > /tmp/ramcache
echo -e "Ram Usages :" $tecreset
cat /tmp/ramcache | grep -v "Swap"
echo -e "Swap Usages :" $tecreset
cat /tmp/ramcache | grep -v "Mem"

# Check External IP
externalip=$(curl -s ipecho.net/plain;echo)
echo -e "External IP : $tecreset "$externalip

# Check if connected to Internet or not
ping -c 1 google.com &> /dev/null && echo -e "Internet: $tecreset Connected" || echo -e '\E[32m'"Internet: $tecreset Disconnected"
echo -e "##############################################"
echo -e        "Checking For Sh Files and Miners"
echo -e "##############################################"


find . -name "*.sh" -exec ls -ltrh {} \;

echo -e "########################################"
echo -e "Done"
echo -e "########################################"

echo -e "---===Made by Catalin for StarTechTeam===---"

exit 0;
