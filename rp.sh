#!/bin/bash
# shellcheck disable=SC1091

# Initialize variables
NC='\033[0m'
RED='\033[0;31m'
EXITSTATUS=1 # Error unless it's not an error
DEV_MAIL="tomislav@neuralab.net"
DEV_GITHUB="https://github.com/TomislavHranicNeuralab"
DEV_CODEPEN="https://codepen.io/chanevsky"
VERSION="v0.0.6"
SCRIPT_NAME="Red Pill"
VERSION_DATE="16-Nov-2021"
USER_IS_OK_WITH_THAT=1 # He's not until he is
EMAIL=""
USER_SAID_OK=""

# Whiptail colors
export NEWT_COLORS='
root=red,black
window=,red
border=white,red
textbox=white,red
button=white,black
actbutton=black,white
entry=white,black
'

# Check if root
if [ "$EUID" -ne 0 ] ; then
	printf '%sFAIL: Run as root!%s\n' "$RED" "$NC"
	printf "Run command: sudo bash rp.sh\n"
	exit 1
fi

# Display ascii art
clear
printf '\033[0;34m                                          \033[0;32m   \033[0;34m \033[0;32m     \033[0;34m         \033[0m\n'
printf '\033[0;34m        \033[0;31m    \033[0;32m \033[0;34m  \033[0;31m      \033[0;34m                 \033[0;31m \033[0;32m \033[0;31m.@X8\033[0;33m8\033[0;31m8\033[0;32mS\033[0;31m;\033[0;32m     \033[0;34m       \033[0m\n'
printf '\033[0;34m   \033[0;32m  \033[0;34m \033[0;32m \033[0;33m8S\033[0;31mX\033[0;32mS\033[0;31m;\033[0;32mS\033[0;31mS\033[0;30m8\033[0;1;30;43m8\033[0;33;47m@\033[0;33m \033[0;31mS\033[0;32m:\033[0;34m                 \033[0;31m  \033[0;32m \033[0;31m;\033[0;1;30;43m..8\033[0;33;47m8\033[0;1;37;47m8\033[0;37;47m;\033[0;33;47m8\033[0;33m8\033[0;31m     \033[0;34m      \033[0m\n'
printf '\033[0;34m  \033[0;32m   \033[0;31m \033[0;34m \033[0;31mS\033[0;1;30;43m8\033[0;1;33;47m8\033[0;1;30;43mX\033[0;34m.\033[0;31m:\033[0;32m.\033[0;31mS\033[0;1;30;43m8\033[0;1;33;47m8\033[0;37;47mS\033[0;1;30;43m8\033[0;31mt\033[0;32m:\033[0;34m.\033[0;31m   \033[0;34m            \033[0;31m  \033[0;32m \033[0;34m \033[0;31m@\033[0;1;30;43m \033[0;1;30;41m8\033[0;37;43m8\033[0;1;33;47mX\033[0;37;47mX\033[0;1;33;47m8\033[0;1;37;47m8\033[0;31m8\033[0;32m:\033[0;31m.\033[0;32m    \033[0;34m    \033[0m\n'
printf '\033[0;32m  \033[0;31m:\033[0;33mS@\033[0;32mt\033[0;31m.:S\033[0;1;30;43m \033[0;31m@\033[0;32m:\033[0;34m.\033[0;32m.\033[0;31m:8\033[0;1;30;43m8\033[0;37;43m8\033[0;1;37;47m8\033[0;33m8\033[0;31m .\033[0;34m               \033[0;31m \033[0;32m \033[0;31m.S\033[0;33m8\033[0;31;43m8\033[0;1;30;43m8\033[0;1;33;47m@\033[0;37;47m8\033[0;1;37;43m8\033[0;37;47m;\033[0;37;43m@\033[0;30;41m8\033[0;32m;    \033[0;34m     \033[0m\n'
printf '\033[0;32m;\033[0;31m.\033[0;32m.\033[0;31mS\033[0;1;30;43m8\033[0;33;47m8\033[0;31m@\033[0;32mt\033[0;34m. \033[0;1;30;41m8\033[0;32;43m8\033[0;34m.\033[0;31m ;\033[0;32m;\033[0;1;30;41m8\033[0;1;30;43m8\033[0;1;33;47m88\033[0;30;41m8\033[0;34m:\033[0;32m.\033[0;31m  \033[0;34m           \033[0;31m  \033[0;32m ..\033[0;31m.\033[0;1;30;41m8\033[0;33;41mS\033[0;1;30;41m@\033[0;31;43m8\033[0;33m.\033[0;1;33;47mS\033[0;37;47mS\033[0;1;30;43m8\033[0;31mS\033[0;32m      \033[0;34m   \033[0m\n'
printf '\033[0;33m8\033[0;34m \033[0;32m.;\033[0;30;41m8\033[0;1;30;43m8\033[0;1;33;47m@\033[0;33m8\033[0;34m \033[0;32m  \033[0;31m;.\033[0;34m \033[0;33mX@\033[0;31mS\033[0;1;30;43m8\033[0;33;47m@\033[0;1;37;47m \033[0;33;47mX\033[0;31m@\033[0;34m;\033[0;32m.\033[0;31m     \033[0;32m \033[0;34m       \033[0;32m \033[0;31m   .\033[0;1;30;47m:\033[0;33;47m8\033[0;33;41mS\033[0;1;30;41m@\033[0;1;30;43m8\033[0;1;33;47m@\033[0;1;37;47mS\033[0;37;43mX\033[0;1;30;41mS\033[0;32m .\033[0;31m   \033[0;32m \033[0;34m   \033[0m\n'
printf '\033[0;33m;\033[0;31m@\033[0;32m :t\033[0;1;30;43mS\033[0;33m:\033[0;1;30;43m8\033[0;31m:\033[0;32m. \033[0;31m \033[0;34m \033[0;31m.\033[0;33mS\033[0;1;37;47mt\033[0;31mS\033[0;30;41mS\033[0;37;43m@\033[0;37;47m8\033[0;1;33;47m8\033[0;1;30;47m8\033[0;30;41m88\033[0;33m8\033[0;1;30;41m8\033[0;32m.    \033[0;34m     \033[0;32m  \033[0;31m   8\033[0;37;47mt\033[0;1;33;47m8\033[0;1;37;47m \033[0;37;43m@\033[0;37;47m8\033[0;1;33;47m88\033[0;1;31;47m@\033[0;31m;\033[0;32m      \033[0;34m   \033[0m\n'
printf '\033[0;33m8t\033[0;31mS\033[0;32m:\033[0;34m.\033[0;31mX\033[0;1;30;43m8\033[0;1;30;47m8\033[0;31mS\033[0;32m: \033[0;31m \033[0;34m \033[0;31m:\033[0;1;30;43m8\033[0;1;33;47mS\033[0;33;47m8\033[0;33;41mS:t\033[0;31mS.\033[0;32m;\033[0;31mX\033[0;30;41mS\033[0;37;43m@\033[0;33m:\033[0;31mt\033[0;32m.\033[0;34m      \033[0;32m   \033[0;31m .\033[0;32m.\033[0;33m8\033[0;1;37;47m8\033[0;37;47m;\033[0;33;43m \033[0;1;31;47m@\033[0;37;43m8\033[0;1;33;47m8\033[0;33;41mX\033[0;30m8\033[0;31m.\033[0;32m.\033[0;31m   \033[0;32m \033[0;34m    \033[0m\n'
printf '\033[0;31mt\033[0;33mSt\033[0;1;30m8\033[0;31mS\033[0;32mt\033[0;31m@\033[0;32;43m8\033[0;31m;\033[0;32m   \033[0;31m X\033[0;37;43m8\033[0;1;31;43m8\033[0;1;30;41m@\033[0;31mS.\033[0;34m. .\033[0;31m.\033[0;32m.\033[0;31m:\033[0;33;41mS\033[0;1;30;41m8\033[0;32m.    \033[0;34m   \033[0;32m     \033[0;31m S\033[0;1;30;43m;\033[0;1;33;47m8\033[0;33;47m8\033[0;1;33;47m8\033[0;37;41m8\033[0;33;47m8\033[0;31mS\033[0;32m. \033[0;34m \033[0;31m   \033[0;34m     \033[0m\n'
printf '\033[0;34m \033[0;31mS\033[0;33m@8\033[0;32m@\033[0;31mt\033[0;34m.\033[0;31m \033[0;34m \033[0;31m  \033[0;32m \033[0;31m \033[0;30;41m@\033[0;33;47m8\033[0;1;37;47m;\033[0;30;41m@\033[0;32m:.\033[0;31m   \033[0;34m  .\033[0;32m.       \033[0;34m    \033[0;32m  \033[0;34m \033[0;32m.\033[0;31m8\033[0;1;30;43m88\033[0;33;47m8\033[0;1;33;47m8\033[0;33;47m8\033[0;30;41m@\033[0;32m;\033[0;34m.\033[0;31m    \033[0;32m \033[0;34m     \033[0m\n'
printf '\033[0;32m .\033[0;31m8\033[0;1;30;43m;\033[0;31mS\033[0;32m;\033[0;31m.\033[0;34m  \033[0;31m  \033[0;32m .\033[0;33;41m8\033[0;37;43m8\033[0;1;33;47m@\033[0;33m8\033[0;31m:.\033[0;34m  \033[0;31m \033[0;34m \033[0;32m          \033[0;34m     \033[0;31m \033[0;32m \033[0;31m.\033[0;30;41m8\033[0;1;30;41m8\033[0;33;41mt\033[0;1;30;43m8\033[0;37;43m8\033[0;1;30;41m8\033[0;32m:.\033[0;31m      \033[0;34m     \033[0m\n'
printf '\033[0;34m \033[0;32m::\033[0;31m:\033[0;31m@\033[0;32m:\033[0;31m.\033[0;34m   \033[0;31m  \033[0;34m \033[0;1;30;41m@\033[0;1;30;47m8\033[0;1;37;47m:\033[0;1;30;43m8\033[0;31mS\033[0;34m.  \033[0;31m \033[0;34m \033[0;32m          \033[0;34m    \033[0;31m  \033[0;32m t\033[0;33m8\033[0;1;30;43m8\033[0;33;47mX\033[0;1;33;47m8\033[0;1;30;41m@\033[0;32m:  \033[0;31m      \033[0;34m     \033[0m\n'
printf '\033[0;34m \033[0;32m   .\033[0;31mt\033[0;32m.\033[0;34m   \033[0;31m  \033[0;32m \033[0;31m:\033[0;33;41m8\033[0;1;30;43m8\033[0;1;30;41m8\033[0;34m   \033[0;31m    \033[0;32m         \033[0;34m    \033[0;32m  \033[0;31m..t\033[0;1;30;43mt88\033[0;31mt\033[0;32m     \033[0;31m   \033[0;34m      \033[0m\n'
printf '\033[0;34m \033[0;32m   ..\033[0;34m    \033[0;31m \033[0;34m \033[0;32m  \033[0;31m.:\033[0;32m \033[0;34m   \033[0;31m    \033[0;32m        \033[0;34m    \033[0;32m  \033[0;31m.; X\033[0;33;41m8\033[0;33;47m8\033[0;33;41mS\033[0;34m.\033[0;32m       \033[0;34m       \033[0m\n'
printf '\033[0;34m \033[0;32m   \033[0;31mX\033[0;33m@8\033[0;31m;\033[0;32m \033[0;34m  \033[0;32m    \033[0;31m \033[0;32m \033[0;34m \033[0;31mt\033[0;31m@\033[0;31;43m8\033[0;33m:\033[0;1;30;43m8\033[0;33m8\033[0;31m:\033[0;33;41mX\033[0;33m8\033[0;1;30;43m88\033[0;1;30mX\033[0;31m.    \033[0;32m  \033[0;1;30m8\033[0;1;30;43mS@\033[0;30;41mS\033[0;1;30;41m8\033[0;1;30;43mS\033[0;31;43mS\033[0;31mS\033[0;32m.       \033[0;34m       \033[0m\n'
printf '\033[0;34m \033[0;32m  S\033[0;1;30;43m8\033[0;33;47m88\033[0;37;43m@\033[0;31m8\033[0;32m;\033[0;34m.\033[0;31m \033[0;32m  \033[0;31m t\033[0;31mS\033[0;1;30;43m8\033[0;37;43m8\033[0;33;47m8\033[0;37;43m8\033[0;1;33;47m@X\033[0;33;41mS\033[0;1;30;43mS@\033[0;1;33;47m8@8\033[0;33;41mX\033[0;1;30;43m8\033[0;33m@\033[0;31mS\033[0;32m.\033[0;31m.\033[0;32m \033[0;31m .\033[0;33m.\033[0;1;37;47m;\033[0;1;30;43mS\033[0;31;43mS8\033[0;31m@\033[0;34m:\033[0;32m.\033[0;34m \033[0;32m     \033[0;34m        \033[0m\n'
printf '\033[0;34m \033[0;32m \033[0;31m.\033[0;33;41m8\033[0;1;30;43m8\033[0;33;47m88\033[0;1;33;47m8\033[0;37;43m8\033[0;31m;\033[0;32m \033[0;31m.\033[0;32m \033[0;31m;\033[0;33mS\033[0;37;43m8X\033[0;1;33;47m88@\033[0;37;43m8\033[0;37;41m8\033[0;1;31;43m8\033[0;1;30;43m8\033[0;1;33;47m88\033[0;1;33;41m8\033[0;33;47m8\033[0;1;31;41mS\033[0;1;30;43mS\033[0;1;33;47m8\033[0;37;43m8\033[0;1;30;43m8\033[0;1;30;41m@\033[0;32m;\033[0;31m.\033[0;32m \033[0;31m.S\033[0;1;30;43m8\033[0;1;33;47m@\033[0;1;30;41m8\033[0;31m;\033[0;32m:\033[0;34m.\033[0;32m      \033[0;34m         \033[0m\n'
printf '\033[0;34m \033[0;31m \033[0;34m \033[0;32mt\033[0;1;30;41m8\033[0;1;30;43m8888\033[0;1;30;41m8\033[0;32m;\033[0;31mS\033[0;33m8\033[0;1;30;43m8\033[0;1;33;47m88\033[0;37;43m8\033[0;31;41mt\033[0;33;41m8\033[0;31;41m@\033[0;33m \033[0;1;31;43m8\033[0;1;30;43m8\033[0;33;47m8\033[0;37;43m8\033[0;1;33;47m8\033[0;37;41m8\033[0;31;43m8S\033[0;33;47m8\033[0;1;31;43m8\033[0;1;30;41mX\033[0;33;41m8\033[0;33;47m8\033[0;1;33;47m8\033[0;1;30;41m@\033[0;32m  \033[0;31m:@8\033[0;32mt\033[0;34m:\033[0;32m.\033[0;34m \033[0;32m     \033[0;34m          \033[0m\n'
printf '\033[0;34m   \033[0;32m .\033[0;31m;X\033[0;1;30;43mt \033[0;31;43m8\033[0;1;30;43m8\033[0;31;43m@\033[0;1;31;43m8\033[0;37;43m8\033[0;1;30;43m8\033[0;37;43m8\033[0;37;41m8\033[0;1;33;47m8\033[0;31;41m8\033[0;33;41m8\033[0;35;41mS\033[0;1;30;41m@\033[0;33;41m8\033[0;1;31;41mX\033[0;33;47m8\033[0;1;31;41mS\033[0;1;30;41m@\033[0;31;43m@\033[0;1;30;43m@\033[0;37;43m@\033[0;33;41m8@\033[0;1;30;43m8\033[0;1;33;47m8\033[0;37;43m8\033[0;1;30;43m8\033[0;31m;.\033[0;32m.;\033[0;34m:\033[0;32m.\033[0;31m.\033[0;34m    \033[0;32m   \033[0;34m          \033[0m\n'
printf '\033[0;34m  \033[0;32m   ..\033[0;34m  \033[0;32m8\033[0;31;43m@\033[0;1;30;43mS\033[0;31;43m@\033[0;33;41mX\033[0;35;47m8\033[0;1;31;43m8\033[0;1;33;47mX\033[0;33;47m8\033[0;1;33;47m@\033[0;37;43m8\033[0;33;43m.\033[0;37;43m8\033[0;1;30;43m@\033[0;1;31;43m8\033[0;37;43m@\033[0;1;30;43m8\033[0;33;41m8\033[0;30;41m@@S\033[0;31;43mX\033[0;1;30;43m8\033[0;1;33;47m8\033[0;33;47m8\033[0;37;43m8\033[0;33;47m8\033[0;31mS\033[0;34m . \033[0;32m.\033[0;34m                                    \033[0;31m%s\n' "$SCRIPT_NAME"
printf '\033[0;34m \033[0;32m     \033[0;34m  \033[0;31m :@\033[0;1;30;43m.\033[0;33m8t\033[0;1;33;47m8\033[0;33;47m@8\033[0;1;33;47m8\033[0;33;47m888\033[0;1;33;43mt\033[0;1;31;43m88\033[0;1;33;43m.\033[0;1;30;43m8.\033[0;30;41m@\033[0;1;30;41m8\033[0;31;43m8X\033[0;33;41m@\033[0;33;47m8\033[0;37;43m@\033[0;1;33;47mSX\033[0;31mS\033[0;34m                                          \033[0;31m%s\n' "$VERSION"
printf '\033[0;34m  \033[0;32m    \033[0;34m   \033[0;32m.;@\033[0;1;30;43mS\033[0;35mS\033[0;33m:\033[0;33;47m8\033[0;1;33;47m8\033[0;37;43m@\033[0;33;47m88\033[0;1;33;47m8\033[0;1;33;43m;\033[0;1;31;43m888\033[0;1;30;43m;\033[0;31;43m8\033[0;33;42m8\033[0;31;43m8XS\033[0;1;33;43m.\033[0;33;47m88\033[0;1;31;43m8\033[0;1;37;47m \033[0;30;41mS\033[0;34m.                      \033[0;31mversion date: %s\n' "$VERSION_DATE"
printf '\033[0;34m  \033[0;32m   \033[0;34m    \033[0;32m \033[0;31m.:.X\033[0;33m8@S\033[0;1;30;43m8\033[0;33;47m888\033[0;1;33;47m8X\033[0;37;43m@\033[0;1;30;43mX\033[0;31;43mSX8X\033[0;33;41m@\033[0;1;33;43m:\033[0;33;43mt\033[0;33;47m@\033[0;1;33;47m8@\033[0;37;43m8\033[0;35mt\033[0;31mt.\033[0;34m                         \033[0;31m%s\n' "$DEV_MAIL"
printf '\033[0;34m         \033[0;32m \033[0;31m  \033[0;32m..\033[0;34m  :\033[0;1;30m8\033[0;30m@\033[0;33m88;\033[0;33;47m88\033[0;1;33;47m8\033[0;33;47m888\033[0;1;33;43mS\033[0;33;47m888888\033[0;37;43m8\033[0;1;30;43m8\033[0;31m;      %s\n' "$DEV_GITHUB"
printf '\n\033[0;31mTake the red pill?\033[0m'
read -r
clear

