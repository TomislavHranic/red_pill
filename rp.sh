#! /bin/bash

NC='\033[0m'
RED='\033[0;31m'
BLUE='\033[0;34m'
GRAY='\033[1;30m'
EXITSTATUS=1 # Error unless it's not an error

# Check if root
if [ "$EUID" -ne 0 ]
then
	printf "${RED}FAIL: Run as root!${NC}\n"
	printf "Run command: sudo bash rp.sh\n"
	exit 1
fi

DMAIL="tomislav@neuralab.net"
DGIT="https://github.com/TomislavHranicNeuralab"
VERSION="v0.0.1"
SCRIPT_NAME="Red Pill"
VERDATE="11-Nov-2021"

clear
printf "\033[0;34m                                          \033[0;32m   \033[0;34m \033[0;32m     \033[0;34m         \033[0m\n"
printf "\033[0;34m        \033[0;31m    \033[0;32m \033[0;34m  \033[0;31m      \033[0;34m                 \033[0;31m \033[0;32m \033[0;31m.@X8\033[0;33m8\033[0;31m8\033[0;32mS\033[0;31m;\033[0;32m     \033[0;34m       \033[0m\n"
printf "\033[0;34m   \033[0;32m  \033[0;34m \033[0;32m \033[0;33m8S\033[0;31mX\033[0;32mS\033[0;31m;\033[0;32mS\033[0;31mS\033[0;30m8\033[0;1;30;43m8\033[0;33;47m@\033[0;33m \033[0;31mS\033[0;32m:\033[0;34m                 \033[0;31m  \033[0;32m \033[0;31m;\033[0;1;30;43m..8\033[0;33;47m8\033[0;1;37;47m8\033[0;37;47m;\033[0;33;47m8\033[0;33m8\033[0;31m     \033[0;34m      \033[0m\n"
printf "\033[0;34m  \033[0;32m   \033[0;31m \033[0;34m \033[0;31mS\033[0;1;30;43m8\033[0;1;33;47m8\033[0;1;30;43mX\033[0;34m.\033[0;31m:\033[0;32m.\033[0;31mS\033[0;1;30;43m8\033[0;1;33;47m8\033[0;37;47mS\033[0;1;30;43m8\033[0;31mt\033[0;32m:\033[0;34m.\033[0;31m   \033[0;34m            \033[0;31m  \033[0;32m \033[0;34m \033[0;31m@\033[0;1;30;43m \033[0;1;30;41m8\033[0;37;43m8\033[0;1;33;47mX\033[0;37;47mX\033[0;1;33;47m8\033[0;1;37;47m8\033[0;31m8\033[0;32m:\033[0;31m.\033[0;32m    \033[0;34m    \033[0m\n"
printf "\033[0;32m  \033[0;31m:\033[0;33mS@\033[0;32mt\033[0;31m.:S\033[0;1;30;43m \033[0;31m@\033[0;32m:\033[0;34m.\033[0;32m.\033[0;31m:8\033[0;1;30;43m8\033[0;37;43m8\033[0;1;37;47m8\033[0;33m8\033[0;31m .\033[0;34m               \033[0;31m \033[0;32m \033[0;31m.S\033[0;33m8\033[0;31;43m8\033[0;1;30;43m8\033[0;1;33;47m@\033[0;37;47m8\033[0;1;37;43m8\033[0;37;47m;\033[0;37;43m@\033[0;30;41m8\033[0;32m;    \033[0;34m     \033[0m\n"
printf "\033[0;32m;\033[0;31m.\033[0;32m.\033[0;31mS\033[0;1;30;43m8\033[0;33;47m8\033[0;31m@\033[0;32mt\033[0;34m. \033[0;1;30;41m8\033[0;32;43m8\033[0;34m.\033[0;31m ;\033[0;32m;\033[0;1;30;41m8\033[0;1;30;43m8\033[0;1;33;47m88\033[0;30;41m8\033[0;34m:\033[0;32m.\033[0;31m  \033[0;34m           \033[0;31m  \033[0;32m ..\033[0;31m.\033[0;1;30;41m8\033[0;33;41mS\033[0;1;30;41m@\033[0;31;43m8\033[0;33m.\033[0;1;33;47mS\033[0;37;47mS\033[0;1;30;43m8\033[0;31mS\033[0;32m      \033[0;34m   \033[0m\n"
printf "\033[0;33m8\033[0;34m \033[0;32m.;\033[0;30;41m8\033[0;1;30;43m8\033[0;1;33;47m@\033[0;33m8\033[0;34m \033[0;32m  \033[0;31m;.\033[0;34m \033[0;33mX@\033[0;31mS\033[0;1;30;43m8\033[0;33;47m@\033[0;1;37;47m \033[0;33;47mX\033[0;31m@\033[0;34m;\033[0;32m.\033[0;31m     \033[0;32m \033[0;34m       \033[0;32m \033[0;31m   .\033[0;1;30;47m:\033[0;33;47m8\033[0;33;41mS\033[0;1;30;41m@\033[0;1;30;43m8\033[0;1;33;47m@\033[0;1;37;47mS\033[0;37;43mX\033[0;1;30;41mS\033[0;32m .\033[0;31m   \033[0;32m \033[0;34m   \033[0m\n"
printf "\033[0;33m;\033[0;31m@\033[0;32m :t\033[0;1;30;43mS\033[0;33m:\033[0;1;30;43m8\033[0;31m:\033[0;32m. \033[0;31m \033[0;34m \033[0;31m.\033[0;33mS\033[0;1;37;47mt\033[0;31mS\033[0;30;41mS\033[0;37;43m@\033[0;37;47m8\033[0;1;33;47m8\033[0;1;30;47m8\033[0;30;41m88\033[0;33m8\033[0;1;30;41m8\033[0;32m.    \033[0;34m     \033[0;32m  \033[0;31m   8\033[0;37;47mt\033[0;1;33;47m8\033[0;1;37;47m \033[0;37;43m@\033[0;37;47m8\033[0;1;33;47m88\033[0;1;31;47m@\033[0;31m;\033[0;32m      \033[0;34m   \033[0m\n"
printf "\033[0;33m8t\033[0;31mS\033[0;32m:\033[0;34m.\033[0;31mX\033[0;1;30;43m8\033[0;1;30;47m8\033[0;31mS\033[0;32m: \033[0;31m \033[0;34m \033[0;31m:\033[0;1;30;43m8\033[0;1;33;47mS\033[0;33;47m8\033[0;33;41mS:t\033[0;31mS.\033[0;32m;\033[0;31mX\033[0;30;41mS\033[0;37;43m@\033[0;33m:\033[0;31mt\033[0;32m.\033[0;34m      \033[0;32m   \033[0;31m .\033[0;32m.\033[0;33m8\033[0;1;37;47m8\033[0;37;47m;\033[0;33;43m \033[0;1;31;47m@\033[0;37;43m8\033[0;1;33;47m8\033[0;33;41mX\033[0;30m8\033[0;31m.\033[0;32m.\033[0;31m   \033[0;32m \033[0;34m    \033[0m\n"
printf "\033[0;31mt\033[0;33mSt\033[0;1;30m8\033[0;31mS\033[0;32mt\033[0;31m@\033[0;32;43m8\033[0;31m;\033[0;32m   \033[0;31m X\033[0;37;43m8\033[0;1;31;43m8\033[0;1;30;41m@\033[0;31mS.\033[0;34m. .\033[0;31m.\033[0;32m.\033[0;31m:\033[0;33;41mS\033[0;1;30;41m8\033[0;32m.    \033[0;34m   \033[0;32m     \033[0;31m S\033[0;1;30;43m;\033[0;1;33;47m8\033[0;33;47m8\033[0;1;33;47m8\033[0;37;41m8\033[0;33;47m8\033[0;31mS\033[0;32m. \033[0;34m \033[0;31m   \033[0;34m     \033[0m\n"
printf "\033[0;34m \033[0;31mS\033[0;33m@8\033[0;32m@\033[0;31mt\033[0;34m.\033[0;31m \033[0;34m \033[0;31m  \033[0;32m \033[0;31m \033[0;30;41m@\033[0;33;47m8\033[0;1;37;47m;\033[0;30;41m@\033[0;32m:.\033[0;31m   \033[0;34m  .\033[0;32m.       \033[0;34m    \033[0;32m  \033[0;34m \033[0;32m.\033[0;31m8\033[0;1;30;43m88\033[0;33;47m8\033[0;1;33;47m8\033[0;33;47m8\033[0;30;41m@\033[0;32m;\033[0;34m.\033[0;31m    \033[0;32m \033[0;34m     \033[0m\n"
printf "\033[0;32m .\033[0;31m8\033[0;1;30;43m;\033[0;31mS\033[0;32m;\033[0;31m.\033[0;34m  \033[0;31m  \033[0;32m .\033[0;33;41m8\033[0;37;43m8\033[0;1;33;47m@\033[0;33m8\033[0;31m:.\033[0;34m  \033[0;31m \033[0;34m \033[0;32m          \033[0;34m     \033[0;31m \033[0;32m \033[0;31m.\033[0;30;41m8\033[0;1;30;41m8\033[0;33;41mt\033[0;1;30;43m8\033[0;37;43m8\033[0;1;30;41m8\033[0;32m:.\033[0;31m      \033[0;34m     \033[0m\n"
printf "\033[0;34m \033[0;32m::\033[0;31m:\033[0;31m@\033[0;32m:\033[0;31m.\033[0;34m   \033[0;31m  \033[0;34m \033[0;1;30;41m@\033[0;1;30;47m8\033[0;1;37;47m:\033[0;1;30;43m8\033[0;31mS\033[0;34m.  \033[0;31m \033[0;34m \033[0;32m          \033[0;34m    \033[0;31m  \033[0;32m t\033[0;33m8\033[0;1;30;43m8\033[0;33;47mX\033[0;1;33;47m8\033[0;1;30;41m@\033[0;32m:  \033[0;31m      \033[0;34m     \033[0m\n"
printf "\033[0;34m \033[0;32m   .\033[0;31mt\033[0;32m.\033[0;34m   \033[0;31m  \033[0;32m \033[0;31m:\033[0;33;41m8\033[0;1;30;43m8\033[0;1;30;41m8\033[0;34m   \033[0;31m    \033[0;32m         \033[0;34m    \033[0;32m  \033[0;31m..t\033[0;1;30;43mt88\033[0;31mt\033[0;32m     \033[0;31m   \033[0;34m      \033[0m\n"
printf "\033[0;34m \033[0;32m   ..\033[0;34m    \033[0;31m \033[0;34m \033[0;32m  \033[0;31m.:\033[0;32m \033[0;34m   \033[0;31m    \033[0;32m        \033[0;34m    \033[0;32m  \033[0;31m.; X\033[0;33;41m8\033[0;33;47m8\033[0;33;41mS\033[0;34m.\033[0;32m       \033[0;34m       \033[0m\n"
printf "\033[0;34m \033[0;32m   \033[0;31mX\033[0;33m@8\033[0;31m;\033[0;32m \033[0;34m  \033[0;32m    \033[0;31m \033[0;32m \033[0;34m \033[0;31mt\033[0;31m@\033[0;31;43m8\033[0;33m:\033[0;1;30;43m8\033[0;33m8\033[0;31m:\033[0;33;41mX\033[0;33m8\033[0;1;30;43m88\033[0;1;30mX\033[0;31m.    \033[0;32m  \033[0;1;30m8\033[0;1;30;43mS@\033[0;30;41mS\033[0;1;30;41m8\033[0;1;30;43mS\033[0;31;43mS\033[0;31mS\033[0;32m.       \033[0;34m       \033[0m\n"
printf "\033[0;34m \033[0;32m  S\033[0;1;30;43m8\033[0;33;47m88\033[0;37;43m@\033[0;31m8\033[0;32m;\033[0;34m.\033[0;31m \033[0;32m  \033[0;31m t\033[0;31mS\033[0;1;30;43m8\033[0;37;43m8\033[0;33;47m8\033[0;37;43m8\033[0;1;33;47m@X\033[0;33;41mS\033[0;1;30;43mS@\033[0;1;33;47m8@8\033[0;33;41mX\033[0;1;30;43m8\033[0;33m@\033[0;31mS\033[0;32m.\033[0;31m.\033[0;32m \033[0;31m .\033[0;33m.\033[0;1;37;47m;\033[0;1;30;43mS\033[0;31;43mS8\033[0;31m@\033[0;34m:\033[0;32m.\033[0;34m \033[0;32m     \033[0;34m        \033[0m\n"
printf "\033[0;34m \033[0;32m \033[0;31m.\033[0;33;41m8\033[0;1;30;43m8\033[0;33;47m88\033[0;1;33;47m8\033[0;37;43m8\033[0;31m;\033[0;32m \033[0;31m.\033[0;32m \033[0;31m;\033[0;33mS\033[0;37;43m8X\033[0;1;33;47m88@\033[0;37;43m8\033[0;37;41m8\033[0;1;31;43m8\033[0;1;30;43m8\033[0;1;33;47m88\033[0;1;33;41m8\033[0;33;47m8\033[0;1;31;41mS\033[0;1;30;43mS\033[0;1;33;47m8\033[0;37;43m8\033[0;1;30;43m8\033[0;1;30;41m@\033[0;32m;\033[0;31m.\033[0;32m \033[0;31m.S\033[0;1;30;43m8\033[0;1;33;47m@\033[0;1;30;41m8\033[0;31m;\033[0;32m:\033[0;34m.\033[0;32m      \033[0;34m         \033[0m\n"
printf "\033[0;34m \033[0;31m \033[0;34m \033[0;32mt\033[0;1;30;41m8\033[0;1;30;43m8888\033[0;1;30;41m8\033[0;32m;\033[0;31mS\033[0;33m8\033[0;1;30;43m8\033[0;1;33;47m88\033[0;37;43m8\033[0;31;41mt\033[0;33;41m8\033[0;31;41m@\033[0;33m \033[0;1;31;43m8\033[0;1;30;43m8\033[0;33;47m8\033[0;37;43m8\033[0;1;33;47m8\033[0;37;41m8\033[0;31;43m8S\033[0;33;47m8\033[0;1;31;43m8\033[0;1;30;41mX\033[0;33;41m8\033[0;33;47m8\033[0;1;33;47m8\033[0;1;30;41m@\033[0;32m  \033[0;31m:@8\033[0;32mt\033[0;34m:\033[0;32m.\033[0;34m \033[0;32m     \033[0;34m          \033[0m\n"
printf "\033[0;34m   \033[0;32m .\033[0;31m;X\033[0;1;30;43mt \033[0;31;43m8\033[0;1;30;43m8\033[0;31;43m@\033[0;1;31;43m8\033[0;37;43m8\033[0;1;30;43m8\033[0;37;43m8\033[0;37;41m8\033[0;1;33;47m8\033[0;31;41m8\033[0;33;41m8\033[0;35;41mS\033[0;1;30;41m@\033[0;33;41m8\033[0;1;31;41mX\033[0;33;47m8\033[0;1;31;41mS\033[0;1;30;41m@\033[0;31;43m@\033[0;1;30;43m@\033[0;37;43m@\033[0;33;41m8@\033[0;1;30;43m8\033[0;1;33;47m8\033[0;37;43m8\033[0;1;30;43m8\033[0;31m;.\033[0;32m.;\033[0;34m:\033[0;32m.\033[0;31m.\033[0;34m    \033[0;32m   \033[0;34m          \033[0m\n"
printf "\033[0;34m  \033[0;32m   ..\033[0;34m  \033[0;32m8\033[0;31;43m@\033[0;1;30;43mS\033[0;31;43m@\033[0;33;41mX\033[0;35;47m8\033[0;1;31;43m8\033[0;1;33;47mX\033[0;33;47m8\033[0;1;33;47m@\033[0;37;43m8\033[0;33;43m.\033[0;37;43m8\033[0;1;30;43m@\033[0;1;31;43m8\033[0;37;43m@\033[0;1;30;43m8\033[0;33;41m8\033[0;30;41m@@S\033[0;31;43mX\033[0;1;30;43m8\033[0;1;33;47m8\033[0;33;47m8\033[0;37;43m8\033[0;33;47m8\033[0;31mS\033[0;34m . \033[0;32m.\033[0;34m                                    \033[0;31m$SCRIPT_NAME\n"
printf "\033[0;34m \033[0;32m     \033[0;34m  \033[0;31m :@\033[0;1;30;43m.\033[0;33m8t\033[0;1;33;47m8\033[0;33;47m@8\033[0;1;33;47m8\033[0;33;47m888\033[0;1;33;43mt\033[0;1;31;43m88\033[0;1;33;43m.\033[0;1;30;43m8.\033[0;30;41m@\033[0;1;30;41m8\033[0;31;43m8X\033[0;33;41m@\033[0;33;47m8\033[0;37;43m@\033[0;1;33;47mSX\033[0;31mS\033[0;34m                                          \033[0;31m$VERSION\n"
printf "\033[0;34m  \033[0;32m    \033[0;34m   \033[0;32m.;@\033[0;1;30;43mS\033[0;35mS\033[0;33m:\033[0;33;47m8\033[0;1;33;47m8\033[0;37;43m@\033[0;33;47m88\033[0;1;33;47m8\033[0;1;33;43m;\033[0;1;31;43m888\033[0;1;30;43m;\033[0;31;43m8\033[0;33;42m8\033[0;31;43m8XS\033[0;1;33;43m.\033[0;33;47m88\033[0;1;31;43m8\033[0;1;37;47m \033[0;30;41mS\033[0;34m.                      \033[0;31mversion date: $VERDATE\n"
printf "\033[0;34m  \033[0;32m   \033[0;34m    \033[0;32m \033[0;31m.:.X\033[0;33m8@S\033[0;1;30;43m8\033[0;33;47m888\033[0;1;33;47m8X\033[0;37;43m@\033[0;1;30;43mX\033[0;31;43mSX8X\033[0;33;41m@\033[0;1;33;43m:\033[0;33;43mt\033[0;33;47m@\033[0;1;33;47m8@\033[0;37;43m8\033[0;35mt\033[0;31mt.\033[0;34m                         \033[0;31m$DMAIL\n"
printf "\033[0;34m         \033[0;32m \033[0;31m  \033[0;32m..\033[0;34m  :\033[0;1;30m8\033[0;30m@\033[0;33m88;\033[0;33;47m88\033[0;1;33;47m8\033[0;33;47m888\033[0;1;33;43mS\033[0;33;47m888888\033[0;37;43m8\033[0;1;30;43m8\033[0;31m;      $DGIT\n"
printf "\n\033[0;31mTake the red pill?"
read

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
# Start log
touch rp_debug.log

