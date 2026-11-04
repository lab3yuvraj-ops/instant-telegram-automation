<#
Creates the local, ignored configuration files after cloning the repository.
It never overwrites an existing .env or .env.telegram file.
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path

foreach ($pair in @(
    @{ Template = '.env.example'; Target = '.env' },
    @{ Template = '.env.telegram.example'; Target = '.env.telegram' }
)) {
    $template = Join-Path $root $pair.Template
    $target = Join-Path $root $pair.Target
    if (Test-Path -LiteralPath $target) {
        Write-Host "$($pair.Target) already exists; leaving it unchanged."
        continue
    }
    Copy-Item -LiteralPath $template -Destination $target
    Write-Host "Created $($pair.Target)."
}

Write-Host ''
Write-Host 'Add your API keys to .env and your Telegram bot token to .env.telegram.'
Write-Host 'These files are ignored by Git and must not be committed.'