# Start log
touch rp_debug.log
{
	printf '\n##################################################\n'
	printf 'Script name: %s\n' "$SCRIPT_NAME"
	printf 'Version: %s\n' "$VERSION"
	printf 'Script started %s\n\n' "$(date +'%D %T')"
} >> rp_debug.log

# Determine which package manager to use
if [ "$(command -v apt)" ]; then
	PACKAGE_MNGR="apt"
elif [ "$(command -v pacman)" ]; then
	PACKAGE_MNGR="pacman"
else
		printf '%s FAIL: Unsupported linux type\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sFAIL: Unsupported linux type%s\n' "${RED}" "${NC}" >> rp_debug.log
		exit 1
fi

# Update package list
if [ $PACKAGE_MNGR = 'apt' ]; then
	apt update
elif [ $PACKAGE_MNGR = 'pacman' ]; then
	# $PACKAGE_MNGR -Sc --noconfirm # Remove unused packages from cache and unused sync dbs.
	# pacman-mirrors --fasttrack # Update mirrorlist and choose fastest mirrors - takes time
	pacman -D --asexplicit lsof lib32-alsa-plugins zenity # Don't remove these when removing Steam
	pacman -Rsn steam-manjaro --noconfirm # Remove Steam
	pacman -Rsn yakuake --noconfirm # Remove annoying dropdown folating terminal
