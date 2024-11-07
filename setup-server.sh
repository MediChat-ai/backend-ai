#!/bin/bash

RED='\e[31m'
GREEN='\e[32m'
RESET='\e[0m'

echo -e "${GREEN}[+] Updating system...${RESET}"
apt-get update -y
apt-get upgrade -y
apt-get install git wget lshw -y

echo -e "${GREEN}[+] Downloading quantized model from Hugging Face...${RESET}"

cd /
wget -O medichat-Q4_K_M.gguf "https://huggingface.co/d3vle0/medichat/resolve/main/medichat-Q4_K_M.gguf?download=true"

echo -e "${GREEN}[+] Installing ollama...${RESET}"
(curl -fsSL https://ollama.com/install.sh | sh && ollama serve > ollama.log 2>&1) &
echo "FROM medichat-Q4_K_M.gguf" > /medi.Modelfile
ollama create medi -f /medi.Modelfile
# ollama run medi

echo -e "${GREEN}[+] Ready to serve model! Type ${RED}ollama run medi${GREEN} to run model in your terminal.${RESET}"