# Get user info with whiptail
USER_IS_OK_WITH_THAT=1
until [ "$USER_IS_OK_WITH_THAT" == 0 ]
do
	NAME=$(whiptail --inputbox "Enter your name. Use your full name, not your nickname or just your first name. Your full legal name. If you get stuck check your passport :)" 12 48 --title "Your name" --cancel-button "Exit" 3>&1 1>&2 2>&3)
	EXITSTATUS=$?
	if [ $EXITSTATUS -ne 0 ]
	then
		echo "Exited on name entering dialog. Exit status: $EXITSTATUS" >> rp_debug.log
		exit $EXITSTATUS
	fi
	echo "User successfully entered name $NAME" >> rp_debug.log

	EMAIL=""
	until [[ "$EMAIL" =~ @neuralab.net$ ]]
	do
		EMAIL=$(whiptail --inputbox "Enter your email. Use your official Neuralab email, not your private Gmail, Yahoo, Hotmail. If you get stuck check if your email has the word \"neuralab\" in it :)" 12 48 --title "Your email" --cancel-button "Exit" 3>&1 1>&2 2>&3)
		EXITSTATUS=$?
		if [ $EXITSTATUS -ne 0 ]
		then
			echo "Exited on email entering dialog. Exit status: $EXITSTATUS" >> rp_debug.log
			exit $EXITSTATUS
		elif [[ ! "$EMAIL" =~ @neuralab.net$ ]]
		then
			echo "User entered a non @neuralab.net email address $EMAIL" >> rp_debug.log
			whiptail --msgbox "$EMAIL is not an @neuralab.net email!" --title "FAIL" 12 48
		fi
	done
	USER_IS_OK_WITH_THAT=$(whiptail --yesno "Your name: $NAME\nYour email: $EMAIL\nIs this correct?" 12 48 --title "You are" 3>&1 1>&2 2>&3)
	USER_IS_OK_WITH_THAT=$?
	echo "User confirms $NAME and $EMAIL? (0 = yes): $USER_IS_OK_WITH_THAT" >> rp_debug.log