fi

# Get user info with whiptail
until [ $USER_IS_OK_WITH_THAT -eq 0 ]
do
	NAME=$(whiptail --inputbox "Enter your name. Use your full name, not your nickname or just your first name. Your full legal name. If you get stuck check your passport :)" 12 48 --title "Your name" --cancel-button "Exit" 3>&1 1>&2 2>&3)
	EXITSTATUS=$?
	if [ $EXITSTATUS -ne 0 ] ; then
		printf '%s Exited on name entering dialog. Exit status: %s\n' "$(date +'%D %T')" "$EXITSTATUS" >> rp_debug.log
		exit $EXITSTATUS
	fi
	printf '%s User successfully entered name %s\n' "$(date +'%D %T')" "$NAME" >> rp_debug.log

	until [[ "$EMAIL" =~ @neuralab.net$ ]]
	do
		EMAIL=$(whiptail --inputbox "Enter your email. Use your official Neuralab email, not your private Gmail, Yahoo, Hotmail. If you get stuck check if your email has the word \"neuralab\" in it :)" 12 48 --title "Your email" --cancel-button "Exit" 3>&1 1>&2 2>&3)
		EXITSTATUS=$?
		if [ $EXITSTATUS -ne 0 ] ; then
			printf '%s Exited on email entering dialog. Exit status: %s\n' "$(date +'%D %T')" "$EXITSTATUS" >> rp_debug.log
			exit $EXITSTATUS
		elif [[ ! "$EMAIL" =~ @neuralab.net$ ]] ; then
			printf '%s User entered a non @neuralab.net email address %s\n' "$(date +'%D %T')" "$EMAIL" >> rp_debug.log
			whiptail --msgbox "$EMAIL is not an @neuralab.net email!" --title "FAIL" 12 48
		fi
	done
	printf '%s User successfully entered email address %s\n' "$(date +'%D %T')" "$EMAIL" >> rp_debug.log

	whiptail --yesno "Your name: $NAME\nYour email: $EMAIL\nIs this correct?" 12 48 --title "You are" 3>&1 1>&2 2>&3
	USER_IS_OK_WITH_THAT=$?
	case $USER_IS_OK_WITH_THAT in
		0)
			USER_SAID_OK="YES"
			;;
		1)
			USER_SAID_OK="NO"
			;;
		*)
			USER_SAID_OK="Dont know. Something went wrong :/"
			;;
	esac
	printf '%s User confirms %s and %s? - %s\n' "$(date +'%D %T')" "$NAME" "$EMAIL" "$USER_SAID_OK" >> rp_debug.log
