$ErrorActionPreference = "Stop"

$pluginName = "VoiceActivityAnywhere"
$source = $PSScriptRoot
$target = Join-Path $env:USERPROFILE "Vencord"

function Need($cmd, $hint) {
    if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
        Write-Host "missing $cmd. $hint" -ForegroundColor Red
        exit 1
    }
}

function Step($msg) {
    Write-Host ""
    Write-Host "== $msg" -ForegroundColor Cyan
}

function Run($label) {
    if ($LASTEXITCODE -ne 0) {
        Write-Host "$label failed" -ForegroundColor Red
        exit 1
    }
}

if (-not (Test-Path (Join-Path $source "index.ts"))) {
    Write-Host "index.ts not found next to this script" -ForegroundColor Red
    exit 1
}

Step "checking requirements"
Need git "install it from https://git-scm.com"
Need node "install it from https://nodejs.org"
if (-not (Get-Command pnpm -ErrorAction SilentlyContinue)) {
    Write-Host "installing pnpm"
    npm install -g pnpm
    Run "pnpm install"
}

Step "getting vencord source"
if (Test-Path (Join-Path $target ".git")) {
    Write-Host "found existing clone at $target, updating"
    git -C $target pull
    Run "git pull"
} else {
    git clone https://github.com/Vendicated/Vencord.git $target
    Run "git clone"
}

Step "adding the plugin"
$dest = Join-Path $target "src\userplugins\$pluginName"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item (Join-Path $source "index.ts") $dest -Force

Push-Location $target
try {
    Step "installing dependencies"
    pnpm install --frozen-lockfile
    Run "pnpm install"

    Step "building"
    pnpm build
    Run "pnpm build"

    Step "injecting into discord"
    Write-Host "close discord first. pick your discord install in the installer that opens."
    pnpm inject
    Run "pnpm inject"
} finally {
    Pop-Location
}

Write-Host ""
Write-Host "done. restart discord, then enable $pluginName in settings > vencord > plugins." -ForegroundColor Green
