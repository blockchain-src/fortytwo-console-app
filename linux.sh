#!/bin/bash

animate_text() {
    local text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep 0.006
    done
    echo
}
animate_text_x2() {
    local text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep 0.0005
    done
    echo
}

auto_select_model() {
    if command -v nvidia-smi &> /dev/null; then
        AVAILABLE_MEM=$(nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits | head -n 1 | awk '{print $1 / 1024}')
        animate_text "    ↳ System analysis: ${AVAILABLE_MEM}GB VRAM detected"
    else
        AVAILABLE_MEM=$(awk '/MemTotal/ {print $2 / 1024 / 1024}' /proc/meminfo)
        animate_text "    ↳ System analysis: ${AVAILABLE_MEM}GB RAM detected"
    fi

    AVAILABLE_MEM_INT=$(printf "%.0f" "$AVAILABLE_MEM")

    if [ "$AVAILABLE_MEM_INT" -ge 32 ]; then
        animate_text "    🜲 Recommending: ⬢ 7 Qwen3 for problem solving & logical reasoning"
        LLM_HF_REPO="unsloth/Qwen3-30B-A3B-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-30B-A3B-Q4_K_M.gguf"
        NODE_NAME="Qwen3 30B A3B Q4_K_M"
    elif [ "$AVAILABLE_MEM_INT" -ge 24 ]; then
        animate_text "    🜲 Recommending: ⬢ 8 Phi-4 for mathematical intelligence"
        LLM_HF_REPO="unsloth/phi-4-GGUF"
        LLM_HF_MODEL_NAME="phi-4-Q4_K_M.gguf"
        NODE_NAME="Phi-4 Q4_K_M"
    elif [ "$AVAILABLE_MEM_INT" -ge 12 ]; then
        animate_text "    🜲 Recommending: ⬢ 2 Llama 3.2 for balanced capability"
        LLM_HF_REPO="bartowski/Llama-3.2-3B-Instruct-GGUF"
        LLM_HF_MODEL_NAME="Llama-3.2-3B-Instruct-Q4_K_M.gguf"
        NODE_NAME="Llama 3.2 3B Instruct Q4_K_M"
    else
        animate_text "    🜲 Recommending: ✶ 1 Custom Import Qwen 3 optimized for efficiency"
        LLM_HF_REPO="unsloth/Qwen3-1.7B-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-1.7B-Q4_K_M.gguf"
        NODE_NAME="Qwen 3 1.7B Q4_K_M"
    fi
}

BANNER="
   ▒█████░      ▒█████░    █████████░  █████████░
  ▓███████▓    ▓███████▓   █████████░  █████████░
 ░█████████░  ░█████████░  █████████░  █████████░
  ▓███████▓    ▓███████▓   █████████░  █████████░
   ▒█████░      ▒█████░    █████████░  █████████░
                           █████████░  █████████░
   ▒█████░      ▒█████░    █████████░  █████████░
  ▓███████▓    ▓███████▓   █████████░  █████████░
 ░█████████░  ░█████████░  █████████░  █████████░
  ▓███████▓    ▓███████▓   █████████░  █████████░
   ▒█████░      ▒█████░    █████████░  █████████░
"
BANNER_FULLNAME="

 ▒██  ░█▓░  ▒███  ▒███   ▒█████▒             █▓           ▒▓
████░ ████░ ▒███  ▒███   ▒█▒     ▒▓░▒  ▒██▓░▓██▒▒▓▓   ▓▒▒███▓░█▓  █▓  ▓█  ▒▓░▒
 ▒▓░   ▒▓░  ▒███  ▒███   ▒████▒ ▒█  ▓█ ██▒ ░ ██░  █▓  ▓█░ ██  ██ ▓▓█  ██ ▒█  ▓█
 ░▓▓   ░▓▓  ▒███  ▒███   ▒█░    █▓  █▓ ▓█    █▒   ▒█▒█▓   █▓  ░█▒█▒██▒█▓ █▓  █▓