done

{
printf '%s Users name set to %s\n' "$(date +'%D %T')" "$NAME"
printf '%s Users email set to %s\n' "$(date +'%D %T')" "$EMAIL"
} >> rp_debug.log

# Check if SSH ed25519 keys are present, if not create keys
updatedb # update db used by locate
mkdir -p /home/"${SUDO_USER}"/.ssh/ # -p: creates dir only if it doesnt exist
if ! [ -e "/home/${SUDO_USER}/.ssh/id_ed25519" ] || ! [ -e "/home/${SUDO_USER}/.ssh/id_ed25519.pub" ] ; then
	printf 'ed25519 keys not found.\n%s...generating keys%s\n' "${RED}" "${NC}"
	printf '%s SSH ed25519 keys not found. Generating...\n' "$(date +'%D %T')" >> rp_debug.log
	rm -f /home/"${SUDO_USER}"/.ssh/id_ed25519
	rm -f /home/"${SUDO_USER}"/.ssh/id_ed25519.pub
	ssh-keygen -t ed25519 -C "$EMAIL" -f /home/"${SUDO_USER}"/.ssh/id_ed25519 -N ""
	updatedb # update db used by locate
	if [ -e "/home/${SUDO_USER}/.ssh/id_ed25519" ] && [ -e "/home/${SUDO_USER}/.ssh/id_ed25519.pub" ] ; then
		printf '%s SSH ed25519 keys created!\n' "$(date +'%D %T')" >> rp_debug.log
	else
		printf '%sFAIL: Cannot create SSH keys! Check rp_debug.log for more info.%s\n' "${RED}" "${NC}"
		printf '%s FAIL: Cannot create SSH keys! Error running ssh-keygen -t ed25519 -C \"%s\"\n' "$(date +'%D %T')" "$EMAIL" >> rp_debug.log
		exit 1
	fi