done

echo "Users name set to $NAME" >> rp_debug.log
echo "Users email set to $EMAIL" >> rp_debug.log


# Check if SSH ed25519 keys are present, if not create keys
updatedb
mkdir -p /home/"${SUDO_USER}"/.ssh/
if ! [ -e "/home/${SUDO_USER}/.ssh/id_ed25519" ] || ! [ -e "/home/${SUDO_USER}/.ssh/id_ed25519.pub" ]
then
	printf "ed25519 keys not found.\n${RED}...generating keys${NC}\n"
	echo "SSH ed25519 keys not found. Generating..." >> rp_debug.log
	rm -f /home/"${SUDO_USER}"/.ssh/id_ed25519
	rm -f /home/"${SUDO_USER}"/.ssh/id_ed25519.pub
	ssh-keygen -t ed25519 -C "$EMAIL" -f /home/"${SUDO_USER}"/.ssh/id_ed25519 -N ""
	updatedb
	if [ -e "/home/${SUDO_USER}/.ssh/id_ed25519" ] && [ -e "/home/${SUDO_USER}/.ssh/id_ed25519.pub" ]
	then
		echo "SSH ed25519 keys created!" >> rp_debug.log
	else
		printf "${RED}FAIL: Cannot create SSH keys! Check rp_debug.log for more info.${NC}\n"
		echo "FAIL: Cannot create SSH keys! Error calling ssh-keygen -t ed25519 -C \"$EMAIL\"" >> rp_debug.log
		exit 1
	fi
