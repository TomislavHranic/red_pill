#! /bin/bash

NC='\033[0m'
RED='\033[0;31m'
BLUE='\033[0;34m'
GRAY='\033[1;30m'

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
sleep 3
printf "\n\033[0;5;31mTake the red pill..."
sleep 2
printf "\n"

# Get user name and email
USER_IS_OK_WITH_THAT="n"
until [ "$USER_IS_OK_WITH_THAT" == "y" ]
do
	printf "\n${RED}--> YOUR NAME${NC}\n${GRAY}Use your full name, not your nickname or just your first name. Your${NC} ${BLUE}full legal name${NC}${GRAY}. If you get stuck check your passport :)${NC}\n"
	read -p "Enter your name --> " NAME
	EMAIL=""
	until [[ "$EMAIL" =~ @neuralab.net$ ]]
	do
		printf "\n${RED}--> YOUR EMAIL${NC}\n${GRAY}Use${NC} ${BLUE}your official Neuralab email${NC}${GRAY}, not your private Gmail, Yahoo, Hotmail. If you get stuck check if your email has the word \"neuralab\" in it :)${NC}\n"
		read -p "Enter your Neuralab email --> " EMAIL
		if [[ ! "$EMAIL" =~ @neuralab.net$ ]]
		then
			printf "${RED}FAIL: Your email is not an @neuralab.net email!${NC}\n"
		fi
	done
	printf "\n${RED}Your name:${NC}  ${BLUE}${NAME}${NC}\n"
	printf "${RED}Your email:${NC} ${BLUE}${EMAIL}${NC}\n"
	read -p "Is this correct? (y/n) --> " USER_IS_OK_WITH_THAT
	until [ "$USER_IS_OK_WITH_THAT" == "y" ] || [ "$USER_IS_OK_WITH_THAT" == "n" ]
	do
		printf "Respond with ${BLUE}y${NC} or ${RED}n${NC} --> "
		read USER_IS_OK_WITH_THAT
	done
done


# Check if SSH ed25519 keys are present, if not create keys
updatedb
mkdir -p /home/"${SUDO_USER}"/.ssh/
printf "\n${RED}...checking if SSH ed25519 keys are present${NC}\n"
if ! [ -e "/home/${SUDO_USER}/.ssh/id_ed25519" ] || ! [ -e "/home/${SUDO_USER}/.ssh/id_ed25519.pub" ]
then
	printf "ed25519 keys not found.\n${RED}...generating keys${NC}\n"
	rm -f /home/"${SUDO_USER}"/.ssh/id_ed25519
	rm -f /home/"${SUDO_USER}"/.ssh/id_ed25519.pub
	ssh-keygen -t ed25519 -C "$EMAIL" -f /home/"${SUDO_USER}"/.ssh/id_ed25519 -N ""
	updatedb
	if [ -e "/home/${SUDO_USER}/.ssh/id_ed25519" ] && [ -e "/home/${SUDO_USER}/.ssh/id_ed25519.pub" ]
	then
		printf "${BLUE}SUCCESS: SSH keys created!${NC}\n"
	else
		printf "${RED}FAIL: Cannot create SSH keys!${NC} Error calling ${RED}ssh-keygen -t ed25519 -C \"\$EMAIL\"${NC}\n${RED}...exiting${NC}\n"
		exit 1
	fi
else
	printf "${BLUE}SUCCESS: ed25519 keys found!${NC}\n"
fi

# Start SSH agent and add credentials
printf "\n${RED}...starting SSH agent${NC}\n"
eval `ssh-agent -s`
printf "${RED}...adding your SSH private key to SSH agent${NC}\n"
ssh-add /home/"${SUDO_USER}"/.ssh/id_ed25519
if ! [ $? == 0 ]
then
	printf "${RED}FAIL: Cannot add your SSH private key to SSH agent${NC}\n${RED}...exiting${NC}\n"
	exit 1
fi
chown -v $SUDO_USER /home/"${SUDO_USER}"/.ssh/id_ed25519
chown -v $SUDO_USER /home/"${SUDO_USER}"/.ssh/id_ed25519.pub

# Show SSH public key, request to add it to Github, test connection
ADDED_TO_GITHUB=false
until [ "$ADDED_TO_GITHUB" == true ]
do
	printf "\n\nThis is your SSH public key. Add it to Github. ${GRAY}( CTRL + INS to copy )${NC}\n\n"
	cat /home/"${SUDO_USER}"/.ssh/id_ed25519.pub
	printf "\n\n"
	read -n 1 -s -r -p "Press any key to proceed..."
	ssh -oStrictHostKeyChecking=no -T git@github.com
	if [ $? == 255 ] # permission denied
	then
		printf "\n${RED}FAIL: Cannot connect to Github! Did you add your SSH key?${NC}"
	elif [ $? == 1 ] # connected but failed because Github doesn't provide shell
	then
		ADDED_TO_GITHUB=true
	else
		printf "\n${RED}FAIL: Unexpected error${NC}\n${RED}...exiting${NC}\n"
	fi
done
printf "\n${BLUE}SUCCESS: Connected and authenticated on Github!${NC}\n"

# Update system
apt update && apt upgrade -y

# Install and setup Git
printf "\n${RED}...installing Git${NC}\n"
apt install git-all -y
if git --version 2>&1 >/dev/null
then
	printf "${BLUE}SUCCESS: Git succesfully installed!${NC}\n"
else
	printf "${RED}FAIL: Git instalation failed!${NC} Error calling ${RED}apt install git-all -y${NC}\n${RED}...exiting${NC}\n"
	exit 1
fi

printf "\n${RED}...setting your Git name to ${BLUE}${NAME}${NC}\n"
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

nvm install 15.12.0

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