else
	printf '%s SSH ed25519 keys found!\n' "$(date +'%D %T')" >> rp_debug.log
fi

# Start SSH agent and add credentials
if ! eval "$(ssh-agent -s)" ; then
	printf '%s Cannot start SSH agent. Exit status: %s\n' "$(date +'%D %T')" "$?" >> rp_debug.log
	exit 1
else
	printf '%s SSH agent successfully started.\n' "$(date +'%D %T')" >> rp_debug.log
fi
if ! ssh-add /home/"${SUDO_USER}"/.ssh/id_ed25519 ; then
	printf '%s Cannot add your SSH private key to SSH agent. Exit status: %s\n' "$(date +'%D %T')" "$?" >> rp_debug.log
	exit 1
else
	printf '%s SSH private key added to SSH agent.\n' "$(date +'%D %T')" >> rp_debug.log
fi

# Changing owner of ssh keys
chown "$SUDO_USER" /home/"${SUDO_USER}"/.ssh/id_ed25519
chown "$SUDO_USER" /home/"${SUDO_USER}"/.ssh/id_ed25519.pub

# Install Xclip clipboard
printf '%s Installing xclip\n' "$(date +'%D %T')" >> rp_debug.log

if [ $PACKAGE_MNGR = 'apt' ]; then
	if ! apt install xclip -y; then
		printf '%s WARNING: xclip installation failed. Continuing...\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sWARNING: Xclip clipboard installation failed. Continuing...%s\n' "${RED}" "${NC}"
	else
		printf '%s xclip successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
	fi
elif [ $PACKAGE_MNGR = 'pacman' ]; then
	if ! pacman -S xclip --noconfirm; then
		printf '%s WARNING: xclip installation failed. Continuing...\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sWARNING: Xclip clipboard installation failed. Continuing...%s\n' "${RED}" "${NC}"
	else
		printf '%s xclip successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
	fi
fi

# Show SSH public key, request to add it to Github, test connection
ADDED_TO_GITHUB=false
SSHKEY=$(cat /home/"${SUDO_USER}"/.ssh/id_ed25519.pub)
until $ADDED_TO_GITHUB
do
	TESTCONNECTION=1 # Error until not error
	until [ $TESTCONNECTION -eq 0 ]
	do
		whiptail --yesno "This is your SSH public key. Add it to Github.\n\n$SSHKEY" --title "Your SSH key" --yes-button "Test connection" --no-button "Copy to clipboard" 12 70
		TESTCONNECTION=$?
		if [ $TESTCONNECTION -eq 1 ]
		then
			echo "$SSHKEY" | xclip -sel clip
			printf '%s SSH key copied to clipboard\n' "$(date +'%D %T')" >> rp_debug.log
		fi
	done

	printf '%s Testing connection to Github\n' "$(date +'%D %T')" >> rp_debug.log
	su "$SUDO_USER" -c "ssh -oStrictHostKeyChecking=no -T git@github.com" # Create and add to users known hosts
	ssh -oStrictHostKeyChecking=no -T git@github.com
	EXITSTATUS=$?
	if [ $EXITSTATUS -eq 255 ] ; then # permission denied
		printf '%s Cannot connect to Github, permission denied! Exit status: %s\n' "$(date +'%D %T')" "$EXITSTATUS" >> rp_debug.log
		if ! whiptail --yesno "Cannot connect to Github! Did you add your SSH key?" --title "FAIL" --yes-button "Try again" --no-button "Exit" 12 48 ; then
			printf '%s User exited\n' "$(date +'%D %T')" >> rp_debug.log
			exit $EXITSTATUS
		fi
	elif [ $EXITSTATUS -eq 1 ] ; then # connected but failed because Github doesn't provide shell
		ADDED_TO_GITHUB=true
	else
		printf '%s Unexpected error. Exit status: %s\n' "$(date +'%D %T')" "$EXITSTATUS" >> rp_debug.log
		whiptail --msgbox "Unexpected error\nExit status: $EXITSTATUS" --title "FAIL" --ok-button "Exit" 12 48
		exit $EXITSTATUS
	fi