else
	echo "SSH ed25519 keys found!" >> rp_debug.log
fi

# Start SSH agent and add credentials
eval `ssh-agent -s`
ssh-add /home/"${SUDO_USER}"/.ssh/id_ed25519
if ! [ $? == 0 ]
then
	echo "Cannot add your SSH private key to SSH agent. Exit status: $?" >> rp_debug.log
	exit 1
fi
chown -v $SUDO_USER /home/"${SUDO_USER}"/.ssh/id_ed25519
chown -v $SUDO_USER /home/"${SUDO_USER}"/.ssh/id_ed25519.pub

# install xclip
apt install xclip -y

# Show SSH public key, request to add it to Github, test connection
ADDED_TO_GITHUB=false
SSHKEY=$(cat /home/"${SUDO_USER}"/.ssh/id_ed25519.pub)
until [ "$ADDED_TO_GITHUB" == true ]
do
	TESTCONNECTION=1 # Error until not error
	until [ $TESTCONNECTION == 0 ]
	do
		whiptail --yesno "This is your SSH public key. Add it to Github.\n\n$SSHKEY" --title "Your SSH key" --yes-button "Test connection" --no-button "Copy to clipboard" 12 70
		TESTCONNECTION=$?
		if [ $TESTCONNECTION == 1 ]
		then
			echo $SSHKEY | xclip -sel clip
		fi
	done

	ssh -oStrictHostKeyChecking=no -T git@github.com
	EXITSTATUS=$?
	if [ $EXITSTATUS == 255 ] # permission denied
	then
		whiptail --yesno "Cannot connect to Github! Did you add your SSH key?" --title "FAIL" --yes-button "Try again" --no-button "Exit" 12 48
		if [ $? -ne 0 ]
		then
			exit 1
		fi
	elif [ $EXITSTATUS == 1 ] # connected but failed because Github doesn't provide shell
	then
		ADDED_TO_GITHUB=true
	else
		whiptail --msgbox "Unexpected error\nExit status: $EXITSTATUS" --title "FAIL" --ok-button "Exit" 12 48
		exit $EXITSTATUS
	fi