████░ ████░ ▒███  ▒███   ▒█░    ▒█  ▓█ ██    █▓    ▓██░   ██   ███ ▒██▒  ▒█  ▓█
 ▒██   ░▓▒  ▒███  ▒███   ▒█░     ░▒▓░  █▓    ░░▓▒   ▓█░   ▒░▓▒  █▒  █▒░   ░▓▓░
                                                 ░░█▓
"
animate_text_x2 "$BANNER"
animate_text "      Welcome to ::|| Fortytwo, Noderunner."
echo
PROJECT_DIR="./FortytwoNode"
PROJECT_DEBUG_DIR="$PROJECT_DIR/debug"
PROJECT_MODEL_CACHE_DIR="$PROJECT_DIR/model_cache"

CAPSULE_EXEC="$PROJECT_DIR/FortytwoCapsule"
CAPSULE_LOGS="$PROJECT_DEBUG_DIR/FortytwoCapsule.logs"
CAPSULE_READY_URL="http://0.0.0.0:42442/ready"

PROTOCOL_EXEC="$PROJECT_DIR/FortytwoProtocol"
PROTOCOL_DB_DIR="$PROJECT_DEBUG_DIR/internal_db"

ACCOUNT_PRIVATE_KEY_FILE="$PROJECT_DIR/.account_private_key"

UTILS_EXEC="$PROJECT_DIR/FortytwoUtils"

animate_text "Preparing your node environment..."

if [[ ! -d "$PROJECT_DEBUG_DIR" || ! -d "$PROJECT_MODEL_CACHE_DIR" ]]; then
    mkdir -p "$PROJECT_DEBUG_DIR" "$PROJECT_MODEL_CACHE_DIR"
    echo
    # animate_text "Project directory created: $PROJECT_DIR"
else
    echo
    # animate_text "Project directory already exists: $PROJECT_DIR"
fi

USER=$(logname)
chown "$USER:$USER" "$PROJECT_DIR"

if ! command -v curl &> /dev/null; then
    animate_text "    ↳ Curl is not installed. Installing curl..."
    apt update && apt install -y curl
    echo
fi

animate_text "▒▓░ Checking for the Latest Components Versions ░▓▒"
echo
animate_text "◰ Setup script"

# --- Update setup script ---
INSTALLER_UPDATE_URL="https://raw.githubusercontent.com/Fortytwo-Network/fortytwo-console-app/main/linux.sh"
SCRIPT_PATH="$0"
TEMP_FILE=$(mktemp)

curl -fsSL -o "$TEMP_FILE" "$INSTALLER_UPDATE_URL"

# Check download
if [ ! -s "$TEMP_FILE" ]; then
    echo "    ✕ ERROR: Failed to download the update. Check your internet connection and try again."
    exit 1
fi

# Compare
if cmp -s "$SCRIPT_PATH" "$TEMP_FILE"; then
    # No update needed
    echo "    ✓ Up to date."
    rm "$TEMP_FILE"
else
    echo "    ↳ Updating..."
    cp "$SCRIPT_PATH" "${SCRIPT_PATH}.bak"
    cp "$TEMP_FILE" "$SCRIPT_PATH"
    chmod +x "$SCRIPT_PATH"
    rm "$TEMP_FILE"
    echo "    ↺ Restarting script..."
    sleep 3
    exec "$SCRIPT_PATH" "$@"
    echo "    ✕ ERROR: exec failed."
    exit 1
fi
# --- End Update setup script ---