done

printf '%s Connected to Github!\n' "$(date +'%D %T')" >> rp_debug.log
whiptail --msgbox "SUCCESS: Connected and authenticated on Github!" --title "SUCCESS" 12 48

# Remove Xclip clipboard
printf '%s Removing xclip\n' "$(date +'%D %T')" >> rp_debug.log
if [ $PACKAGE_MNGR = 'apt' ]; then
	if ! apt purge xclip -y ; then
		printf '%s WARNING: xclip removal failed. Continuing...\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sWARNING: Xclip clipboard removal failed. Continuing...%s\n' "${RED}" "${NC}"
	else
		printf '%s xclip successfully removed\n' "$(date +'%D %T')" >> rp_debug.log
	fi

	# Update debian system
	printf '%s Running system update\n' "$(date +'%D %T')" >> rp_debug.log
	apt upgrade -y

	# Install and config Git
	printf '%s Installing Git\n' "$(date +'%D %T')" >> rp_debug.log
	apt install git-all -y
	if git --version >/dev/null 2>&1 ; then
		printf '%s Git successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
	else
		printf '%s FAIL: Git instalation failed! (git --version >/dev/null 2>&1) did not detect Git\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sFAIL: Git instalation failed! Check rp_debug.log for more info.%s\n' "${RED}" "${NC}"
		exit $?
	fi

elif [ $PACKAGE_MNGR = 'pacman' ]; then
	if ! pacman -Rs xclip --noconfirm ; then
		printf '%s WARNING: xclip removal failed. Continuing...\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sWARNING: Xclip clipboard removal failed. Continuing...%s\n' "${RED}" "${NC}"
	else
		printf '%s xclip successfully removed\n' "$(date +'%D %T')" >> rp_debug.log
	fi

	# Update arch system
	printf '%s Running system update\n' "$(date +'%D %T')" >> rp_debug.log
	pacman -Syu --noconfirm

	# Install and config Git
	printf '%s Installing Git\n' "$(date +'%D %T')" >> rp_debug.log
	pacman S git --noconfirm
	if git --version >/dev/null 2>&1 ; then
		printf '%s Git successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
	else
		printf '%s FAIL: Git instalation failed! (git --version >/dev/null 2>&1) did not detect Git\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sFAIL: Git instalation failed! Check rp_debug.log for more info.%s\n' "${RED}" "${NC}"
		exit $?
	fi
fi



if ! git config --global user.name "$NAME" ; then
	printf '%sWARNING: Cannot set Git name! Continuing...%s\n' "${RED}" "${NC}"
	printf '%s WARNING: Cannot set Git name! Continuing...\n' "$(date +'%D %T')" >> rp_debug.log
else
	printf '%s Git name set to %s\n' "$(date +'%D %T')" "$NAME" >> rp_debug.log
fi

if ! git config --global user.email "$EMAIL" ; then
	printf '%sWARNING: Cannot set Git email! Continuing...%s\n' "${RED}" "${NC}"
	printf '%s WARNING: Cannot set Git email! Continuing...\n' "$(date +'%D %T')" >> rp_debug.log
else
	printf '%s Git email set to %s\n' "$(date +'%D %T')" "$EMAIL" >> rp_debug.log
fi

if ! git config --global core.autocrlf false ; then
	printf '%sWARNING: Cannot set Git line endings to LF! Continuing...%s\n' "${RED}" "${NC}"
	printf '%s WARNING: Cannot set Git line endings to LF!! Continuing...\n' "$(date +'%D %T')" >> rp_debug.log
else
	printf '%s Git line endings set to LF\n' "$(date +'%D %T')" >> rp_debug.log
fi

# Install PHP 7.4
printf '%s Installing php7.4-cli\n' "$(date +'%D %T')" >> rp_debug.log
if [ $PACKAGE_MNGR = 'apt' ]; then
	if ! apt install php7.4-cli -y ; then
		printf '%s FAIL: Cannot install PHP 7.4 cli! Error running apt install php7.4-cli -y\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sFAIL: Cannot install PHP 7.4 cli! Check rp_debug.log for more info.%s\n' "${RED}" "${NC}"
		exit 1
	fi

	{
		printf '%s php7.4-cli successfully installed\n' "$(date +'%D %T')"
		printf '%s Installing php7.4-xmlwriter\n' "$(date +'%D %T')"
	} >> rp_debug.log


	if ! apt install php7.4-xmlwriter -y ; then
		printf '%s FAIL: Cannot install PHP 7.4 xmlwriter! Error running apt install php7.4-xmlwriter -y\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sFAIL: Cannot install PHP 7.4 xmlwriter! Check rp_debug.log for more info.%s\n' "${RED}" "${NC}"
		exit 1
	fi
		printf '%s php7.4-xmlwriter successfully installed\n' "$(date +'%D %T')" >> rp_debug.log

	# Install Composer
	printf '%s Installing composer\n' "$(date +'%D %T')" >> rp_debug.log
	if ! apt install composer -y ; then
		printf '%s FAIL: Cannot install Composer! Error running apt install composer -y\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sFAIL: Cannot install Composer! Check rp_debug.log for more info.%s\n' "${RED}" "${NC}"
		exit 1
	fi
	printf '%s composer successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
