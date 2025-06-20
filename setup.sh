#!/bin/bash

# Warna dan simbol
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Banner
clear
echo -e "${PURPLE}"
echo "     ░█▀█░█▀█░█▀▀░░░█▀▀░█░█░▀█▀░█▀█░█▀▀"
echo "     ░█▀▀░█▀█░█▀▀░░░█░█░█░█░░█░░█░█░▀▀█"
echo "     ░▀░░░▀░▀░▀▀▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀"
echo -e "${CYAN}         Setup aesGPTbot · by @aesneverhere${NC}"
echo ""

# Function: Progress block
progress_block() {
  echo -ne "${CYAN}[#####                   ] (25%)\r"
  sleep 1
  echo -ne "[##########              ] (50%)\r"
  sleep 1
  echo -ne "[###############         ] (75%)\r"
  sleep 1
  echo -ne "[#######################] (100%)\r"
  echo -e "\n${NC}"
}

echo -e "${CYAN}🔧 Memulai update & instalasi dependencies...\n"
progress_block

# APT install (untuk Termux/Ubuntu)
if command -v apt &> /dev/null; then
  pkg update -y && pkg upgrade -y &> /dev/null || apt update -y && apt upgrade -y &> /dev/null
  apt install -y python3 python3-pip git curl &> /dev/null
fi

# Install pip requirements
pip install --upgrade pip &> /dev/null
pip install -r requirements.txt &> /dev/null

echo -e "${CYAN}📦 Semua dependency berhasil dipasang!\n"

# Input interaktif
read -p "🤖 BOT_TOKEN Telegram: " BOT_TOKEN
read -p "🧠 OPENAI_API_KEY (proxy = bebas): " OPENAI_API_KEY
read -p "🌐 Mode (proxy/openai) [default: proxy]: " MODE

MODE=${MODE:-proxy}

# Simpan ke .env
cat <<EOF > .env
BOT_TOKEN=${BOT_TOKEN}
OPENAI_API_KEY=${OPENAI_API_KEY}
MODE=${MODE}
EOF

echo -e "\n✅ ${CYAN}.env berhasil dibuat!"
echo -e "🚀 Jalankan bot kamu sekarang dengan: ${PURPLE}python main.py${NC}\n"