done
whiptail --msgbox "SUCCESS: Connected and authenticated on Github!" --title "SUCCESS" 12 48

# Update system
apt update && apt upgrade -y

# Install and config Git
apt install git-all -y
if git --version 2>&1 >/dev/null
then
	printf "${BLUE}SUCCESS: Git succesfully installed!${NC}\n"
else
	printf "${RED}FAIL: Git instalation failed!${NC} Error calling ${RED}apt install git-all -y${NC}\n${RED}...exiting${NC}\n"
	exit 1
fi

git config --global user.name "$NAME"
if [ $? -ne 0 ]
then
	printf "${RED}FAIL: Cannot set Git name!${NC} Error calling ${RED}git config --global user.name \"\$NAME\"${NC}\n${RED}...exiting${NC}\n"
	exit 1
fi
printf "${BLUE}SUCCESS: Git name set to ${NC}${NAME}\n"

printf "\n${RED}...setting your Git email to ${BLUE}${EMAIL}${NC}\n"
git config --global user.email "$EMAIL"
if [ $? -ne 0 ]
then
	printf "${RED}FAIL: Cannot set Git email!${NC} Error calling ${RED}git config --global user.email \"\$EMAIL\"${NC}\n${RED}...exiting${NC}\n"
	exit 1
fi
printf "${BLUE}SUCCESS: Git email set to ${NC}${EMAIL}\n"

