#!/bin/bash

BOLD="\e[1m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NC="\e[0m"

SWARM_DIR="$HOME/rl-swarm"
TEMP_DATA_PATH="$SWARM_DIR/modal-login/temp-data"
HOME_DIR="$HOME"

cd "$HOME"

echo -e "${BOLD}${YELLOW}🔍 Checking for existing Gensyn node setup...${NC}"

if [ -f "$SWARM_DIR/swarm.pem" ]; then
    echo -e "${BOLD}${GREEN}🪪 swarm.pem already exists.${NC}\n"
    echo -e "${BOLD}${YELLOW}Do you want to:${NC}"
    echo -e "${BOLD}1) Reuse existing swarm.pem${NC}"
    echo -e "${BOLD}${RED}2) Delete it and start fresh${NC}"

    while true; do
        read -p $'\e[1mEnter your choice (1 or 2): \e[0m' choice
        case $choice in
            1)
                echo -e "\n${BOLD}${YELLOW}[✓] Reusing swarm.pem and login data...${NC}"
                mv "$SWARM_DIR/swarm.pem" "$HOME_DIR/"
                mv "$TEMP_DATA_PATH/userData.json" "$HOME_DIR/" 2>/dev/null
                mv "$TEMP_DATA_PATH/userApiKey.json" "$HOME_DIR/" 2>/dev/null
                rm -rf "$SWARM_DIR"
                echo -e "${BOLD}${YELLOW}[✓] Cloning fresh repo...${NC}"
                git clone https://github.com/zunxbt/rl-swarm.git > /dev/null 2>&1
                mv "$HOME_DIR/swarm.pem" rl-swarm/
                mv "$HOME_DIR/userData.json" rl-swarm/modal-login/temp-data/ 2>/dev/null
                mv "$HOME_DIR/userApiKey.json" rl-swarm/modal-login/temp-data/ 2>/dev/null
                break
                ;;
            2)
                echo -e "${BOLD}${YELLOW}[✓] Removing old data and cloning fresh...${NC}"
                rm -rf "$SWARM_DIR"
                git clone https://github.com/zunxbt/rl-swarm.git > /dev/null 2>&1
                break
                ;;
            *)
                echo -e "${BOLD}${RED}[✗] Invalid choice. Please enter 1 or 2.${NC}"
                ;;
        esac
    done
else
    echo -e "${BOLD}${YELLOW}[✓] No existing node found. Cloning now...${NC}"
    [ -d rl-swarm ] && rm -rf rl-swarm
    git clone https://github.com/zunxbt/rl-swarm.git > /dev/null 2>&1
fi

cd rl-swarm || { echo -e "${BOLD}${RED}[✗] Failed to enter rl-swarm. Exiting.${NC}"; exit 1; }

echo -e "${BOLD}${GREEN}✅ Node repo ready. Launching...${NC}"
./run_rl_swarm.sh
