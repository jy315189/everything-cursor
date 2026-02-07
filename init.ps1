# Everything Cursor — Project Initializer
# 
# Usage: Run this script in your project root directory to set up
# Cursor agents and commands. Rules and skills are already global.
#
# PowerShell:
#   & "D:\projectse\everything-cursor\init.ps1"
#
# Or copy this script to your PATH and run from any project:
#   cursor-init

param(
    [string]$TargetDir = (Get-Location).Path,
    [switch]$Force
)

$SourceDir = $PSScriptRoot

Write-Host ""
Write-Host "Everything Cursor — Project Initializer" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Source:  $SourceDir\.cursor" -ForegroundColor Gray
Write-Host "Target:  $TargetDir\.cursor" -ForegroundColor Gray
Write-Host ""

# Check source exists
if (-not (Test-Path "$SourceDir\.cursor\agents")) {
    Write-Host "ERROR: Source directory not found. Run from everything-cursor repo." -ForegroundColor Red
    exit 1
}

# Create .cursor directory if it doesn't exist
if (-not (Test-Path "$TargetDir\.cursor")) {
    New-Item -ItemType Directory -Path "$TargetDir\.cursor" -Force | Out-Null
    Write-Host "[Created] .cursor/" -ForegroundColor Green
}

# Copy agents (required — not supported globally)
if ((Test-Path "$TargetDir\.cursor\agents") -and -not $Force) {
    Write-Host "[Skipped] agents/ already exists (use -Force to overwrite)" -ForegroundColor Yellow
} else {
    Copy-Item -Path "$SourceDir\.cursor\agents" -Destination "$TargetDir\.cursor\agents" -Recurse -Force
    $agentCount = (Get-ChildItem "$TargetDir\.cursor\agents\*.md").Count
    Write-Host "[Copied]  agents/ ($agentCount agents including orchestrator)" -ForegroundColor Green
}

# Copy commands (required — not supported globally)
if ((Test-Path "$TargetDir\.cursor\commands") -and -not $Force) {
    Write-Host "[Skipped] commands/ already exists (use -Force to overwrite)" -ForegroundColor Yellow
} else {
    Copy-Item -Path "$SourceDir\.cursor\commands" -Destination "$TargetDir\.cursor\commands" -Recurse -Force
    $cmdCount = (Get-ChildItem "$TargetDir\.cursor\commands\*.md").Count
    Write-Host "[Copied]  commands/ ($cmdCount commands)" -ForegroundColor Green
}

# Copy hooks (optional)
if ((Test-Path "$TargetDir\.cursor\hooks") -and -not $Force) {
    Write-Host "[Skipped] hooks/ already exists (use -Force to overwrite)" -ForegroundColor Yellow
} else {
    Copy-Item -Path "$SourceDir\.cursor\hooks" -Destination "$TargetDir\.cursor\hooks" -Recurse -Force
    Write-Host "[Copied]  hooks/" -ForegroundColor Green
}

# Copy MCP config (optional — only if not exists)
if (-not (Test-Path "$TargetDir\.cursor\mcp.json")) {
    Copy-Item -Path "$SourceDir\.cursor\mcp.json" -Destination "$TargetDir\.cursor\mcp.json" -Force
    Write-Host "[Copied]  mcp.json" -ForegroundColor Green
} else {
    Write-Host "[Skipped] mcp.json already exists" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Done! Your project now has:" -ForegroundColor Green
Write-Host "  - Agents (project-level, including orchestrator)" -ForegroundColor White
Write-Host "  - Commands (/tdd, /plan, /code-review, etc.)" -ForegroundColor White
Write-Host "  - Hooks (quality check definitions)" -ForegroundColor White
Write-Host ""
Write-Host "Rules and Skills are already active globally." -ForegroundColor Gray
Write-Host "Use @orchestrator for complex tasks, or just talk naturally." -ForegroundColor Gray
Write-Host ""