CAPSULE_VERSION=$(curl -s "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/latest")
animate_text "⎔ Capsule — version $CAPSULE_VERSION"
DOWNLOAD_CAPSULE_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/FortytwoCapsule-linux-amd64"
if [[ -f "$CAPSULE_EXEC" ]]; then
    CURRENT_CAPSULE_VERSION_OUTPUT=$("$CAPSULE_EXEC" --version 2>/dev/null)
    if [[ "$CURRENT_CAPSULE_VERSION_OUTPUT" == *"$CAPSULE_VERSION"* ]]; then
        animate_text "    ✓ Up to date"
    else
        animate_text "    ↳ Updating..."
        if command -v nvidia-smi &> /dev/null; then
            animate_text "    ↳ NVIDIA detected. Downloading capsule for NVIDIA systems..."
            DOWNLOAD_CAPSULE_URL+="-cuda124"
        else
            animate_text "    ↳ No NVIDIA GPU detected. Downloading CPU capsule..."
        fi
        curl -L -o "$CAPSULE_EXEC" "$DOWNLOAD_CAPSULE_URL"
        chmod +x "$CAPSULE_EXEC"
        animate_text "    ✓ Successfully updated"
    fi
else
    if command -v nvidia-smi &> /dev/null; then
        animate_text "    ↳ NVIDIA detected. Downloading capsule for NVIDIA systems..."
        DOWNLOAD_CAPSULE_URL+="-cuda124"
    else
        animate_text "    ↳ No NVIDIA GPU detected. Downloading CPU capsule..."
    fi
    curl -L -o "$CAPSULE_EXEC" "$DOWNLOAD_CAPSULE_URL"
    chmod +x "$CAPSULE_EXEC"
    animate_text "    ✓ Installed to: $CAPSULE_EXEC"
fi
PROTOCOL_VERSION=$(curl -s "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/latest")
animate_text "⏃ Protocol Node — version $PROTOCOL_VERSION"
DOWNLOAD_PROTOCOL_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/v$PROTOCOL_VERSION/FortytwoProtocolNode-linux-amd64"
if [[ -f "$PROTOCOL_EXEC" ]]; then
    CURRENT_PROTOCOL_VERSION_OUTPUT=$("$PROTOCOL_EXEC" --version 2>/dev/null)

    if [[ "$CURRENT_PROTOCOL_VERSION_OUTPUT" == *"$PROTOCOL_VERSION"* ]]; then
        animate_text "    ✓ Up to date"
    else
        animate_text "    ↳ Updating..."
        curl -L -o "$PROTOCOL_EXEC" "$DOWNLOAD_PROTOCOL_URL"
        chmod +x "$PROTOCOL_EXEC"
        animate_text "    ✓ Successfully updated"
    fi
else
    animate_text "    ↳ Downloading..."
    curl -L -o "$PROTOCOL_EXEC" "$DOWNLOAD_PROTOCOL_URL"
    chmod +x "$PROTOCOL_EXEC"
    animate_text "    ✓ Installed to: $PROTOCOL_EXEC"
fi
UTILS_VERSION=$(curl -s "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/utilities/latest")
animate_text "⨳ Utils — version $UTILS_VERSION"
DOWNLOAD_UTILS_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/utilities/v$UTILS_VERSION/FortytwoUtilsLinux"
if [[ -f "$UTILS_EXEC" ]]; then
    CURRENT_UTILS_VERSION_OUTPUT=$("$UTILS_EXEC" --version 2>/dev/null)
    if [[ "$CURRENT_UTILS_VERSION_OUTPUT" == *"$UTILS_VERSION"* ]]; then
        animate_text "    ✓ Up to date"
    else
        animate_text "    ↳ Updating..."
        curl -L -o "$UTILS_EXEC" "$DOWNLOAD_UTILS_URL"
        chmod +x "$UTILS_EXEC"
        animate_text "    ✓ Successfully updated"
    fi
else
    animate_text "    ↳ Downloading..."
    curl -L -o "$UTILS_EXEC" "$DOWNLOAD_UTILS_URL"
    chmod +x "$UTILS_EXEC"
    animate_text "    ✓ Installed to: $UTILS_EXEC"
fi

echo
animate_text "▒▓░ Identity Initialization ░▓▒"