printf "\n${RED}...setting line endings${NC}\n${GRAY}Git tries to convert line endings when you checkout code.\nThis can cause issues on Windows with some of our other tools.\nIn order to fix that we need to set your line ending conversion and force Git to use Unix line endings (LF) instead of the default Windows line endings (CRLF).${NC}\n"
git config --global core.autocrlf false
if [ $? -ne 0 ]
then
	printf "${RED}FAIL: Cannot set line endings!${NC} Error calling ${RED}git config --global core.autocrlf false${NC}\n${RED}...exiting${NC}\n"
	exit 1
fi
printf "${BLUE}SUCCESS: Git line endings set to LF${NC}\n"

# Install PHP 7.4
printf "\n${RED}...installing PHP 7.4${NC}\n"
apt install php7.4-cli -y
if [ $? -ne 0 ]
then
	printf "${RED}FAIL: Cannot install PHP 7.4 cli!${NC} Error calling ${RED}apt install php7.4-cli -y${NC}\n${RED}...exiting${NC}\n"
	exit 1
fi
printf "${BLUE}SUCCESS: PHP 7.4 cli installed!${NC}\n"
apt install php7.4-xmlwriter -y
if [ $? -ne 0 ]
then
	printf "${RED}FAIL: Cannot install PHP 7.4 xmlwriter!${NC} Error calling ${RED}apt install php7.4-xmlwriter -y${NC}\n${RED}...exiting${NC}\n"
	exit 1
