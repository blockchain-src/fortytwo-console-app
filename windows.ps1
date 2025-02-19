if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script must be run as Administrator!"
    Start-Sleep -Seconds 2
    Exit 1
}

# $BANNER = @"
# ███████╗ ██████╗ ██████╗ ████████╗██╗   ██╗████████╗██╗    ██╗ ██████╗
# ██╔════╝██╔═══██╗██╔══██╗╚══██╔══╝╚██╗ ██╔╝╚══██╔══╝██║    ██║██╔═══██╗
# █████╗  ██║   ██║██████╔╝   ██║    ╚████╔╝    ██║   ██║ █╗ ██║██║   ██║
# ██╔══╝  ██║   ██║██╔══██╗   ██║     ╚██╔╝     ██║   ██║███╗██║██║   ██║
# ██║     ╚██████╔╝██║  ██║   ██║      ██║      ██║   ╚███╔███╔╝╚██████╔╝
# ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝      ╚═╝      ╚═╝    ╚══╝╚══╝  ╚═════╝

# ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
# ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
# ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝
# ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗
# ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
# ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
# "@
# Write-Host $BANNER

$PROJECT_DIR = "$env:LOCALAPPDATA\FortytwoNode"
$PROJECT_DEBUG_DIR = "$PROJECT_DIR\debug"
$CAPSULE_ZIP = "$PROJECT_DIR\capsule_cuda.zip"
$EXTRACTED_CUDA_EXEC = "$PROJECT_DIR\FortytwoCapsule-windows-amd64-cuda124.exe"
$CAPSULE_EXEC = "$PROJECT_DIR\FortyTwoCapsule.exe"
$CAPSULE_LOGS = "$PROJECT_DEBUG_DIR\FortyTwoCapsule.log"
$CAPSULE_ERR_LOGS = "$PROJECT_DEBUG_DIR\FortyTwoCapsule_err.log"
$CAPSULE_READY_URL = "http://localhost:42042/ready"

$PROTOCOL_EXEC = "$PROJECT_DIR\FortyTwoProtocol.exe"
$PROTOCOL_LOGS = "$PROJECT_DEBUG_DIR\FortyTwoProtocol.log"
$PROTOCOL_ERR_LOGS = "$PROJECT_DEBUG_DIR\FortyTwoProtocol_err.log"
$PROTOCOL_DB_DIR = "$PROJECT_DEBUG_DIR\internal_db"

$ACCOUNT_PRIVATE_KEY_FILE = "$PROJECT_DIR\.account_private_key"

$DOWNLOAD_CONVERTOR_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/utilities/phrase_to_pkey.exe"
$CONVERTOR_EXEC="$PROJECT_DIR\phrase_to_pkey.exe"

if (-Not (Test-Path $PROJECT_DEBUG_DIR)) {
    New-Item -ItemType Directory -Path $PROJECT_DEBUG_DIR | Out-Null
    Write-Host "Project directory created: $PROJECT_DIR"
} else {
    Write-Host "Project directory already exists: $PROJECT_DIR"
}

function Cleanup {
    if ($CAPSULE_PROC -and $CAPSULE_PROC.HasExited -eq $false) {
        Write-Host "Stopping Capsule..."
        Stop-Process -Id $CAPSULE_PROC.Id -Force -ErrorAction SilentlyContinue
    } else {
        Write-Host "Capsule process is not running."
    }

    if ($PROTOCOL_PROC -and $PROTOCOL_PROC.HasExited -eq $false) {
        Write-Host "Stopping Node..."
        Stop-Process -Id $PROTOCOL_PROC.Id -Force -ErrorAction SilentlyContinue
    } else {
        Write-Host "Node process is not running."
    }

    Write-Host "Processes stopped. Exiting."
    exit 0
}

trap {
    Write-Host "`nDetected Ctrl+C. Stopping processes..."
    Cleanup
}


$PROTOCOL_VERSION = (Invoke-RestMethod "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/latest").Trim()
Write-Output "Latest protocol version is $PROTOCOL_VERSION"
$DOWNLOAD_PROTOCOL_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/v$PROTOCOL_VERSION/FortytwoProtocolNode-windows-amd64.exe"

