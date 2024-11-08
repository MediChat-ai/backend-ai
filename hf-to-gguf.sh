#!/bin/bash

RED='\e[31m'
GREEN='\e[32m'
RESET='\e[0m'

if [ -z "$1" ]; then
        echo -e "${RED}[-] err: argument required!${RESET}"
        exit 1
fi

echo -e "${GREEN}[+] Updating system...${RESET}"
apt-get update -y
apt-get upgrade -y
apt-get install git wget unzip -y
cd $HOME

echo -e "${GREEN}[+] Downloading AI Model...${RESET}"
wget 'https://raw.githubusercontent.com/MediChat-ai/backend-ai/refs/heads/main/download_model.py' -O download_model.py
python3 -m pip install huggingface_hub
python3 download_model.py $1

git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp/
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install -r requirements.txt
if [[ "$1" == */* ]]; then
        MODEL_BASE_PATH="$HOME/.cache/huggingface/hub/models--$(echo "$1" | sed 's/\//--/')/snapshots"
else
        exit 1
fi
LATEST_SNAPSHOT=$(ls -td ${MODEL_BASE_PATH}/* | head -1)

echo -e "${GREEN}[+] Converting .hf to .gguf...${RESET}"
python3 convert_hf_to_gguf.py --outtype f16 "$LATEST_SNAPSHOT"
cd $HOME

wget 'https://github.com/ggerganov/llama.cpp/releases/download/b3987/llama-b3987-bin-ubuntu-x64.zip'
unzip ./llama-b3987-bin-ubuntu-x64.zip
cd $HOME/build/bin/

echo -e "${GREEN}[+] Quantizing model...${RESET}"
LATEST_GGUF_FILE=$(find "$LATEST_SNAPSHOT" -type f -name "*.gguf" -printf "%T@ %p\n" | sort -n | tail -1 | awk '{print $2}')
./llama-quantize ${LATEST_GGUF_FILE} Q4_K_M

echo -e "${GREEN}[+] Quantized model saved in ${LATEST_SNAPSHOT}${RESET}"