if [[ -f "$ACCOUNT_PRIVATE_KEY_FILE" ]]; then
    ACCOUNT_PRIVATE_KEY=$(cat "$ACCOUNT_PRIVATE_KEY_FILE")
    echo
    animate_text "    ↳ Private key found at $PROJECT_DIR/.account_private_key."
    animate_text "    ↳ Initiating the node using an existing identity."
    animate_text "    ⚠ Keep the private key safe. Do not share with anyone."
    echo "    ⚠ Recover your node or access your wallet with it."
    echo "    ⚠ We will not be able to recover it if it is lost."
else
    echo
    echo -e "╔════════════════════ NETWORK IDENTITY ═══════════════════╗"
    echo -e "║                                                         ║"
    echo -e "║  Each node requires a secure blockchain identity.       ║"
    echo -e "║  Select one of the following options:                   ║"
    echo -e "║                                                         ║"
    echo -e "║  1. Create a new identity with an invite code.          ║"
    echo -e "║     Recommended for new nodes.                          ║"
    echo -e "║                                                         ║"
    echo -e "║  2. Recover an existing identity with recovery phrase.  ║"
    echo -e "║     Use this if you're restoring a previous node.       ║"
    echo -e "║                                                         ║"
    echo -e "╚═════════════════════════════════════════════════════════╝"
    echo
    read -r -p "Select option [1-2]: " IDENTITY_OPTION
    echo
    IDENTITY_OPTION=${IDENTITY_OPTION:-1}
    if [[ "$IDENTITY_OPTION" == "2" ]]; then
        animate_text "[2] Recovering existing identity"
        echo
        while true; do
            read -r -p "Enter your account recovery phrase (12, 18, or 24 words), then press Enter: " ACCOUNT_SEED_PHRASE
            echo
            if ! ACCOUNT_PRIVATE_KEY=$("$UTILS_EXEC" --phrase "$ACCOUNT_SEED_PHRASE"); then
                echo "˙◠˙ Error: Please check the recovery phrase and try again."
                continue
            else
                animate_text "$ACCOUNT_PRIVATE_KEY" > "$ACCOUNT_PRIVATE_KEY_FILE"
                animate_text "˙ᵕ˙ The identity successfully restored!"
                animate_text "    ↳ Private key saved to $PROJECT_DIR/.account_private_key."
                echo "    ⚠ Keep the key secure. Do not share with anybody."
                echo "    ⚠ Restore your node or access your wallet with it."
                echo "    ⚠ We will not be able to recover it would it be lost."
                break
            fi
        done
    else
        animate_text "[1] Creating a new identity with an invite code"
        echo
        while true; do
            read -r -p "Enter your invite code: " INVITE_CODE
            echo
            if [[ -z "$INVITE_CODE" || ${#INVITE_CODE} -lt 12 ]]; then
                echo "˙◠˙ Invalid invite code. Check the code and try again."
                echo
                continue
            fi
            break
        done
        animate_text "    ↳ Validating your identity..."
        WALLET_UTILS_EXEC_OUTPUT="$("$UTILS_EXEC" --create-wallet "$ACCOUNT_PRIVATE_KEY_FILE" --drop-code "$INVITE_CODE" 2>&1)"
        UTILS_EXEC_CODE=$?

        if [ "$UTILS_EXEC_CODE" -gt 0 ]; then
            echo "$WALLET_UTILS_EXEC_OUTPUT" | tail -n 1
            echo
            echo "˙◠˙ This code has already been activated. Please check your code and try again. You entered: $INVITE_CODE"
            echo
            rm -f "$ACCOUNT_PRIVATE_KEY_FILE"
            exit 1
        fi
        animate_text "    ↳ Write down your new node identity:"
        echo "$WALLET_UTILS_EXEC_OUTPUT"
        ACCOUNT_PRIVATE_KEY=$(<"$ACCOUNT_PRIVATE_KEY_FILE")
        echo
        animate_text "    ✓ Identity configured and securely stored!"
        echo
        echo -e "╔═════════════════ ATTENTION, NODERUNNER ═════════════════╗"
        echo -e "║                                                         ║"
        echo -e "║  1. Write down your secret recovery phrase              ║"
        echo -e "║  2. Keep your private key safe                          ║"
        echo -e "║     ↳ Get .account_private_key key from ./FortytwoNode/ ║"
        echo -e "║     ↳ Store it outside the App directory                ║"
        echo -e "║                                                         ║"
        echo -e "║  ⚠ Keep the recovery phrase and private key safe.       ║"
        echo -e "║  ⚠ Do not share them with anyone.                       ║"
        echo -e "║  ⚠ Use them to restore your node or access your wallet. ║"
        echo -e "║  ⚠ We won't be able to recover them if they are lost.   ║"
        echo -e "║                                                         ║"
        echo -e "╚═════════════════════════════════════════════════════════╝"
        echo
        while true; do
            read -r -p "To continue, please type 'Done': " user_input
            if [ "$user_input" = "Done" ]; then
                break
            fi
            echo "Incorrect input. Please type 'Done' to continue."
        done
    fi
fi
echo
animate_text "▒▓░ The Unique Strength of Your Node ░▓▒"
echo
animate_text "Each AI node has unique strengths."
animate_text "Choose how your node will contribute to the collective intelligence:"
echo 
auto_select_model
# echo "    Already downloaded models: ⬢ 4, ⬢ 5"
echo
echo "╔═══════════════════════════════════════════════════════════════════════════╗"
animate_text_x2 "║ 0 ⌖ AUTO-SELECT - Optimal configuration                                   ║"
echo "║     Let the system determine the best model for your hardware.            ║"
echo "║     Balanced for performance and capabilities.                            ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
animate_text_x2 "║ 1 ✶ IMPORT CUSTOM - Advanced configuration                                ║"
#echo "╠═══════════════════════════════════════════════════════════════════════════╣"
#animate_text_x2 "║ 2 ↺ LAST USED - Run the model that was run the last time                  ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
animate_text_x2 "║ 2 ⬢ GENERAL KNOWLEDGE                   Llama 3.2 3B Instruct • 2.2GB RAM ║"
echo "║     Versatile multi-domain intelligence core with balanced capabilities.  ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
animate_text_x2 "║ 3 ⬢ ADVANCED REASONING                   INTELLECT-1 Instruct • 6.5GB RAM ║"
echo "║     High-precision logical analysis matrix optimized for problem-solving. ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
animate_text_x2 "║ 4 ⬢ PROGRAMMING & TECHNICAL         Qwen2.5 Coder 7B Instruct • 4.8GB RAM ║"
echo "║     Specialized system for code synthesis and framework construction.     ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
animate_text_x2 "║ 5 ⬢ ACADEMIC KNOWLEDGE             Ministral 8B Instruct 2410 • 5.2GB RAM ║"
echo "║     Advanced data integration and research synthesis protocol.            ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
animate_text_x2 "║ 6 ⬢ LANGUAGE & WRITING                               Qwen3 8B • 5.1GB RAM ║"
echo "║     Enhanced natural language and communication protocol interface.       ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
animate_text_x2 "║ 7 ⬢ LOGICAL REASONING                          Qwen3 30B A3B • 18.6GB RAM ║"
echo "║     High-level reasoning, mathematical problem-solving                    ║"
echo "║     and competitive coding.                                               ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
animate_text_x2 "║ 8 ⬢ MATHEMATICAL INTELLIGENCE                       Phi-4 14B • 9.1GB RAM ║"
echo "║     Optimized for symbolic reasoning, step-by-step math solutions         ║"
echo "║     and logic-based inference.                                            ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
animate_text_x2 "║ 9 ⬢ MULTILINGUAL UNDERSTANDING                     Gemma-3 4B • 3.3GB RAM ║"
echo "║     Balanced intelligence with high-quality cross-lingual comprehension,  ║"
echo "║     translation and multilingual reasoning.                               ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
animate_text_x2 "║ 10 ⬢ COMPETITIVE PROGRAMMING & ALGORITHMS     OlympicCoder 7B • 4.8GB RAM ║"
echo "║     Optimized for competitive coding, excelling in algorithmic challenges ║"
echo "║     and CodeForces-style programming tasks.                               ║"
echo "╚═══════════════════════════════════════════════════════════════════════════╝"
echo

read -r -p "Select your node's specialization [0-10] (0 for auto-select): " NODE_CLASS

case $NODE_CLASS in
    0)
        animate_text "⌖ Analyzing system for optimal configuration:"
        auto_select_model
        ;;
    1)
        echo
        echo "══════════════════ CUSTOM MODEL IMPORT ════════════════════"
        echo "     Intended for users familiar with language models."
        echo
        read -r -p "Enter HuggingFace repository (e.g., Qwen/Qwen2.5-3B-Instruct-GGUF): " LLM_HF_REPO
        read -r -p "Enter model filename (e.g., qwen2.5-3b-instruct-q4_k_m.gguf): " LLM_HF_MODEL_NAME
        NODE_NAME="✶ CUSTOM IMPORT: HuggingFace ${LLM_HF_REPO##*/}"
        ;;
    2)
        LLM_HF_REPO="bartowski/Llama-3.2-3B-Instruct-GGUF"
        LLM_HF_MODEL_NAME="Llama-3.2-3B-Instruct-Q4_K_M.gguf"
        NODE_NAME="⬢ GENERAL KNOWLEDGE: Llama 3.2 3B Instruct Q4_K_M"
        ;;
    3)
        LLM_HF_REPO="bartowski/INTELLECT-1-Instruct-GGUF"
        LLM_HF_MODEL_NAME="INTELLECT-1-Instruct-Q4_K_M.gguf"
        NODE_NAME="⬢ ADVANCED REASONING: INTELLECT-1 Instruct Q4_K_M"
        ;;
    4)
        LLM_HF_REPO="Qwen/Qwen2.5-Coder-7B-Instruct-GGUF"
        LLM_HF_MODEL_NAME="qwen2.5-coder-7b-instruct-q4_k_m-00001-of-00002.gguf"
        NODE_NAME="⬢ PROGRAMMING & TECHNICAL: Qwen2.5 Coder 7B Instruct Q4_K_M"
        ;;
    5)
        LLM_HF_REPO="bartowski/Ministral-8B-Instruct-2410-GGUF"
        LLM_HF_MODEL_NAME="Ministral-8B-Instruct-2410-Q4_K_M.gguf"
        NODE_NAME="⬢ ACADEMIC KNOWLEDGE: Ministral 8B Instruct 2410 Q4_K_M"
        ;;
    6)
        LLM_HF_REPO="unsloth/Qwen3-8B-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-8B-Q4_K_M.gguf"
        NODE_NAME="⬢ LANGUAGE & WRITING: Qwen3 8B Q4_K_M"
        ;;
    7)
        LLM_HF_REPO="unsloth/Qwen3-30B-A3B-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-30B-A3B-Q4_K_M.gguf"
        NODE_NAME="⬢ LOGICAL REASONING: Qwen3 30B A3B Q4_K_M"
        ;;
    8)
        LLM_HF_REPO="unsloth/phi-4-GGUF"
        LLM_HF_MODEL_NAME="phi-4-Q4_K_M.gguf"
        NODE_NAME="⬢ MATHEMATICAL INTELLIGENCE: Phi-4 14B Q4_K_M"
        ;;
    9)
        LLM_HF_REPO="unsloth/gemma-3-12b-it-GGUF"
        LLM_HF_MODEL_NAME="gemma-3-12b-it-Q4_K_M.gguf"
        NODE_NAME="⬢ MULTILINGUAL UNDERSTANDING: Gemma-3 4B Q4_K_M"
        ;;
    10)
        LLM_HF_REPO="bartowski/open-r1_OlympicCoder-7B-GGUF"
        LLM_HF_MODEL_NAME="open-r1_OlympicCoder-7B-Q4_K_M.gguf"
        NODE_NAME="⬢ COMPETITIVE PROGRAMMING & ALGORITHMS: OlympicCoder 7B Q4_K_M"
        ;;
    *)
        animate_text "No selection made. Continuing with [0] ⌖ AUTO-SELECT..."
        auto_select_model
        ;;
