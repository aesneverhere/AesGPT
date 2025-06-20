#!/bin/bash

# Warna & blok visual
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

progress_bar() {
  echo -ne "${CYAN}[#####                    ] (20%)\r"; sleep 1
  echo -ne "[##########              ] (40%)\r"; sleep 1
  echo -ne "[###############         ] (60%)\r"; sleep 1
  echo -ne "[####################    ] (80%)\r"; sleep 1
  echo -ne "[########################] (100%)\r\n"; sleep 0.5
}

clear
echo -e "${PURPLE}"
echo "     ░█▀█░█▀█░█▀▀░░░█▀▀░█░█░▀█▀░█▀█░█▀▀"
echo "     ░█▀▀░█▀█░█▀▀░░░█░█░█░█░░█░░█░█░▀▀█"
echo "     ░▀░░░▀░▀░▀▀▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀"
echo -e "${CYAN}        Smart Setup for aesGPTbot by @aesneverhere${NC}\n"

echo -e "${CYAN}🔍 Mendeteksi sistem dan menyesuaikan instalasi...${NC}"

# Deteksi OS
OS=""
if grep -qE "Android" <<< "$(uname -a)"; then
    OS="termux"
elif grep -qi "debian" /etc/os-release 2>/dev/null || grep -qi "ubuntu" /etc/os-release 2>/dev/null; then
    OS="debian"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
elif [[ "$REPL_ID" ]]; then
    OS="replit"
else
    OS="unknown"
fi

progress_bar

# Install sistem dependency berdasarkan OS
echo -e "${CYAN}📦 Menginstal paket sistem (build tools & python)...${NC}"
case $OS in
    termux)
        pkg update -y && pkg upgrade -y > /dev/null
        pkg install -y python clang libffi openssl curl git rust > /dev/null
        ;;
    debian)
        apt update -y && apt upgrade -y > /dev/null
        apt install -y python3 python3-pip gcc g++ libffi-dev libssl-dev rustc build-essential git curl > /dev/null
        ;;
    mac)
        echo "🍎 Deteksi macOS. Pastikan Homebrew sudah terpasang!"
        brew install python rust openssl libffi > /dev/null
        ;;
    replit)
        echo "💻 Replit terdeteksi. Lewati APT."
        ;;
    *)
        echo -e "${CYAN}⚠️ Tidak dapat mendeteksi OS. Lanjut install Python packages saja.${NC}"
        ;;
esac

progress_bar

# Install Python packages
echo -e "${CYAN}📦 Menginstal Python requirements...${NC}"
python3 -m pip install --upgrade pip > /dev/null
python3 -m pip install -r requirements.txt > /dev/null

progress_bar

# Isi ENV
read -p "🤖 BOT_TOKEN Telegram: " BOT_TOKEN
read -p "🧠 OPENAI_API_KEY (bebas untuk mode proxy): " OPENAI_API_KEY
read -p "🌐 Mode API (proxy/openai) [default: proxy]: " MODE
MODE=${MODE:-proxy}

cat <<EOF > .env
BOT_TOKEN=$BOT_TOKEN
OPENAI_API_KEY=$OPENAI_API_KEY
MODE=$MODE
EOF

progress_bar

echo -e "${CYAN}✅ Setup selesai! File .env berhasil dibuat.${NC}"
echo -e "${PURPLE}🚀 Jalankan bot dengan: python3 main.py${NC}"
