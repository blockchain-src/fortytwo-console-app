function Animate-Text {
    param (
        [string]$text
    )

    foreach ($char in $text.ToCharArray()) {
        Write-Host -NoNewline $char
        Start-Sleep -Milliseconds 1
    }
    Write-Host ""
}
function Animate-Text-x2 {
    param (
        [string]$text
    )

    foreach ($char in $text.ToCharArray()) {
        Write-Host -NoNewline $char
        Start-Sleep -Milliseconds 0.4
    }
    Write-Host ""
}

# Custom symbols
$SYMBOL_CROWN = [char]0x2654
$SYMBOL_NEWLINE = [char]0x2514
$SYMBOL_SEPARATOR_DOT = [char]0x2022
$SYMBOL_MODEL_SELECTED = [char]0x1362
$SYMBOL_MODEL_CUSTOM = [char]0x2736
$SYMBOL_MODEL_AUTOSELECT = [char]0x1360
$SYMBOL_MODEL_LASTUSED = [char]0x25C1 
$SYMBOL_COMP_SETUPSCRIPT = [char]0x144E
$SYMBOL_COMP_CAPSULE = [char]0x1403
$SYMBOL_COMP_NODE = [char]0x46A
$SYMBOL_COMP_UTILS = [char]0x15D1
$SYMBOL_STATE_SUCCESS = [char]0x2713
$SYMBOL_STATE_FAILURE = [char]0xD7
$SYMBOL_STATE_WARNING = [char]0x26A0
$SYMBOL_STATE_SADFACE = [char[]]@(0x2D9, 0x1422, 0x2D9)
$SYMBOL_STATE_HAPPYFACE = [char[]]@(0x2D9, 0x1D55, 0x2D9)
$SYMBOL_HEADER_IN = [char[]]@(0x2592, 0x2593, 0x2591)
$SYMBOL_HEADER_OUT = [char[]]@(0x2591, 0x2593, 0x2592)
$BANNER = [char[]]@(0xA, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA)
$BANNER_FULLNAME = [char[]]@(0xA, 0xA, 0x2591, 0x2593, 0x2588, 0x2593, 0x20, 0x20, 0x2591, 0x2593, 0x2588, 0x2593, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0xA, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2591, 0x2588, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2593, 0x2591, 0x2588, 0x2588, 0x2588, 0x2593, 0x2592, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0x2588, 0x2588, 0x2588, 0x2593, 0x2591, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x2591, 0x2588, 0x2588, 0x2593, 0x2591, 0xA, 0x2592, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x2591, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x2588, 0x2593, 0x20, 0x2591, 0x2591, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2591, 0x2588, 0x2593, 0x20, 0x2593, 0x2588, 0x2593, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x2593, 0x2588, 0x2593, 0x20, 0x2593, 0x2588, 0x2593, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0xA, 0x2591, 0x2593, 0x2588, 0x2593, 0x20, 0x20, 0x2591, 0x2593, 0x2588, 0x2593, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2591, 0x2588, 0x2592, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2593, 0x2588, 0x2592, 0x2588, 0x2592, 0x2588, 0x2592, 0x2588, 0x2593, 0x2591, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0xA, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2591, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0xA, 0x2592, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x2591, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2593, 0x2592, 0x20, 0x20, 0x2588, 0x2593, 0x2591, 0x20, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2593, 0x2591, 0xA, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2593, 0x2591)