esac
echo
echo "You chose:"
animate_text "${NODE_NAME}"
echo
animate_text "    ↳ Downloading the model and preparing the environment may take several minutes..."
"$UTILS_EXEC" --hf-repo "$LLM_HF_REPO" --hf-model-name "$LLM_HF_MODEL_NAME" --model-cache "$PROJECT_MODEL_CACHE_DIR"
echo
animate_text "Setup completed. Ready to launch."
# clear
animate_text_x2 "$BANNER_FULLNAME"

startup() {
    animate_text "⎔ Starting Capsule..."
    "$CAPSULE_EXEC" --llm-hf-repo "$LLM_HF_REPO" --llm-hf-model-name "$LLM_HF_MODEL_NAME" --model-cache "$PROJECT_MODEL_CACHE_DIR" > "$CAPSULE_LOGS" 2>&1 &
    CAPSULE_PID=$!

    animate_text "Be patient, it may take some time."
    while true; do
        STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$CAPSULE_READY_URL")
        if [[ "$STATUS_CODE" == "200" ]]; then
            animate_text "Capsule is ready."
            break
        else
            # Capsule is not ready. Retrying in 5 seconds...
            sleep 5
        fi
        if ! kill -0 "$CAPSULE_PID" 2>/dev/null; then
            echo -e "\033[0;31mCapsule process exited (PID: $CAPSULE_PID)\033[0m"
            if [[ -f "$CAPSULE_LOGS" ]]; then
                tail -n 1 "$CAPSULE_LOGS"
        fi
            exit 1
        fi
    done
    animate_text "⏃ Starting Protocol..."
    echo
    animate_text "Joining ::||"
    echo
    "$PROTOCOL_EXEC" --account-private-key "$ACCOUNT_PRIVATE_KEY" --db-folder "$PROTOCOL_DB_DIR" &
    PROTOCOL_PID=$!
}

