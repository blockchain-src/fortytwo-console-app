#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "Restarting the script with sudo..."
    exec sudo bash "$0" "$@"
fi

BANNER="
███████╗ ██████╗ ██████╗ ████████╗██╗   ██╗████████╗██╗    ██╗ ██████╗
██╔════╝██╔═══██╗██╔══██╗╚══██╔══╝╚██╗ ██╔╝╚══██╔══╝██║    ██║██╔═══██╗
█████╗  ██║   ██║██████╔╝   ██║    ╚████╔╝    ██║   ██║ █╗ ██║██║   ██║
██╔══╝  ██║   ██║██╔══██╗   ██║     ╚██╔╝     ██║   ██║███╗██║██║   ██║
██║     ╚██████╔╝██║  ██║   ██║      ██║      ██║   ╚███╔███╔╝╚██████╔╝
╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝      ╚═╝      ╚═╝    ╚══╝╚══╝  ╚═════╝

███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝
██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗
██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
"
echo "$BANNER"

PROJECT_DIR="/opt/FortytwoNode"
PROJECT_DEBUG_DIR="$PROJECT_DIR/debug"

CAPSULE_EXEC="$PROJECT_DIR/FortyTwoCapsule"
CAPSULE_LOGS="$PROJECT_DEBUG_DIR/FortyTwoCapsule.logs"
CAPSULE_READY_URL="http://0.0.0.0:42042/ready"

PROTOCOL_EXEC="$PROJECT_DIR/FortyTwoProtocol"
PROTOCOL_LOGS="$PROJECT_DEBUG_DIR/FortyTwoProtocol.logs"
PROTOCOL_DB_DIR="$PROJECT_DEBUG_DIR/internal_db"

ACCOUNT_PRIVATE_KEY_FILE="$PROJECT_DIR/.account_private_key"

DOWNLOAD_CONVERTOR_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/utilities/phrase_to_pkey_darwin"
CONVERTOR_EXEC="$PROJECT_DIR/phrase_to_pkey"

if [[ ! -d "$PROJECT_DEBUG_DIR" ]]; then
    mkdir -p "$PROJECT_DEBUG_DIR"
    echo "Project directory created: $PROJECT_DIR"
else
    echo "Project directory already exists: $PROJECT_DIR"
fi

USER=${SUDO_USER:-$(whoami)}
chown "$USER:$USER" "$PROJECT_DIR"

if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Please install curl using 'brew install curl' and re-run the script."
    exit 1
fi

PROTOCOL_VERSION=$(curl -s "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/latest")
echo "Latest protocol version is $PROTOCOL_VERSION"
DOWNLOAD_PROTOCOL_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/v$PROTOCOL_VERSION/FortytwoProtocolNode-darwin"

CAPSULE_VERSION=$(curl -s "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/latest")
echo "Latest capsule version is $CAPSULE_VERSION"
DOWNLOAD_CAPSULE_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/FortytwoCapsule-darwin"


if [[ -f "$CAPSULE_EXEC" ]]; then
    CURRENT_CAPSULE_VERSION_OUTPUT=$("$CAPSULE_EXEC" --version 2>/dev/null)
    if [[ "$CURRENT_CAPSULE_VERSION_OUTPUT" == *"$CAPSULE_VERSION"* ]]; then
        echo "Capsule is already up to date (version found: $CURRENT_CAPSULE_VERSION_OUTPUT). Skipping download."
    else
        curl -L -o "$CAPSULE_EXEC" "$DOWNLOAD_CAPSULE_URL"
        chmod +x "$CAPSULE_EXEC"
        echo "Capsule downloaded to: $CAPSULE_EXEC"
    fi
else
    curl -L -o "$CAPSULE_EXEC" "$DOWNLOAD_CAPSULE_URL"
    chmod +x "$CAPSULE_EXEC"
    echo "Capsule downloaded to: $CAPSULE_EXEC"
fi

if [[ -f "$PROTOCOL_EXEC" ]]; then
    CURRENT_PROTOCOL_VERSION_OUTPUT=$("$PROTOCOL_EXEC" --version 2>/dev/null)
    if [[ "$CURRENT_PROTOCOL_VERSION_OUTPUT" == *"$PROTOCOL_VERSION"* ]]; then
        echo "Node is already up to date (version found: $CURRENT_PROTOCOL_VERSION_OUTPUT). Skipping download."
    else
        echo "Node is outdated (found version: $CURRENT_PROTOCOL_VERSION_OUTPUT, expected: $PROTOCOL_VERSION). Downloading new version..."
        curl -L -o "$PROTOCOL_EXEC" "$DOWNLOAD_PROTOCOL_URL"
        chmod +x "$PROTOCOL_EXEC"
        echo "Node downloaded to: $PROTOCOL_EXEC"
    fi
else
    curl -L -o "$PROTOCOL_EXEC" "$DOWNLOAD_PROTOCOL_URL"
    chmod +x "$PROTOCOL_EXEC"
    echo "Node downloaded to: $PROTOCOL_EXEC"