function Auto-Select-Model {
    $AVAILABLE_MEM = $null

    if (Get-Command nvidia-smi -ErrorAction SilentlyContinue) {
        $AVAILABLE_MEM = ((nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits | Select-Object -First 1) -as [double]) / 1024
        Animate-Text "    $SYMBOL_NEWLINE System analysis: $AVAILABLE_MEM GB VRAM detected"
    } else {
        $TotalMemoryKB = [double]((Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize)
        $AVAILABLE_MEM = $TotalMemoryKB / 1024 / 1024
        Animate-Text "    $SYMBOL_NEWLINE System analysis: $AVAILABLE_MEM GB RAM detected"
    }

    $AVAILABLE_MEM_INT = [math]::Round($AVAILABLE_MEM)
    if ($AVAILABLE_MEM_INT -ge 32) {
        Animate-Text "    $SYMBOL_CROWN Recommending: $SYMBOL_MODEL_SELECTED 7 Qwen2.5-Coder for problem solving & logical reasoning"
        $global:LLM_HF_REPO = "Qwen/Qwen2.5-Coder-32B-Instruct-GGUF"
        $global:LLM_HF_MODEL_NAME = "qwen2.5-coder-32b-instruct-q4_k_m-00001-of-00003.gguf"
        $global:NODE_NAME = "Qwen2.5-Coder 32B Instruct Q4_K_M"
    } elseif ($AVAILABLE_MEM_INT -ge 24) {
        Animate-Text "    $SYMBOL_CROWN Recommending: $SYMBOL_MODEL_SELECTED 8 Phi-4 for mathematical intelligence"
        $global:LLM_HF_REPO = "unsloth/phi-4-GGUF"
        $global:LLM_HF_MODEL_NAME = "phi-4-Q4_K_M.gguf"
        $global:NODE_NAME = "Phi-4 Q4_K_M"
    } elseif ($AVAILABLE_MEM_INT -ge 12) {
        Animate-Text "    $SYMBOL_CROWN Recommending: $SYMBOL_MODEL_SELECTED 2 Llama 3.2 for balanced capability"
        $global:LLM_HF_REPO = "bartowski/Llama-3.2-3B-Instruct-GGUF"
        $global:LLM_HF_MODEL_NAME = "Llama-3.2-3B-Instruct-Q4_K_M.gguf"
        $global:NODE_NAME = "Llama 3.2 3B Instruct Q4_K_M"
    } else {
        Animate-Text "    $SYMBOL_CROWN Recommending: $SYMBOL_MODEL_CUSTOM 1 Custom Import Qwen 2.5 optimized for efficiency"
        $global:LLM_HF_REPO = "Qwen/Qwen2.5-1.5B-Instruct-GGUF"
        $global:LLM_HF_MODEL_NAME = "qwen2.5-1.5b-instruct-q4_k_m.gguf"
        $global:NODE_NAME = "Qwen 2.5 1.5B Instruct Q4_K_M"
    }
}

Write-Host ""
Animate-Text-x2 ($BANNER -join '')
Animate-Text "      Welcome to ::|| Fortytwo, Noderunner."
Write-Host ""

$PROJECT_DIR = "FortytwoNode"
$PROJECT_DEBUG_DIR = "$PROJECT_DIR\debug"
$PROJECT_MODEL_CACHE_DIR="$PROJECT_DIR\model_cache"
$CAPSULE_ZIP = "$PROJECT_DIR\capsule_cuda.zip"
$EXTRACTED_CUDA_EXEC = "$PROJECT_DIR\FortytwoCapsule-windows-amd64-cuda124.exe"
$CAPSULE_EXEC = "$PROJECT_DIR\FortytwoCapsule.exe"
$CAPSULE_LOGS = "$PROJECT_DEBUG_DIR\FortytwoCapsule.log"
$CAPSULE_ERR_LOGS = "$PROJECT_DEBUG_DIR\FortytwoCapsule_err.log"
$CAPSULE_READY_URL = "http://localhost:42442/ready"

$PROTOCOL_EXEC = "$PROJECT_DIR\FortytwoProtocol.exe"
$PROTOCOL_DB_DIR = "$PROJECT_DEBUG_DIR\internal_db"

$ACCOUNT_PRIVATE_KEY_FILE = "$PROJECT_DIR\.account_private_key"

$UTILS_EXEC="$PROJECT_DIR\FortytwoUtilsWindows.exe"

Write-Host "Preparing your node environment..."

if (-Not (Test-Path $PROJECT_DEBUG_DIR) -or -Not (Test-Path $PROJECT_MODEL_CACHE_DIR)) {
    New-Item -ItemType Directory -Path $PROJECT_DEBUG_DIR -Force | Out-Null
    New-Item -ItemType Directory -Path $PROJECT_MODEL_CACHE_DIR -Force | Out-Null
    Write-Host ""
    # Animate-Text "Project directory created: $PROJECT_DIR"
} else {
    Write-Host ""
    # Animate-Text "Project directory already exists: $PROJECT_DIR"
}

function Cleanup {
    if ($CAPSULE_PROC) {
        $CAPSULE_PROC.Refresh()
    }
    if ($PROTOCOL_PROC) {
        $PROTOCOL_PROC.Refresh()
    }

    if ($CAPSULE_PROC -and $CAPSULE_PROC.HasExited -eq $false) {
        Animate-Text " $SYMBOL_COMP_CAPSULE Stopping Capsule..."
        Stop-Process -Id $CAPSULE_PROC.Id -Force -ErrorAction SilentlyContinue
    } else {
        Animate-Text " $SYMBOL_COMP_CAPSULE Capsule is not running."
    }

    if ($PROTOCOL_PROC -and $PROTOCOL_PROC.HasExited -eq $false) {
        Animate-Text " $SYMBOL_COMP_NODE Stopping Node..."
        Stop-Process -Id $PROTOCOL_PROC.Id -Force -ErrorAction SilentlyContinue
    } else {
        Animate-Text " $SYMBOL_COMP_NODE Node is not running."
    }
    Write-Host ""
    Animate-Text "Processes stopped"
    Animate-Text "Bye, Noderunner"
    exit 0
}

Animate-Text ($SYMBOL_HEADER_IN -join ''),"Checking for the Latest Components Versions",($SYMBOL_HEADER_OUT -join '')
Write-Host ""
Animate-Text " $SYMBOL_COMP_SETUPSCRIPT Setup script"

# --- Update setup script ---
$UpdateUrl = "https://raw.githubusercontent.com/Fortytwo-Network/fortytwo-console-app/main/windows.ps1"
$ScriptPath = $MyInvocation.MyCommand.Path
$TempFile = [System.IO.Path]::GetTempFileName()

# Download updated script
try {
    Invoke-WebRequest -Uri $UpdateUrl -OutFile $TempFile -ErrorAction Stop
} catch {
    Write-Output "    $SYMBOL_STATE_FAILURE ERROR: Failed to download the update. Check your internet connection and try again."
    exit 1
}

# Compare
if ((Get-FileHash $ScriptPath).Hash -eq (Get-FileHash $TempFile).Hash) {
    Write-Output "    $SYMBOL_STATE_SUCCESS Up to date."
    Remove-Item $TempFile
} else {
    Write-Output "    $SYMBOL_NEWLINE Updating..."
    Copy-Item $ScriptPath "$ScriptPath.bak" -Force
    Copy-Item $TempFile $ScriptPath -Force
    Remove-Item $TempFile

    Write-Output "    $SYMBOL_NEWLINE Restarting script..."
    Write-Host ""
    Start-Sleep -Seconds 3
    # Start the new version and exit current
    Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File `"$ScriptPath`""
    exit
}
# --- End Update setup script ---

trap {
    Animate-Text "`nDetected Ctrl+C. Stopping processes..."
    Cleanup
}

$CAPSULE_VERSION = (Invoke-RestMethod "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/latest").Trim()
Animate-Text " $SYMBOL_COMP_CAPSULE Capsule - version $CAPSULE_VERSION"
if (Test-Path $CAPSULE_EXEC) {
    $CURRENT_CAPSULE_VERSION_OUTPUT = & $CAPSULE_EXEC --version 2>$null
    if ($CURRENT_CAPSULE_VERSION_OUTPUT -match $CAPSULE_VERSION) {
        Animate-Text "    $SYMBOL_STATE_SUCCESS Up to date"
    } else {
        if (Get-Command "nvidia-smi.exe" -ErrorAction SilentlyContinue) {
            Animate-Text "    $SYMBOL_NEWLINE NVIDIA detected. Downloading CUDA Capsule..."
            $DOWNLOAD_CAPSULE_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/windows-amd64-cuda124.zip"
            Invoke-WebRequest -Uri $DOWNLOAD_CAPSULE_URL -OutFile $CAPSULE_ZIP
            Animate-Text "    $SYMBOL_NEWLINE Extracting CUDA Capsule..."
            Remove-Item $CAPSULE_EXEC -Force
            Remove-Item "$PROJECT_DIR\cublas64_12.dll" -Force
            Remove-Item "$PROJECT_DIR\cublasLt64_12.dll" -Force
            Expand-Archive -Path $CAPSULE_ZIP -DestinationPath $PROJECT_DIR -Force
            Remove-Item $CAPSULE_ZIP -Force

            if (Test-Path $EXTRACTED_CUDA_EXEC) {
                Rename-Item -Path $EXTRACTED_CUDA_EXEC -NewName "FortytwoCapsule.exe" -Force
                Animate-Text "    $SYMBOL_NEWLINE Renamed CUDA Capsule to: $CAPSULE_EXEC"
            } else {
                Write-Host "    $SYMBOL_STATE_FAILURE ERROR: Expected CUDA executable not found in extracted files!"
                Exit 1
            }
            Animate-Text "    $SYMBOL_STATE_SUCCESS Successfully updated"
        } else {
            Write-Host "    $SYMBOL_NEWLINE No NVIDIA GPU detected. Downloading CPU Capsule..."
            $DOWNLOAD_CAPSULE_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/FortytwoCapsule-windows-amd64.exe"
            Invoke-WebRequest -Uri $DOWNLOAD_CAPSULE_URL -OutFile $CAPSULE_EXEC
            Animate-Text "    $SYMBOL_STATE_SUCCESS Successfully updated"
        }
    }
} else {
    if (Get-Command "nvidia-smi.exe" -ErrorAction SilentlyContinue) {
        Animate-Text "    $SYMBOL_NEWLINE NVIDIA detected. Downloading CUDA Capsule..."
        $DOWNLOAD_CAPSULE_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/windows-amd64-cuda124.zip"
        Invoke-WebRequest -Uri $DOWNLOAD_CAPSULE_URL -OutFile $CAPSULE_ZIP
        Animate-Text "    $SYMBOL_NEWLINE Extracting CUDA Capsule..."
        Expand-Archive -Path $CAPSULE_ZIP -DestinationPath $PROJECT_DIR -Force
        Remove-Item $CAPSULE_ZIP -Force

        if (Test-Path $EXTRACTED_CUDA_EXEC) {
            Rename-Item -Path $EXTRACTED_CUDA_EXEC -NewName "FortytwoCapsule.exe" -Force
            Write-Host "    $SYMBOL_NEWLINE Renamed CUDA Capsule to: $CAPSULE_EXEC"
        } else {
            Write-Host "    $SYMBOL_STATE_FAILURE ERROR: Expected CUDA executable not found in extracted files!"
            Exit 1
        }
        Animate-Text "    $SYMBOL_STATE_SUCCESS Installed to: $CAPSULE_EXEC"
    } else {
        Animate-Text "    $SYMBOL_NEWLINE No NVIDIA GPU detected. Downloading CPU Capsule..."
        $DOWNLOAD_CAPSULE_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/FortytwoCapsule-windows-amd64.exe"
        Invoke-WebRequest -Uri $DOWNLOAD_CAPSULE_URL -OutFile $CAPSULE_EXEC
        Animate-Text "    $SYMBOL_STATE_SUCCESS Installed to: $CAPSULE_EXEC"
    }
}
$PROTOCOL_VERSION = (Invoke-RestMethod "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/latest").Trim()
Animate-Text " $SYMBOL_COMP_NODE Protocol Node - version $PROTOCOL_VERSION"
$DOWNLOAD_PROTOCOL_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/v$PROTOCOL_VERSION/FortytwoProtocolNode-windows-amd64.exe"
if (Test-Path $PROTOCOL_EXEC) {
    $CURRENT_PROTOCOL_VERSION_OUTPUT = & $PROTOCOL_EXEC --version 2>$null
    if ($CURRENT_PROTOCOL_VERSION_OUTPUT -match $PROTOCOL_VERSION) {
        Animate-Text "    $SYMBOL_STATE_SUCCESS Up to date"
    } else {
        Animate-Text "    $SYMBOL_NEWLINE Updating..."
        Invoke-WebRequest -Uri $DOWNLOAD_PROTOCOL_URL -OutFile $PROTOCOL_EXEC
        Animate-Text "    $SYMBOL_STATE_SUCCESS Successfully updated"
    }
} else {
    Animate-Text "    $SYMBOL_NEWLINE Downloading..."
    Invoke-WebRequest -Uri $DOWNLOAD_PROTOCOL_URL -OutFile $PROTOCOL_EXEC
    Animate-Text "    $SYMBOL_STATE_SUCCESS Installed to: $PROTOCOL_EXEC"
}
$UTILS_VERSION = (Invoke-RestMethod "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/utilities/latest").Trim()
Animate-Text " $SYMBOL_COMP_UTILS Utils - version $UTILS_VERSION"
$DOWNLOAD_UTILS_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/utilities/v$UTILS_VERSION/FortytwoUtilsWindows.exe"
if (Test-Path $UTILS_EXEC) {
    $CURRENT_UTILS_VERSION_OUTPUT = & $UTILS_EXEC --version 2>$null
    if ($CURRENT_UTILS_VERSION_OUTPUT -match $UTILS_VERSION) {
        Animate-Text "    $SYMBOL_STATE_SUCCESS Up to date"
    } else {
        Animate-Text "    $SYMBOL_NEWLINE Updating..."
        Invoke-WebRequest -Uri $DOWNLOAD_UTILS_URL -OutFile $UTILS_EXEC
        Animate-Text "    $SYMBOL_STATE_SUCCESS Successfully updated"
    }
} else {
    Animate-Text "    $SYMBOL_NEWLINE Downloading..."
    Invoke-WebRequest -Uri $DOWNLOAD_UTILS_URL -OutFile $UTILS_EXEC
    Animate-Text "     $SYMBOL_STATE_SUCCESS Installed to: $UTILS_EXEC"
}

Write-Host ""
Animate-Text ($SYMBOL_HEADER_IN -join ''),"Identity Initialization",($SYMBOL_HEADER_OUT -join '')

if (Test-Path $ACCOUNT_PRIVATE_KEY_FILE) {
    $ACCOUNT_PRIVATE_KEY = Get-Content $ACCOUNT_PRIVATE_KEY_FILE
    Write-Host ""
    Animate-Text "    $SYMBOL_NEWLINE Private key found at $PROJECT_DIR /.account_private_key."
    Animate-Text "    $SYMBOL_NEWLINE Initiating the node using an existing identity."
    Animate-Text "    $SYMBOL_STATE_WARNING Keep the private key safe. Do not share with anyone."
    Write-Host "    $SYMBOL_STATE_WARNING Recover your node or access your wallet with it."
    Write-Host "    $SYMBOL_STATE_WARNING We will not be able to recover it if it is lost."
} else {
    Write-Host ""
    Write-Host "|==================== NETWORK IDENTITY ===================|"
    Write-Host "|                                                         |"
    Write-Host "|  Each node requires a secure blockchain identity.       |"
    Write-Host "|  Select one of the following options:                   |"
    Write-Host "|                                                         |"
    Write-Host "|  1. Create a new identity with an invite code.          |"
    Write-Host "|     Recommended for new nodes.                          |"
    Write-Host "|                                                         |"
    Write-Host "|  2. Recover an existing identity with recovery phrase.  |"
    Write-Host "|     Use this if you're restoring a previous node.       |"
    Write-Host "|                                                         |"
    Write-Host "|=========================================================|"
    Write-Host ""

    $IDENTITY_OPTION = Read-Host "Select option [1-2]"
    Write-Host ""
    if (-not $IDENTITY_OPTION) { $IDENTITY_OPTION = "1" }

    if ($IDENTITY_OPTION -eq "2") {
        Animate-Text "[2] Recovering existing identity"
        Write-Host ""
        while ($true) {
            $ACCOUNT_SEED_PHRASE = Read-Host "Enter your account recovery phrase (12, 18, or 24 words), then press Enter"
            Write-Host ""
            try {
                $ACCOUNT_PRIVATE_KEY = & $UTILS_EXEC --phrase $ACCOUNT_SEED_PHRASE
                if ($LASTEXITCODE -ne 0) {
                    throw ($SYMBOL_STATE_SADFACE -join ''),"Error: Please check the recovery phrase and try again."
                } else {
                    $ACCOUNT_PRIVATE_KEY | Set-Content -Path $ACCOUNT_PRIVATE_KEY_FILE
                    Animate-Text " ",($SYMBOL_STATE_HAPPYFACE -join ''),"The identity successfully restored!"
                    Write-Host ""
                    Animate-Text "    $SYMBOL_NEWLINE Private key saved to $PROJECT_DIR /.account_private_key."
                    Animate-Text "    $SYMBOL_STATE_WARNING Keep the key secure. Do not share with anybody."
                    Write-Host "    $SYMBOL_STATE_WARNING Restore your node or access your wallet with it."
                    Write-Host "    $SYMBOL_STATE_WARNING We will not be able to recover it would it be lost."
                    break
                }
            } catch {
                Write-Host " ",($SYMBOL_STATE_SADFACE -join ''),"Error: Please check the recovery phrase and try again."
                continue
            }
        }
    } else {
        Animate-Text "[1] Creating a new identity with an invite code"
        Write-Host ""
        while ($true) {
            $INVITE_CODE = Read-Host "Enter your invite code"
            Write-Host ""
            if (-not $INVITE_CODE -or $INVITE_CODE.Length -lt 12) {
                Write-Host " ",($SYMBOL_STATE_SADFACE -join ''),"Invalid invite code. Check the code and try again."
                Write-Host ""
                continue
            } else {
                break
            }
        }
        Animate-Text "    $SYMBOL_NEWLINE Validating your identity..."
        $WALLET_UTILS_EXEC_OUTPUT = & $UTILS_EXEC --create-wallet $ACCOUNT_PRIVATE_KEY_FILE --drop-code $INVITE_CODE
        if ($LASTEXITCODE -ne 0) {
            Write-Host ($WALLET_UTILS_EXEC_OUTPUT | Select-Object -Last 1)
            Write-Host ""
            Write-Host " ",($SYMBOL_STATE_SADFACE -join ''),"This code has already been activated. Please check your code and try again. You entered: $INVITE_CODE"
            Write-Host ""
            if (Test-Path $ACCOUNT_PRIVATE_KEY_FILE) {
                Remove-Item $ACCOUNT_PRIVATE_KEY_FILE -Force
            }
            exit 1
        }
        Animate-Text "    $SYMBOL_NEWLINE Write down your new node identity:"
        $ACCOUNT_PRIVATE_KEY = Get-Content $ACCOUNT_PRIVATE_KEY_FILE
        Write-Host $WALLET_UTILS_EXEC_OUTPUT
        Write-Host ""
        Animate-Text "    $SYMBOL_STATE_SUCCESS Identity configured and securely stored!"
        Write-Host ""
        Write-Host "|================= ATTENTION, NODERUNNER =================|"
        Write-Host "|                                                         |"
        Write-Host "|  1. Write down your secret recovery phrase              |"
        Write-Host "|  2. Keep your private key safe                          |"
        Write-Host "|     $SYMBOL_NEWLINE Get .account_private_key key from ./FortytwoNode/ |"
        Write-Host "|     $SYMBOL_NEWLINE Store it outside the App directory                |"
        Write-Host "|                                                         |"
        Write-Host "|  $SYMBOL_STATE_WARNING Keep the recovery phrase and private key safe.       |"
        Write-Host "|  $SYMBOL_STATE_WARNING Do not share them with anyone.                       |"
        Write-Host "|  $SYMBOL_STATE_WARNING Use them to restore your node or access your wallet. |"
        Write-Host "|  $SYMBOL_STATE_WARNING We won't be able to recover them if they are lost.   |"
        Write-Host "|                                                         |"
        Write-Host "|=========================================================|"
        Write-Host ""
        while ($true) {
            $user_input = Read-Host "To continue, please type 'Done'"
            if ($user_input -eq "Done") {
                break
            }
            Write-Host "Incorrect input. Please type 'Done' to continue."
        }
    }
}

Write-Host ""
Animate-Text ($SYMBOL_HEADER_IN -join ''),"The Unique Strength of Your Node",($SYMBOL_HEADER_OUT -join '')
Write-Host ""
Animate-Text "Each AI node has unique strengths."
Animate-Text "Choose how your node will contribute to the collective intelligence:"
Write-Host ""
Auto-Select-Model
# Write-Host "    Already downloaded models: $SYMBOL_MODEL_SELECTED 4, $SYMBOL_MODEL_SELECTED 5"
Write-Host ""
Write-Host "|===========================================================================|"
Animate-Text-x2 "| 0 $SYMBOL_MODEL_AUTOSELECT AUTO-SELECT - Optimal configuration                                   |"
Write-Host "|     Let the system determine the best model for your hardware.            |"
Write-Host "|     Balanced for performance and capabilities.                            |"
Write-Host "|===========================================================================|"
Animate-Text-x2 "| 1 $SYMBOL_MODEL_CUSTOM IMPORT CUSTOM - Advanced configuration                                |"
# Write-Host "|===========================================================================|"
# Write-Host "| 2 $SYMBOL_MODEL_LASTUSED LAST USED - Run the model that was run the last time                  |"
Write-Host "|===========================================================================|"
Animate-Text-x2 "| 2 $SYMBOL_MODEL_SELECTED GENERAL KNOWLEDGE                   Llama 3.2 3B Instruct $SYMBOL_SEPARATOR_DOT 2.2GB RAM |"
Write-Host "|     Versatile multi-domain intelligence core with balanced capabilities.  |"
Write-Host "|===========================================================================|"
Animate-Text-x2 "| 3 $SYMBOL_MODEL_SELECTED ADVANCED REASONING                   INTELLECT-1 Instruct $SYMBOL_SEPARATOR_DOT 6.5GB RAM |"
Write-Host "|     High-precision logical analysis matrix optimized for problem-solving. |"
Write-Host "|===========================================================================|"
Animate-Text-x2 "| 4 $SYMBOL_MODEL_SELECTED PROGRAMMING & TECHNICAL         Qwen2.5 Coder 7B Instruct $SYMBOL_SEPARATOR_DOT 4.8GB RAM |"
Write-Host "|     Specialized system for code synthesis and framework construction.     |"
Write-Host "|===========================================================================|"
Animate-Text-x2 "| 5 $SYMBOL_MODEL_SELECTED ACADEMIC KNOWLEDGE             Ministral 8B Instruct 2410 $SYMBOL_SEPARATOR_DOT 5.2GB RAM |"
Write-Host "|     Advanced data integration and research synthesis protocol.            |"
Write-Host "|===========================================================================|"
Animate-Text-x2 "| 6 $SYMBOL_MODEL_SELECTED LANGUAGE & WRITING                    Qwen2.5 7B Instruct $SYMBOL_SEPARATOR_DOT 4.8GB RAM |"
Write-Host "|     Enhanced natural language and communication protocol interface.       |"
Write-Host "|===========================================================================|"
Animate-Text-x2 "| 7 $SYMBOL_MODEL_SELECTED LOGICAL REASONING               Qwen2.5-Coder 32B Instruct $SYMBOL_SEPARATOR_DOT 21GB RAM |"
Write-Host "|     High-level reasoning, mathematical problem-solving                    |"
Write-Host "|     and competitive coding.                                               |"
Write-Host "|===========================================================================|"
Animate-Text-x2 "| 8 $SYMBOL_MODEL_SELECTED MATHEMATICAL INTELLIGENCE                       Phi-4 14B $SYMBOL_SEPARATOR_DOT 9.1GB RAM |"
Write-Host "|     Optimized for symbolic reasoning, step-by-step math solutions         |"
Write-Host "|     and logic-based inference.                                            |"
Write-Host "|===========================================================================|"
Animate-Text-x2 "| 9 $SYMBOL_MODEL_SELECTED MULTILINGUAL UNDERSTANDING                     Gemma-3 4B $SYMBOL_SEPARATOR_DOT 3.3GB RAM |"
Write-Host "|     Balanced intelligence with high-quality cross-lingual comprehension,  |"
Write-Host "|     translation and multilingual reasoning.                               |"
Write-Host "|===========================================================================|"
Animate-Text-x2 "| 10 $SYMBOL_MODEL_SELECTED COMPETITIVE PROGRAMMING & ALGORITHMS     OlympicCoder 7B $SYMBOL_SEPARATOR_DOT 4.8GB RAM |"
Write-Host "|     Optimized for competitive coding, excelling in algorithmic challenges |"
Write-Host "|     and CodeForces-style programming tasks.                               |"
Write-Host "|===========================================================================|"
Write-Host ""
$NODE_CLASS = Read-Host "Select your node's specialization [0-10] (0 for auto-select)"

switch ($NODE_CLASS) {
    "0" {
        Write-Host " $SYMBOL_MODEL_AUTOSELECT Analyzing system for optimal configuration:"
        Auto-Select-Model
    }
    "1" {
        Write-Host "`n================== CUSTOM MODEL IMPORT ===================="
        Write-Host "     Intended for users familiar with language models.`n"

        $LLM_HF_REPO = Read-Host "Enter HuggingFace repository (e.g., Qwen/Qwen2.5-3B-Instruct-GGUF)"
        $LLM_HF_MODEL_NAME = Read-Host "Enter model filename (e.g., qwen2.5-3b-instruct-q4_k_m.gguf)"
        $NODE_NAME = " $SYMBOL_MODEL_CUSTOM CUSTOM IMPORT: HuggingFace $($LLM_HF_REPO -split '/' | Select-Object -Last 1))"
    }
    "2" {
        $LLM_HF_REPO = "bartowski/Llama-3.2-3B-Instruct-GGUF"
        $LLM_HF_MODEL_NAME = "Llama-3.2-3B-Instruct-Q4_K_M.gguf"
        $NODE_NAME = " $SYMBOL_MODEL_SELECTED GENERAL KNOWLEDGE: Llama 3.2 3B Instruct Q4_K_M"
    }
    "3" {
        $LLM_HF_REPO = "bartowski/INTELLECT-1-Instruct-GGUF"
        $LLM_HF_MODEL_NAME = "INTELLECT-1-Instruct-Q4_K_M.gguf"
        $NODE_NAME = " $SYMBOL_MODEL_SELECTED ADVANCED REASONING: INTELLECT-1 Instruct Q4_K_M"
    }
    "4" {
        $LLM_HF_REPO = "Qwen/Qwen2.5-Coder-7B-Instruct-GGUF"
        $LLM_HF_MODEL_NAME = "qwen2.5-coder-7b-instruct-q4_k_m-00001-of-00002.gguf"
        $NODE_NAME = " $SYMBOL_MODEL_SELECTED PROGRAMMING & TECHNICAL: Qwen2.5 Coder 7B Instruct Q4_K_M"
    }
    "5" {
        $LLM_HF_REPO = "bartowski/Ministral-8B-Instruct-2410-GGUF"
        $LLM_HF_MODEL_NAME = "Ministral-8B-Instruct-2410-Q4_K_M.gguf"
        $NODE_NAME = " $SYMBOL_MODEL_SELECTED ACADEMIC KNOWLEDGE: Ministral 8B Instruct 2410 Q4_K_M"
    }
    "6" {
        $LLM_HF_REPO = "Qwen/Qwen2.5-7B-Instruct-GGUF"
        $LLM_HF_MODEL_NAME = "qwen2.5-7b-instruct-q4_k_m-00001-of-00002.gguf"
        $NODE_NAME = " $SYMBOL_MODEL_SELECTED LANGUAGE & WRITING: Qwen2.5 7B Instruct Q4_K_M"
    }
    "7" {
        $LLM_HF_REPO = "Qwen/Qwen2.5-Coder-32B-Instruct-GGUF"
        $LLM_HF_MODEL_NAME = "qwen2.5-coder-32b-instruct-q4_k_m-00001-of-00003.gguf"
        $NODE_NAME = " $SYMBOL_MODEL_SELECTED LOGICAL REASONING: Qwen2.5-Coder 32B Instruct Q4_K_M"
    }
    "8" {
        $LLM_HF_REPO = "unsloth/phi-4-GGUF"
        $LLM_HF_MODEL_NAME = "phi-4-Q4_K_M.gguf"
        $NODE_NAME = " $SYMBOL_MODEL_SELECTED MATHEMATICAL INTELLIGENCE: Phi-4 14B Q4_K_M"
    }
    "9" {
        $LLM_HF_REPO = "unsloth/gemma-3-12b-it-GGUF"
        $LLM_HF_MODEL_NAME = "gemma-3-12b-it-Q4_K_M.gguf"
        $NODE_NAME = " $SYMBOL_MODEL_SELECTED MULTILINGUAL UNDERSTANDING: Gemma-3 4B Q4_K_M"
    }
    "10" {
        $LLM_HF_REPO = "bartowski/open-r1_OlympicCoder-7B-GGUF"
        $LLM_HF_MODEL_NAME = "open-r1_OlympicCoder-7B-Q4_K_M.gguf"
        $NODE_NAME = " $SYMBOL_MODEL_SELECTED COMPETITIVE PROGRAMMING & ALGORITHMS: OlympicCoder 7B Q4_K_M"
    }

    Default {
        Write-Host "No selection made. Continuing with [0] $SYMBOL_MODEL_AUTOSELECT AUTO-SELECT..."
        Auto-Select-Model
    }
}
Write-Host ""
Write-Host "You chose:"
Animate-Text "${NODE_NAME}"
Write-Host ""
Animate-Text "    $SYMBOL_NEWLINE Downloading the model and preparing the environment may take several minutes..."
& $UTILS_EXEC --hf-repo $LLM_HF_REPO --hf-model-name $LLM_HF_MODEL_NAME --model-cache $PROJECT_MODEL_CACHE_DIR
Write-Host ""
Animate-Text "Setup completed. Ready to launch."
# clear
Animate-Text-x2 ($BANNER_FULLNAME -join '')
Write-Host ""

function Node-Startup {
Animate-Text " $SYMBOL_COMP_CAPSULE Starting Capsule..."

    $CAPSULE_PROC = Start-Process -FilePath $CAPSULE_EXEC -ArgumentList "--llm-hf-repo $LLM_HF_REPO --llm-hf-model-name $LLM_HF_MODEL_NAME --model-cache $PROJECT_MODEL_CACHE_DIR" -PassThru -RedirectStandardOutput $CAPSULE_LOGS -RedirectStandardError $CAPSULE_ERR_LOGS -NoNewWindow
    Animate-Text "Be patient, it may take some time."
    while ($true) {
        if ($CAPSULE_PROC.HasExited) {
            Write-Host " $SYMBOL_COMP_CAPSULE Capsule process exited (exit code: $($CAPSULE_PROC.ExitCode))" -ForegroundColor Red
            try {
                Get-Content $CAPSULE_LOGS -Tail 1
            } catch {
                # pass
            }
            try {
                Get-Content $CAPSULE_ERR_LOGS -Tail 1
            } catch {
            # pass
            }
            exit 1
        }
        try {
            $STATUS_CODE = (Invoke-WebRequest -Uri $CAPSULE_READY_URL -UseBasicParsing -ErrorAction Stop).StatusCode
            if ($STATUS_CODE -eq 200) {
                Animate-Text "Capsule is ready."
                break
            }
        } catch {
            # Just Ignore Error
        }

        Start-Sleep -Seconds 5
    }
    Animate-Text " $SYMBOL_COMP_NODE Starting Protocol..."
    Write-Host "" 
    Animate-Text "Joining ::||"
    Write-Host "" 
    $PROTOCOL_PROC = Start-Process -FilePath $PROTOCOL_EXEC -ArgumentList "--account-private-key $ACCOUNT_PRIVATE_KEY --db-folder $PROTOCOL_DB_DIR" -PassThru -NoNewWindow
}

Node-Startup
while ($true) {
    $IsAlive = $true
    $CAPSULE_PROC.Refresh()
    $PROTOCOL_PROC.Refresh()

    # Check if Capsule process is running
    if (-not (Get-Process -Id $CAPSULE_PROC.Id -ErrorAction SilentlyContinue)) {
        Write-Host ""
        Write-Output " $SYMBOL_COMP_CAPSULE Capsule has stopped. Restarting..."
        $IsAlive = $false
    }

    # Check if Protocol process is running
    if (-not (Get-Process -Id $PROTOCOL_PROC.Id -ErrorAction SilentlyContinue)) {
        Write-Host ""
        Write-Output " $SYMBOL_COMP_NODE Node has stopped. Restarting..."
        $IsAlive = $false
    }

    # Restart logic
    if (-not $IsAlive) {
        Write-Host ""
        Write-Output " $SYMBOL_STATE_WARNING Capsule or Protocol process has stopped. Restarting..."

        # Kill processes if they exist
        if ($CAPSULE_PROC -and $CAPSULE_PROC.HasExited -eq $false) {
            Write-Output " $SYMBOL_COMP_CAPSULE Stopping Capsule before restart..."
            Stop-Process -Id $CAPSULE_PROC.Id -Force -ErrorAction SilentlyContinue
        }
    
        if ($PROTOCOL_PROC -and $PROTOCOL_PROC.HasExited -eq $false) {
            Write-Output " $SYMBOL_COMP_NODE Stopping Node before restart..."
            Stop-Process -Id $PROTOCOL_PROC.Id -Force -ErrorAction SilentlyContinue
        }
    
        # Call startup function (you need to define this)
        Node-Startup
    }

    Start-Sleep -Seconds 5
}