fi
printf "${BLUE}SUCCESS: PHP 7.4 xmlwriter installed!${NC}\n"

# Install Composer
printf "\n${RED}...installing PHP 7.4${NC}\n"
apt install composer -y
if [ $? -ne 0 ]
then
	printf "${RED}FAIL: Cannot install Composer!${NC} Error calling ${RED}apt install composer -y${NC}\n${RED}...exiting${NC}\n"
	exit 1
fi
printf "${BLUE}SUCCESS: Composer installed!${NC}\n"

# Install coding standards
printf "\n${RED}...installing Neuralab coding standards${NC}\n"
su "$SUDO_USER" -c "composer global require neuralab/coding-standards:dev-master"
if [ $? -ne 0 ]
then
	printf "${RED}FAIL: Cannot install Neuralab coding standards!${NC} Error calling ${RED}composer global require neuralab/coding-standards:dev-master${NC}\n${RED}...exiting${NC}\n"
	exit 1
fi
printf "${BLUE}SUCCESS: Neuralab coding standards installed!${NC}\n"

# Check if phpcs added to path
phpcs -i
# If comannd not found then add to path:
if [ $? == 127 ]
then
	echo "export PATH=\"\$HOME/.composer/vendor/bin:\$PATH\"" >> /home/"$SUDO_USER"/.bashrc