$CAPSULE_VERSION = (Invoke-RestMethod "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/latest").Trim()
Write-Output "Latest capsule version is $CAPSULE_VERSION"


if (Test-Path $CAPSULE_EXEC) {
    $CURRENT_CAPSULE_VERSION_OUTPUT = & $CAPSULE_EXEC --version 2>$null
    if ($CURRENT_CAPSULE_VERSION_OUTPUT -match $CAPSULE_VERSION) {
        Write-Host "Capsule is already up to date (version found: $CURRENT_CAPSULE_VERSION_OUTPUT). Skipping download."
    } else {
        if (Get-Command "nvidia-smi.exe" -ErrorAction SilentlyContinue) {
            Write-Host "NVIDIA detected. Downloading Capsule (CUDA version)..."
            $DOWNLOAD_CAPSULE_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/windows-amd64-cuda124.zip"
            Invoke-WebRequest -Uri $DOWNLOAD_CAPSULE_URL -OutFile $CAPSULE_ZIP
            Write-Host "Extracting CUDA Capsule..."
            Expand-Archive -Path $CAPSULE_ZIP -DestinationPath $PROJECT_DIR -Force
            Remove-Item $CAPSULE_ZIP -Force

            if (Test-Path $EXTRACTED_CUDA_EXEC) {
                Rename-Item -Path $EXTRACTED_CUDA_EXEC -NewName "FortyTwoCapsule.exe" -Force
                Write-Host "Renamed CUDA Capsule to: $CAPSULE_EXEC"
            } else {
                Write-Host "ERROR: Expected CUDA executable not found in extracted files!"
                Exit 1
            }
        } else {
            Write-Host "No NVIDIA GPU detected. Downloading CPU Capsule..."
            $DOWNLOAD_CAPSULE_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/FortytwoCapsule-windows-amd64.exe"
            Invoke-WebRequest -Uri $DOWNLOAD_CAPSULE_URL -OutFile $CAPSULE_EXEC
            Write-Host "Capsule downloaded to: $CAPSULE_EXEC"
        }
    }
} else {
    if (Get-Command "nvidia-smi.exe" -ErrorAction SilentlyContinue) {
        Write-Host "NVIDIA detected. Downloading Capsule (CUDA version)..."
        $DOWNLOAD_CAPSULE_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/windows-amd64-cuda124.zip"
        Invoke-WebRequest -Uri $DOWNLOAD_CAPSULE_URL -OutFile $CAPSULE_ZIP
        Write-Host "Extracting CUDA Capsule..."
        Expand-Archive -Path $CAPSULE_ZIP -DestinationPath $PROJECT_DIR -Force
        Remove-Item $CAPSULE_ZIP -Force

        if (Test-Path $EXTRACTED_CUDA_EXEC) {
            Rename-Item -Path $EXTRACTED_CUDA_EXEC -NewName "FortyTwoCapsule.exe" -Force
            Write-Host "Renamed CUDA Capsule to: $CAPSULE_EXEC"
        } else {
            Write-Host "ERROR: Expected CUDA executable not found in extracted files!"
            Exit 1
        }
    } else {
        Write-Host "No NVIDIA GPU detected. Downloading CPU Capsule..."
        $DOWNLOAD_CAPSULE_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/FortytwoCapsule-windows-amd64.exe"
        Invoke-WebRequest -Uri $DOWNLOAD_CAPSULE_URL -OutFile $CAPSULE_EXEC
        Write-Host "Capsule downloaded to: $CAPSULE_EXEC"
    }
}

