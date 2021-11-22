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
sleep 3
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
sleep 3
echo
echo "###############################################"
echo
echo -e "\e[0;33m 7. Active Internet Connections and Open Ports///// \e[0m"
echo
netstat -tulpn
sleep 3
echo
echo "###############################################"
echo
echo -e "\e[0;33m 8. Check Available Space///// \e[0m"
echo
df -h
sleep 3
echo
echo "###############################################"
echo
echo -e "\e[0;33m 9. Check Memory///// \e[0m"
echo
free -h
sleep 3
echo
echo "###############################################"
echo
echo -e "\e[0;33m 10. History (Commands)///// \e[0m"
echo
history | tail -25 | nl
sleep 3
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
iptables -L -n -v --line-numbers
sleep 3
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
sleep 3
echo
echo "###############################################"
echo -e "\e[0;33m 15. List All Packages Installed///// \e[0m"
apt-cache pkgnames | tail -4
sleep 3
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
sleep 3
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
sleep 3
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
sleep 1
dmesg | tail -4
sleep 2
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

#iptables -L -n -v
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
# SEE YOU SPACE COWBOY by DANIEL REHN (danielrehn.com)
# Displays a timeless message in your terminal with cosmic color effects

# Usage: add "sh ~/seeyouspacecowboy.sh; sleep 2" to .bash_logout (or similar) in your home directory
# (adjust the sleep variable to display the message for more seconds)

# Cosmic color sequence

ESC_SEQ="\x1b[38;5;"
COL_01=$ESC_SEQ"160;01m"
COL_02=$ESC_SEQ"196;01m"
COL_03=$ESC_SEQ"202;01m"
COL_04=$ESC_SEQ"208;01m"
COL_05=$ESC_SEQ"214;01m"
COL_06=$ESC_SEQ"220;01m"
COL_07=$ESC_SEQ"226;01m"
COL_08=$ESC_SEQ"190;01m"
COL_09=$ESC_SEQ"154;01m"
COL_10=$ESC_SEQ"118;01m"
COL_11=$ESC_SEQ"046;01m"
COL_12=$ESC_SEQ"047;01m"
COL_13=$ESC_SEQ"048;01m"
COL_14=$ESC_SEQ"049;01m"
COL_15=$ESC_SEQ"051;01m"
COL_16=$ESC_SEQ"039;01m"
COL_17=$ESC_SEQ"027;01m"
COL_18=$ESC_SEQ"021;01m"
COL_19=$ESC_SEQ"021;01m"
COL_20=$ESC_SEQ"057;01m"
COL_21=$ESC_SEQ"093;01m"
RESET="\033[m"

# Timeless message

printf "$COL_01  .d8888b.  8888888888 8888888888      Y88b   d88P  .d88888b.  888     888  \n"
printf "$COL_02 d88P  Y88b 888        888              Y88b d88P  d88P\" \"Y88b 888     888  \n"
printf "$COL_03  \"Y888b.   8888888    8888888            Y888P    888     888 888     888  \n"
printf "$COL_04     \"Y88b. 888        888                 888     888     888 888     888  \n"
printf "$COL_05       \"888 888        888                 888     888     888 888     888  \n"
printf "$COL_06 Y88b  d88P 888        888                 888     Y88b. .d88P Y88b. .d88P  \n"
printf "$COL_07  \"Y8888P\"  8888888888 8888888888          888      \"Y88888P\"   \"Y88888P\"  \n"
printf "$COL_08  .d8888b.  8888888b.     d8888  .d8888b.  8888888888    \n"
printf "$COL_09 d88P  Y88b 888   Y88b   d88888 d88P  Y88b 888       \n"
printf "$COL_10  \"Y888b.   888   d88P d88P 888 888        8888888    \n"
printf "$COL_11     \"Y88b. 8888888P\" d88P  888 888        888   \n"
printf "$COL_12       \"888 888      d88P   888 888    888 888    \n"
printf "$COL_13 Y88b  d88P 888     d8888888888 Y88b  d88P 888  \n"
printf "$COL_14  \"Y8888P\"  888    d88P     888  \"Y8888P\"  8888888888     \n"
printf "$COL_15  .d8888b.   .d88888b.  888       888 888888b.    .d88888b. Y88b   d88P     \n"
printf "$COL_16 d88P  Y88b d88P\" \"Y88b 888   o   888 888  \"88b  d88P\" \"Y88b Y88b d88P   \n"
printf "$COL_17 888        888     888 888 d888b 888 8888888K.  888     888   Y888P    \n"
printf "$COL_18 888        888     888 888d88888b888 888  \"Y88b 888     888    888    \n"
printf "$COL_19 888    888 888     888 88888P Y88888 888    888 888     888    888  \n"
printf "$COL_20 Y88b  d88P Y88b. .d88P 8888P   Y8888 888   d88P Y88b. .d88P    888  \n"
printf "$COL_21  \"Y8888P\"   \"Y88888P\"  888P     Y888 8888888P\"   \"Y88888P\"     888\n"
printf "$RESET" # Reset colors to "normal"

echo -e "---===Made by Catalin for StarTechTeam===---"

exit 0;