elif [ $PACKAGE_MNGR = 'pacman' ]; then
	if ! pacman -S php7 --noconfirm ; then
		printf '%s FAIL: Cannot install PHP 7.4 cli! Error running apt install php7.4-cli -y\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sFAIL: Cannot install PHP 7.4 cli! Check rp_debug.log for more info.%s\n' "${RED}" "${NC}"
		exit 1
	fi

	{
		printf '%s php7.4-cli successfully installed\n' "$(date +'%D %T')"
		printf '%s Installing php7.4-xmlwriter\n' "$(date +'%D %T')"
	} >> rp_debug.log

	# Install Composer
	printf '%s Installing composer\n' "$(date +'%D %T')" >> rp_debug.log
	if ! pacman -S composer --noconfirm ; then
		printf '%s FAIL: Cannot install Composer! Error running apt install composer -y\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sFAIL: Cannot install Composer! Check rp_debug.log for more info.%s\n' "${RED}" "${NC}"
		exit 1
	fi
	printf '%s composer successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
fi

# Install coding standards
printf '%s Installing Neuralab coding standards\n' "$(date +'%D %T')" >> rp_debug.log
if ! su "$SUDO_USER" -c "composer global require neuralab/coding-standards:dev-master" ; then
	printf '%s WARNING: Cannot install Neuralab coding standards! Error running composer global require neuralab/coding-standards:dev-master Continuing...\n' "$(date +'%D %T')" >> rp_debug.log
	printf '%sWARNING: Cannot install Neuralab coding standards! Continuing...%s\n' "${RED}" "${NC}"
else
	printf '%s Neuralab coding standards successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
fi

# Check if phpcs added to path
phpcs -i
# If comannd not found then add to path:
if [ $? -eq 127 ]
then
	if [ $PACKAGE_MNGR = 'apt' ]; then
		printf "export PATH=\"\$HOME/.composer/vendor/bin:\$PATH\"\n" >> /home/"$SUDO_USER"/.bashrc
	elif [ $PACKAGE_MNGR = 'pacman' ]; then
		printf "export PATH=\"\$HOME/.config/composer/vendor/bin:\$PATH\"\n" >> /home/"$SUDO_USER"/.zshrc
		printf "export PATH=\"\$HOME/.config/composer/vendor/bin:\$PATH\"\n" >> /home/"$SUDO_USER"/.bashrc
	fi
fi

# Install Node version manager
printf '%s Installing Node Version Manager\n' "$(date +'%D %T')" >> rp_debug.log

su "$SUDO_USER" -c "git clone https://github.com/nvm-sh/nvm.git /home/${SUDO_USER}/.nvm"
su "$SUDO_USER" -c "cd /home/${SUDO_USER}/.nvm && git checkout v0.39.0 && . home/${SUDO_USER}/.nvm/nvm.sh"
{
	printf 'NVM_DIR="/home/%s/.nvm"\n' "$SUDO_USER"
	printf '[ -s "%s/nvm.sh" ] && \\. "%s/nvm.sh"\n' "$NVM_DIR" "$NVM_DIR"
	printf '[ -s "%s/bash_completion" ] && \\. "%s/bash_completion"\n' "$NVM_DIR" "$NVM_DIR"
} >> /home/"$SUDO_USER"/.bashrc

if [ $PACKAGE_MNGR = 'pacman' ]; then
	{
		printf 'NVM_DIR="/home/%s/.nvm"\n' "$SUDO_USER"
		printf '[ -s "%s/nvm.sh" ] && \\. "%s/nvm.sh"\n' "$NVM_DIR" "$NVM_DIR"
		printf '[ -s "%s/bash_completion" ] && \\. "%s/bash_completion"\n' "$NVM_DIR" "$NVM_DIR"
	} >> /home/"$SUDO_USER"/.zshrc
fi

if ! command -v nvm ; then
	printf '%s FAIL: Something went wrong. Cannot run nvm command!\n' "$(date +'%D %T')" >> rp_debug.log
	printf '%sSomething went wrong. Cannot run nvm command!%s\n' "${RED}" "${NC}"
	exit 1
else
	printf '%s nvm command available\n' "$(date +'%D %T')" >> rp_debug.log
fi

printf '%s Installing Node 10.24.0\n' "$(date +'%D %T')" >> rp_debug.log
if ! nvm install 10.24.0 ; then
	printf '%s WARNING: Cannot install Node. nvm install 10.24.0 failed. Continuing...\n' "$(date +'%D %T')" >> rp_debug.log
else
	printf '%s Node 10.24.0 successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
fi

printf '%s Use Node 10.24.0 \n' "$(date +'%D %T')" >> rp_debug.log
if ! nvm use 10.24.0 ; then
	printf '%s WARNING: Cannot use Node 10.24.0. nvm use 10.24.0 failed. Continuing...\n' "$(date +'%D %T')" >> rp_debug.log
else
	printf '%s Using Node 10.24.0\n' "$(date +'%D %T')" >> rp_debug.log
fi

# Install Visual Studio Code
if [ $PACKAGE_MNGR = 'apt' ]; then
	printf '%s Installing Visual Studio Code\n' "$(date +'%D %T')" >> rp_debug.log
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	m -f packages.microsoft.gpg

	apt install apt-transport-https
	apt update
	if ! apt install code ; then
		printf '%s WARNING: Visual Studio Code installation failed. Continuing...\n' "$(date +'%D %T')" >> rp_debug.log
	else
		printf '%s Visual Studio Code successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
	fi
elif [ $PACKAGE_MNGR = 'pacman' ]; then
	ln -s /var/lib/snapd/snap /snap
	if ! snap install code --classic ; then
		printf '%s WARNING: Visual Studio Code installation failed. Continuing...\n' "$(date +'%D %T')" >> rp_debug.log
	else
		printf '%s Visual Studio Code successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
	fi
fi