if (Test-Path $PROTOCOL_EXEC) {
    $CURRENT_PROTOCOL_VERSION_OUTPUT = & $PROTOCOL_EXEC --version 2>$null
    if ($CURRENT_PROTOCOL_VERSION_OUTPUT -match $PROTOCOL_VERSION) {
        Write-Host "Node is already up to date ($CURRENT_PROTOCOL_VERSION_OUTPUT). Skipping download."
    } else {
        Write-Host "Downloading updated Node..."
        Invoke-WebRequest -Uri $DOWNLOAD_PROTOCOL_URL -OutFile $PROTOCOL_EXEC
    }
} else {
    Write-Host "Downloading Node..."
    Invoke-WebRequest -Uri $DOWNLOAD_PROTOCOL_URL -OutFile $PROTOCOL_EXEC
}

$LLM_HF_REPO = Read-Host "Enter HuggingFace LLM repository (default: Qwen/Qwen2.5-3B-Instruct-GGUF)"
if (-Not $LLM_HF_REPO) { $LLM_HF_REPO = "Qwen/Qwen2.5-3B-Instruct-GGUF" }

$LLM_HF_MODEL_NAME = Read-Host "Enter HuggingFace LLM model name only with .gguf extension (default: qwen2.5-3b-instruct-q8_0.gguf)"
if (-Not $LLM_HF_MODEL_NAME) { $LLM_HF_MODEL_NAME = "qwen2.5-3b-instruct-q8_0.gguf" }

if (Test-Path $ACCOUNT_PRIVATE_KEY_FILE) {
    $ACCOUNT_PRIVATE_KEY = Get-Content $ACCOUNT_PRIVATE_KEY_FILE
    Write-Host "Using saved account private key."
} else {
    if (-Not (Test-Path $CONVERTOR_EXEC)) {
        Invoke-WebRequest -Uri $DOWNLOAD_CONVERTOR_URL -OutFile $CONVERTOR_EXEC
    }
    while ($true) {
        $ACCOUNT_SEED_PHRASE = Read-Host "Enter account seed phrase"
        try {
            $ACCOUNT_PRIVATE_KEY = & $CONVERTOR_EXEC $ACCOUNT_SEED_PHRASE
            if ($LASTEXITCODE -ne 0) {
                throw "Converter execution failed!"
            } else {
                $ACCOUNT_PRIVATE_KEY | Set-Content -Path $ACCOUNT_PRIVATE_KEY_FILE
                Write-Host "Private key saved."
                break
            }
        } catch {
            Write-Host "Error: Please check the seed phrase and try again."
            continue
        }
    }
}

$CAPSULE_PROC = Start-Process -FilePath $CAPSULE_EXEC -ArgumentList "--llm-hf-repo $LLM_HF_REPO --llm-hf-model-name $LLM_HF_MODEL_NAME" -PassThru -RedirectStandardOutput $CAPSULE_LOGS -RedirectStandardError $CAPSULE_ERR_LOGS -NoNewWindow
Write-Host "Be patient during the first launch of the capsule; it will take some time to download the model artifacts, depending on your internet connection."
Write-Host "Waiting for Capsule download models weight and started..."

while ($true) {
    try {
        $STATUS_CODE = (Invoke-WebRequest -Uri $CAPSULE_READY_URL -UseBasicParsing -ErrorAction Stop).StatusCode
        if ($STATUS_CODE -eq 200) {
            Write-Host "Capsule is ready!"
            break
        }
    } catch {
        # Just Ignore Error
    }
    Write-Host "Capsule is not ready. Retrying in 5 seconds..."
    Start-Sleep -Seconds 5
}

$PROTOCOL_PROC = Start-Process -FilePath $PROTOCOL_EXEC -ArgumentList "--account-private-key $ACCOUNT_PRIVATE_KEY --db-folder $PROTOCOL_DB_DIR" -PassThru -RedirectStandardOutput $PROTOCOL_LOGS -RedirectStandardError $PROTOCOL_ERR_LOGS -NoNewWindow

while ($true) {
    if ($CAPSULE_PROC.HasExited) {
        Write-Host "Capsule has stopped. Exiting..."
        Exit 1
    }
    if ($PROTOCOL_PROC.HasExited) {
        Write-Host "Node has stopped. Exiting..."
        Exit 1
    }
    Write-Host "FortytwoNode is running..."
    Start-Sleep -Seconds 5
}