fi

# Install Node version manager
printf "\n${RED}...installing Node Version Manager${NC}\n"
su "$SUDO_USER" -c "wget -qo- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"


NVM_DIR="/home/${SUDO_USER}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install 10.24.0

# Install Visual studio code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

apt install apt-transport-https
apt update
apt install code

# Install Virtual box
apt install virtualbox -y
apt install virtualbox-guest-additions-iso -y

# Install Vagrant
apt install vagrant -y
vagrant plugin install vagrant-bindfs
vagrant plugin install vagrant-faster

# Install homestead
git clone https://github.com/laravel/homestead.git /home/$SUDO_USER/homestead
cd /home/$SUDO_USER/homestead && git checkout release && bash init.sh

echo "function homestead() { ( cd ~/homestead && vagrant "\$\@" ) }" >> /home/"$SUDO_USER"/.bashrc
echo "export -f homestead" >> /home/"$SUDO_USER"/.bashrc

sed -i '/192.168./c\ip: "192.168.10.10"' /home/"$SUDO_USER"/homestead/Homestead.yaml
sed -i '/authorize:/c\authorize: ~/.ssh/id_ed25519.pub' /home/"$SUDO_USER"/homestead/Homestead.yaml
sed -i '/ssh\/id_rsa/c\    - ~/.ssh/id_ed25519' /home/"$SUDO_USER"/homestead/Homestead.yaml

sed -i -r '/^provider:/a variables:' /home/"$SUDO_USER"/homestead/Homestead.yaml
sed -i -r '/^variables:/a \ \ \ \ - key: IS_HOMESTEAD' /home/"$SUDO_USER"/homestead/Homestead.yaml
sed -i -r '/IS_HOMESTEAD/a \ \ \ \ \ \ value: "true"' /home/"$SUDO_USER"/homestead/Homestead.yaml

chown -R $SUDO_USER /home/$SUDO_USER/homestead

echo "192.168.10.10 dev.neuralab.test" >> /etc/hosts

mkdir /home/$SUDO_USER/www
chown -R $SUDO_USER /home/$SUDO_USER/www

printf "${BLUE}SUCCESS: Installed!\nClone reporitories to ~/www/\nAdd sites to:\n~/homestead/Homestead.yaml,\n/etc/hosts,\nreopen terminal and run \"homestead up --provision\"${NC}\n"
printf "Danke schön!"