cleanup() {
    echo
    capsule_stopped=$(kill -0 "$CAPSULE_PID" 2>/dev/null && kill "$CAPSULE_PID" 2>/dev/null && echo true || echo false)
    [ "$capsule_stopped" = true ] && animate_text "⎔ Stopping capsule..."

    protocol_stopped=$(kill -0 "$PROTOCOL_PID" 2>/dev/null && kill "$PROTOCOL_PID" 2>/dev/null && echo true || echo false)
    [ "$protocol_stopped" = true ] && animate_text "⏃ Stopping protocol..."

    if [ "$capsule_stopped" = true ] || [ "$protocol_stopped" = true ]; then
        animate_text "Processes stopped"
        animate_text "Bye, Noderunner"
    fi
    exit 0
}

startup
trap cleanup SIGINT SIGTERM SIGHUP EXIT

while true; do
    IS_ALIVE="true"
    if ! ps -p "$CAPSULE_PID" > /dev/null; then
        echo "Capsule has stopped. Restarting..."
        IS_ALIVE="false"
    fi

    if ! ps -p "$PROTOCOL_PID" > /dev/null; then
        echo "Node has stopped. Restarting..."
        IS_ALIVE="false"
    fi

    if [[ $IS_ALIVE == "false" ]]; then
        echo "Capsule or Protocol process has stopped. Restarting..."
        kill "$CAPSULE_PID" 2>/dev/null
        kill "$PROTOCOL_PID" 2>/dev/null
        startup
    fi

    sleep 5
done