fi
echo "You can use any LLM from Hugging Face, but only in the .gguf format. Below is a table with examples."
echo "| HuggingFace LLM Repository                | LLM Name                                             | ~VRAM, Gb |"
echo "|-------------------------------------------|------------------------------------------------------|-----------|"
echo "| Qwen/Qwen2.5-1.5B-Instruct-GGUF           | qwen2.5-1.5b-instruct-q4_k_m.gguf                    | 1.15      |"
echo "| Qwen/Qwen2.5-3B-Instruct-GGUF             | qwen2.5-3b-instruct-q4_k_m.gguf                      | 2.1       |"
echo "| Qwen/Qwen2.5-7B-Instruct-GGUF             | qwen2.5-7b-instruct-q4_k_m-00001-of-00002.gguf       | 4.8       |"
echo "| Qwen/Qwen2.5-32B-Instruct-GGUF            | qwen2.5-32b-instruct-q4_k_m-00001-of-00005.gguf      | 20        |"
echo "| Qwen/Qwen2.5-72B-Instruct-GGUF            | qwen2.5-72b-instruct-q4_k_m-00001-of-00012.gguf      | 47        |"
echo "| Qwen/Qwen2.5-Coder-1.5B-Instruct-GGUF     | qwen2.5-coder-1.5b-instruct-q4_k_m.gguf              | 1.15      |"
echo "| Qwen/Qwen2.5-Coder-3B-Instruct-GGUF       | qwen2.5-coder-3b-instruct-q4_k_m.gguf                | 2.1       |"
echo "| Qwen/Qwen2.5-Coder-7B-Instruct-GGUF       | qwen2.5-coder-7b-instruct-q4_k_m-00001-of-00002.gguf | 4.8       |"
echo "| Qwen/Qwen2.5-Coder-32B-Instruct-GGUF      | qwen2.5-coder-32b-instruct-q4_k_m.gguf               | 20        |"
echo "| bartowski/Ministral-8B-Instruct-2410-GGUF | Ministral-8B-Instruct-2410-Q4_K_M.gguf               | 5.2       |"
echo "| bartowski/Llama-3.2-3B-Instruct-GGUF      | Llama-3.2-3B-Instruct-Q4_K_M.gguf                    | 2.2       |"
echo "| bartowski/INTELLECT-1-Instruct-GGUF       | INTELLECT-1-Instruct-Q4_K_M.gguf                     | 6.5       |"

read -r -p "Enter HuggingFace LLM repository (Press Enter to use the default: Qwen/Qwen2.5-3B-Instruct-GGUF): " LLM_HF_REPO
LLM_HF_REPO=${LLM_HF_REPO:-"Qwen/Qwen2.5-3B-Instruct-GGUF"}

read -r -p "Enter HuggingFace LLM model name only with .gguf extension (Press Enter to use the default: qwen2.5-3b-instruct-q4_k_m.gguf): " LLM_HF_MODEL_NAME
LLM_HF_MODEL_NAME=${LLM_HF_MODEL_NAME:-"qwen2.5-3b-instruct-q4_k_m.gguf"}

echo "Using LLM Repository: $LLM_HF_REPO"
echo "Using LLM Model Name: $LLM_HF_MODEL_NAME"

if [[ -f "$ACCOUNT_PRIVATE_KEY_FILE" ]]; then
    ACCOUNT_PRIVATE_KEY=$(cat "$ACCOUNT_PRIVATE_KEY_FILE")
    echo "Using saved account private key."
else
    if [[ ! -f "$CONVERTOR_EXEC" ]]; then
        curl -L -o "$CONVERTOR_EXEC" "$DOWNLOAD_CONVERTOR_URL"
        chmod +x "$CONVERTOR_EXEC"
    fi
    while true; do
        read -r -p "Enter your account recovery phrase (12, 18, or 24 words), then press Enter: " ACCOUNT_SEED_PHRASE
        echo
        if ! ACCOUNT_PRIVATE_KEY=$("$CONVERTOR_EXEC" "$ACCOUNT_SEED_PHRASE"); then
            echo "Error: Please check the recovery phrase and try again."
            continue
        else
            echo "$ACCOUNT_PRIVATE_KEY" > "$ACCOUNT_PRIVATE_KEY_FILE"
            echo "Private key saved."
            break
        fi
    done
fi

echo "Setup completed."

"$CAPSULE_EXEC" --llm-hf-repo "$LLM_HF_REPO" --llm-hf-model-name "$LLM_HF_MODEL_NAME" > "$CAPSULE_LOGS" 2>&1 &
CAPSULE_PID=$!
echo "Be patient during the first launch of the capsule; it will take some time to download the model artifacts, depending on your internet connection."
echo "Waiting for Capsule download models weight and started..."
while true; do
    STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$CAPSULE_READY_URL")
    if [[ "$STATUS_CODE" == "200" ]]; then
        echo "Capsule is ready!"
        break
    else
        echo "Capsule is not ready. Retrying in 5 seconds..."
        sleep 5
    fi
done

"$PROTOCOL_EXEC" --account-private-key "$ACCOUNT_PRIVATE_KEY" --db-folder "$PROTOCOL_DB_DIR" > "$PROTOCOL_LOGS" 2>&1 &
PROTOCOL_PID=$!

cleanup() {
    kill "$CAPSULE_PID" "$PROTOCOL_PID"
    exit 0
}

trap cleanup SIGINT SIGTERM EXIT

while true; do
    if ! ps -p "$CAPSULE_PID" > /dev/null; then
        echo "Capsule has stopped."
        exit 1
    fi

    if ! ps -p "$PROTOCOL_PID" > /dev/null; then
        echo "Node has stopped."
        exit 1
    fi

    echo "FortytwoNode is running..."
    sleep 5
done
