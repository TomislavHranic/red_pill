#! /bin/bash

NC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
GRAY='\033[1;30m'

# Check if root
if [ "$EUID" -ne 0 ]
then
	printf "${RED}FAIL: Run as root!${NC}\n"
	printf "Run command: sudo bash rp.sh\n"
	exit 1
fi

# Get user name and email
USER_IS_OK_WITH_THAT="n"
until [ "$USER_IS_OK_WITH_THAT" == "y" ]
do
	printf "\n${YELLOW}--> YOUR NAME${NC}\n${GRAY}Use your full name, not your nickname or just your first name. Your${NC} ${GREEN}full legal name${NC}${GRAY}. If you get stuck check your passport :)${NC}\n"
	read -p "Enter your name --> " NAME
	EMAIL=""
	until [[ "$EMAIL" =~ @neuralab.net$ ]]
	do
		printf "\n${YELLOW}--> YOUR EMAIL${NC}\n${GRAY}Use${NC} ${GREEN}your official Neuralab email${NC}${GRAY}, not your private Gmail, Yahoo, Hotmail. If you get stuck check if your email has the word \"neuralab\" in it :)${NC}\n"
		read -p "Enter your Neuralab email --> " EMAIL
		if [[ ! "$EMAIL" =~ @neuralab.net$ ]]
		then
			printf "${RED}FAIL: Your email is not an @neuralab.net email!${NC}\n"
		fi
	done
	printf "\n${YELLOW}Your name:${NC}  ${GREEN}${NAME}${NC}\n"
	printf "${YELLOW}Your email:${NC} ${GREEN}${EMAIL}${NC}\n"
	read -p "Is this correct? (y/n) --> " USER_IS_OK_WITH_THAT
	until [ "$USER_IS_OK_WITH_THAT" == "y" ] || [ "$USER_IS_OK_WITH_THAT" == "n" ]
	do
		printf "Respond with ${GREEN}y${NC} or ${RED}n${NC} --> "
		read USER_IS_OK_WITH_THAT
	done
done

# Create ssh keys and connect to Github
bash ./scripts/ssh.sh
if [ $? -ne 0]
then
	exit 1
fi

# Install and setup Git
printf "\n${YELLOW}...installing Git${NC}\n"
apt install git-all -y
if git --version 2>&1 >/dev/null
then
	printf "${GREEN}SUCCESS: Git succesfully installed!${NC}\n"
else
	printf "${RED}FAIL: Git instalation failed!${NC} Error calling ${YELLOW}apt install git-all -y${NC}\n${YELLOW}...exiting${NC}\n"
	exit 1
fi

printf "\n${YELLOW}...setting your Git name to ${GREEN}${NAME}${NC}\n"
git config --global user.name "$NAME"
if [ $? -ne 0 ]
then
	printf "${RED}FAIL: Cannot set Git name!${NC} Error calling ${YELLOW}git config --global user.name \"\$NAME\"${NC}\n${YELLOW}...exiting${NC}\n"
	exit 1
fi
printf "${GREEN}SUCCESS: Git name set to ${NC}${NAME}\n"

printf "\n${YELLOW}...setting your Git email to ${GREEN}${EMAIL}${NC}\n"
git config --global user.email "$EMAIL"
if [ $? -ne 0 ]
then
	printf "${RED}FAIL: Cannot set Git email!${NC} Error calling ${YELLOW}git config --global user.email \"\$EMAIL\"${NC}\n${YELLOW}...exiting${NC}\n"
	exit 1
fi
printf "${GREEN}SUCCESS: Git email set to ${NC}${EMAIL}\n"

printf "\n${YELLOW}...setting line endings${NC}\n${GRAY}Git tries to convert line endings when you checkout code.\nThis can cause issues on Windows with some of our other tools.\nIn order to fix that we need to set your line ending conversion and force Git to use Unix line endings (LF) instead of the default Windows line endings (CRLF).${NC}\n"
git config --global core.autocrlf false
if [ $? -ne 0 ]
then
	printf "${RED}FAIL: Cannot set line endings!${NC} Error calling ${YELLOW}git config --global core.autocrlf false${NC}\n${YELLOW}...exiting${NC}\n"
	exit 1
fi
printf "${GREEN}SUCCESS: Git line endings set to LF${NC}\n"

# Install PHP 7.4
printf "\n${YELLOW}...installing PHP 7.4${NC}\n"
apt install php7.4-cli -y
if [ $? -ne 0 ]
then
	printf "${RED}FAIL: Cannot install PHP 7.4 cli!${NC} Error calling ${YELLOW}apt install php7.4-cli -y${NC}\n${YELLOW}...exiting${NC}\n"
	exit 1
fi
printf "${GREEN}SUCCESS: PHP 7.4 cli installed!${NC}\n"
apt install php7.4-xmlwriter -y
if [ $? -ne 0 ]
then
	printf "${RED}FAIL: Cannot install PHP 7.4 xmlwriter!${NC} Error calling ${YELLOW}apt install php7.4-xmlwriter -y${NC}\n${YELLOW}...exiting${NC}\n"
	exit 1
fi
printf "${GREEN}SUCCESS: PHP 7.4 xmlwriter installed!${NC}\n"

# Install Composer
printf "\n${YELLOW}...installing PHP 7.4${NC}\n"
apt install composer -y
if [ $? -ne 0 ]
then
	printf "${RED}FAIL: Cannot install Composer!${NC} Error calling ${YELLOW}apt install composer -y${NC}\n${YELLOW}...exiting${NC}\n"
	exit 1
fi
printf "${GREEN}SUCCESS: Composer installed!${NC}\n"

# Install coding standards
printf "\n${YELLOW}...installing Neuralab coding standards${NC}\n"
su "$SUDO_USER" -c "composer global require neuralab/coding-standards:dev-master"
if [ $? -ne 0 ]
then
	printf "${RED}FAIL: Cannot install Neuralab coding standards!${NC} Error calling ${YELLOW}apt install composer -y${NC}\n${YELLOW}...exiting${NC}\n"
	exit 1
fi
printf "${GREEN}SUCCESS: Neuralab coding standards installed!${NC}\n"

# Check if phpcs added to path
phpcs -i
# If comannd not found then add to path:
if [ $? == 127 ]
then
	echo "export PATH=\"\$HOME/.composer/vendor/bin:\$PATH\"" >> /home/"$SUDO_USER"/.bashrc
fi

su "$SUDO_USER" -c "phpcs -i"
