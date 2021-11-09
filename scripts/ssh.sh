#! /bin/bash

NC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'

# Check if SSH ed25519 keys are present, if not create keys
updatedb
mkdir -p /home/"${SUDO_USER}"/.ssh/
printf "\n${YELLOW}...checking if SSH ed25519 keys are present${NC}\n"
if ! [ -e "/home/${SUDO_USER}/.ssh/id_ed25519" ] || ! [ -e "/home/${SUDO_USER}/.ssh/id_ed25519.pub" ]
then
	printf "ed25519 keys not found.\n${YELLOW}...generating keys${NC}\n"
	rm -f /home/"${SUDO_USER}"/.ssh/id_ed25519
	rm -f /home/"${SUDO_USER}"/.ssh/id_ed25519.pub
	ssh-keygen -t ed25519 -C "$EMAIL" -f /home/"${SUDO_USER}"/.ssh/id_ed25519 -N ""
	updatedb
	if [ -e "/home/${SUDO_USER}/.ssh/id_ed25519" ] && [ -e "/home/${SUDO_USER}/.ssh/id_ed25519.pub" ]
	then
		printf "${GREEN}SUCCESS: SSH keys created!${NC}\n"
	else
		printf "${RED}FAIL: Cannot create SSH keys!${NC} Error calling ${RED}ssh-keygen -t ed25519 -C \"\$EMAIL\"${NC}\n${YELLOW}...exiting${NC}\n"
		exit 1
	fi
else
	printf "${GREEN}SUCCESS: ed25519 keys found!${NC}\n"
fi

# Start SSH agent and add credentials
printf "\n${YELLOW}...starting SSH agent${NC}\n"
eval `ssh-agent -s`
printf "${YELLOW}...adding your SSH private key to SSH agent${NC}\n"
ssh-add /home/"${SUDO_USER}"/.ssh/id_ed25519
if ! [ $? == 0 ]
then
	printf "${RED}FAIL: Cannot add your SSH private key to SSH agent${NC}\n${YELLOW}...exiting${NC}\n"
	exit 2
fi
chown -v $SUDO_USER /home/"${SUDO_USER}"/.ssh/id_ed25519
chown -v $SUDO_USER /home/"${SUDO_USER}"/.ssh/id_ed25519.pub

# Show SSH public key, request to add key to Github, test connection
ADDED_TO_GITHUB=false
until [ "$ADDED_TO_GITHUB" == true ]
do
	printf "\n\nThis is your SSH public key. Add it to Github.\n\n"
	cat /home/"${SUDO_USER}"/.ssh/id_ed25519.pub
	printf "\n\n"
	read -n 1 -s -r -p "Press any key to proceed..."
	ssh -oStrictHostKeyChecking=no -T git@github.com
	if [ $? == 255 ]
	then
		printf "\n${RED}FAIL: Cannot connect to Github! Did you add your SSH key?${NC}"
	elif [ $? == 1 ]
	then
		ADDED_TO_GITHUB=true
	else
		printf "\n${RED}FAIL: Unexpected error${NC}\n${YELLOW}...exiting${NC}\n"
		exit 3
	fi
done
printf "\n${GREEN}SUCCESS: Connected and authenticated on Github!${NC}\n"
exit 0