# Install Virtual box
printf '%s Installing virtualbox\n' "$(date +'%D %T')" >> rp_debug.log
if [ $PACKAGE_MNGR = 'apt' ]; then
	if ! apt install virtualbox -y ; then
		printf '%s FAIL: virtualbox installation failed. Error running apt install virtualbox -y\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sSomething went wrong. Virtualbox installation failed!%s\n' "${RED}" "${NC}"
		exit 1
	else
		printf '%s virtualbox successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
	fi

	printf '%s Installing virtualbox-guest-additions-iso\n' "$(date +'%D %T')" >> rp_debug.log
	if ! apt install virtualbox-guest-additions-iso -y ; then
		printf '%s FAIL: virtualbox-guest-additions-iso installation failed. Error running apt install virtualbox-guest-additions-iso -y\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sSomething went wrong. Virtualbox guest additions installation failed!%s\n' "${RED}" "${NC}"
		exit 1
	else
		printf '%s virtualbox-guest-additions-iso successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
	fi

	# Install Vagrant
	printf '%s Installing vagrant\n' "$(date +'%D %T')" >> rp_debug.log
	if ! apt install vagrant -y ; then
		printf '%s FAIL: vagrant installation failed. Error running apt install vagrant -y\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sSomething went wrong. Vagrant installation failed!%s\n' "${RED}" "${NC}"
		exit 1
	else
		printf '%s vagrant successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
	fi

elif [ $PACKAGE_MNGR = 'pacman' ]; then
	if ! pacman -S virtualbox --noconfirm ; then
		printf '%s FAIL: virtualbox installation failed. Error running apt install virtualbox -y\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sSomething went wrong. Virtualbox installation failed!%s\n' "${RED}" "${NC}"
		exit 1
	else
		printf '%s virtualbox successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
	fi

	# Install Vagrant
	printf '%s Installing vagrant\n' "$(date +'%D %T')" >> rp_debug.log
	if ! pacman -S vagrant --noconfirm ; then
		printf '%s FAIL: vagrant installation failed. Error running apt install vagrant -y\n' "$(date +'%D %T')" >> rp_debug.log
		printf '%sSomething went wrong. Vagrant installation failed!%s\n' "${RED}" "${NC}"
		exit 1
	else
		printf '%s vagrant successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
	fi

fi

# Install Vagrant plugins
printf '%s Installing vagrant-bindfs\n' "$(date +'%D %T')" >> rp_debug.log
if ! vagrant plugin install vagrant-bindfs ; then
	printf '%s FAIL: vagrant-bindfs installation failed. Error running vagrant plugin install vagrant-bindfs\n' "$(date +'%D %T')" >> rp_debug.log
	printf '%sSomething went wrong. Vagrant plugin bindfs installation failed!%s\n' "${RED}" "${NC}"
	exit 1
else
	printf '%s vagrant-bindfs successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
fi

printf '%s Installing vagrant-faster\n' "$(date +'%D %T')" >> rp_debug.log
if ! vagrant plugin install vagrant-faster ; then
	printf '%s FAIL: vagrant-faster installation failed. Error running vagrant plugin install vagrant-faster\n' "$(date +'%D %T')" >> rp_debug.log
	printf '%sSomething went wrong. Vagrant plugin fasater installation failed!%s\n' "${RED}" "${NC}"
	exit 1
else
	printf '%s vagrant-faster successfully installed\n' "$(date +'%D %T')" >> rp_debug.log
fi

# Install homestead
printf '%s Installing homestead\n' "$(date +'%D %T')" >> rp_debug.log
git clone https://github.com/laravel/homestead.git /home/"$SUDO_USER"/homestead
cd /home/"$SUDO_USER"/homestead && git checkout release && bash init.sh

printf "function homestead() { ( cd ~/homestead && vagrant \"\$@\" ) }\n" >> /home/"$SUDO_USER"/.bashrc
printf "export -f homestead\n" >> /home/"$SUDO_USER"/.bashrc

if [ $PACKAGE_MNGR = 'pacman' ]; then
	printf "function homestead() { ( cd ~/homestead && vagrant \"\$@\" ) }\n" >> /home/"$SUDO_USER"/.zshrc
	printf "export -f homestead\n" >> /home/"$SUDO_USER"/.zshrc
fi

sed -i '/192.168./c\ip: "192.168.10.10"' /home/"$SUDO_USER"/homestead/Homestead.yaml
sed -i '/authorize:/c\authorize: ~/.ssh/id_ed25519.pub' /home/"$SUDO_USER"/homestead/Homestead.yaml
sed -i '/ssh\/id_rsa/c\    - ~/.ssh/id_ed25519' /home/"$SUDO_USER"/homestead/Homestead.yaml

sed -i -r '/^provider:/a variables:' /home/"$SUDO_USER"/homestead/Homestead.yaml
sed -i -r '/^variables:/a \ \ \ \ - key: IS_HOMESTEAD' /home/"$SUDO_USER"/homestead/Homestead.yaml
sed -i -r '/IS_HOMESTEAD/a \ \ \ \ \ \ value: "true"' /home/"$SUDO_USER"/homestead/Homestead.yaml

chown -R "$SUDO_USER" /home/"$SUDO_USER"/homestead

printf "192.168.10.10 dev.neuralab.test\n" >> /etc/hosts

mkdir /home/"$SUDO_USER"/www
chown -R "$SUDO_USER" /home/"$SUDO_USER"/www
printf '%s Homestead installed\n' "$(date +'%D %T')" >> rp_debug.log

whiptail --msgbox "Your dev env is installed\nClone reporitories to:\n     ~/www/\nAdd sites to:\n   ~/homestead/Homestead.yaml\n     /etc/hosts\nReopen terminal and run:\n     \"homestead up --provision\"\n\nDanke schön!" --title "Installed!" 16 60
exit 0
