#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Initialize a new project from the agentic framework template.

.DESCRIPTION
    This script creates a new project in the projects/ directory using the standard
    template. It prompts for project details and replaces all template placeholders
    with actual values.

.PARAMETER ProjectName
    The human-readable name of the project (e.g., "My Awesome App")

.PARAMETER ProjectFolder
    The folder name for the project (e.g., "my-awesome-app"). If not provided,
    will be derived from ProjectName.

.PARAMETER Interactive
    Run in interactive mode. Default is $false for scripted usage; pass -Interactive:$true to enable prompts.

.EXAMPLE
    .\scripts\new-project.ps1
    # Runs in interactive mode, prompting for all values

.EXAMPLE
    .\scripts\new-project.ps1 -ProjectName "Customer Portal" -ProjectFolder "customer-portal"
    # Creates a project with specified name and folder
#>

param(
    [Parameter(Mandatory=$false)]
    [string]$ProjectName,

    [Parameter(Mandatory=$false)]
    [string]$ProjectFolder,

    [Parameter(Mandatory=$false)]
    [bool]$Interactive = $false
)

# ============================================================================
# Helper Functions
# ============================================================================

function Write-Header {
    param([string]$Text)
    Write-Host "`n===========================================================" -ForegroundColor Cyan
    Write-Host " $Text" -ForegroundColor Cyan
    Write-Host "===========================================================`n" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Text)
    Write-Host "✓ $Text" -ForegroundColor Green
}

function Write-Info {
    param([string]$Text)
    Write-Host "ℹ $Text" -ForegroundColor Blue
}

function Write-Warning {
    param([string]$Text)
    Write-Host "⚠ $Text" -ForegroundColor Yellow
}

function Get-SafeFolderName {
    param([string]$Name)
    return $Name.ToLower() -replace '[^a-z0-9-]', '-' -replace '-+', '-' -replace '^-|-$', ''
}

function Get-UserInput {
    param(
        [string]$Prompt,
        [string]$Default = ""
    )
    
    if ($Default) {
        $input = Read-Host "$Prompt [$Default]"
        if ([string]::IsNullOrWhiteSpace($input)) {
            return $Default
        }
        return $input
    } else {
        $input = Read-Host $Prompt
        while ([string]::IsNullOrWhiteSpace($input)) {
            Write-Warning "This field is required."
            $input = Read-Host $Prompt
        }
        return $input
    }
}

function Replace-Placeholders {
    param(
        [string]$FilePath,
        [hashtable]$Replacements
    )
    
    $content = Get-Content -Path $FilePath -Raw -Encoding UTF8
    
    foreach ($key in $Replacements.Keys) {
        $content = $content -replace [regex]::Escape("{{$key}}"), $Replacements[$key]
    }
    
    Set-Content -Path $FilePath -Value $content -Encoding UTF8 -NoNewline
}

# ============================================================================
# Main Script
# ============================================================================

Write-Header "Agentic Framework - New Project Initializer"

# Determine script directory and workspace root
$scriptDir = Split-Path -Parent $PSCommandPath
$workspaceRoot = Split-Path -Parent $scriptDir
$templateDir = Join-Path $workspaceRoot "templates\project-template"
$projectsDir = Join-Path $workspaceRoot "projects"

# Verify template exists
if (-not (Test-Path $templateDir)) {
    Write-Host "❌ Error: Template directory not found at $templateDir" -ForegroundColor Red
    exit 1
}

# Ensure projects directory exists
if (-not (Test-Path $projectsDir)) {
    New-Item -ItemType Directory -Path $projectsDir -Force | Out-Null
    Write-Success "Created projects directory"
}

# ============================================================================
# Gather Project Information
# ============================================================================

if ([string]::IsNullOrWhiteSpace($ProjectName)) {
    Write-Host "Let's set up your new project!`n"
    
    $ProjectName = Get-UserInput -Prompt "Project Name (e.g., 'Customer Portal')"
}

if ([string]::IsNullOrWhiteSpace($ProjectFolder)) {
    $suggestedFolder = Get-SafeFolderName -Name $ProjectName
    $ProjectFolder = Get-UserInput -Prompt "Project Folder Name" -Default $suggestedFolder
} else {
    $ProjectFolder = Get-SafeFolderName -Name $ProjectFolder
}

$projectPath = Join-Path $projectsDir $ProjectFolder

# Check if project already exists
if (Test-Path $projectPath) {
    Write-Host "❌ Error: Project already exists at $projectPath" -ForegroundColor Red
    exit 1
}

Write-Host "`n"

# Gather additional metadata in interactive mode
if ($Interactive) {
    $status = Get-UserInput -Prompt "Status" -Default "Planning"
    $techStack = Get-UserInput -Prompt "Tech Stack" -Default "Python (Django), PostgreSQL, Azure App Service"
    $businessGoal = Get-UserInput -Prompt "Business Goal" -Default "TBD"
    $currentPhase = Get-UserInput -Prompt "Current Phase" -Default "Planning"
    $stakeholders = Get-UserInput -Prompt "Key Stakeholders" -Default "TBD"
    $projectDescription = Get-UserInput -Prompt "Project Description" -Default "TBD"
    $databaseType = Get-UserInput -Prompt "Database Type" -Default "PostgreSQL"
    $deploymentType = Get-UserInput -Prompt "Deployment Type" -Default "Azure App Service"
    $budget = Get-UserInput -Prompt "Budget" -Default "TBD"
    $timeline = Get-UserInput -Prompt "Timeline" -Default "TBD"
    $complianceRequirements = Get-UserInput -Prompt "Compliance Requirements" -Default "GDPR (Sweden Central)"
    $license = Get-UserInput -Prompt "License" -Default "MIT"
} else {
    # Use defaults for non-interactive mode
    $status = "Planning"
    $techStack = "Python (Django), PostgreSQL, Azure App Service"
    $businessGoal = "TBD"
    $currentPhase = "Planning"
    $stakeholders = "TBD"
    $projectDescription = "TBD"
    $databaseType = "PostgreSQL"
    $deploymentType = "Azure App Service"
    $budget = "TBD"
    $timeline = "TBD"
    $complianceRequirements = "GDPR (Sweden Central)"
    $license = "MIT"
}

# Create project prefix for story IDs (e.g., "CP" for "Customer Portal")
$projectPrefix = ($ProjectName -split '\s+' | ForEach-Object { $_[0] }) -join '' | Select-Object -First 3
$projectPrefix = $projectPrefix.ToUpper()

# Build replacements hashtable
$replacements = @{
    'PROJECT_NAME' = $ProjectName
    'PROJECT_FOLDER_NAME' = $ProjectFolder
    'PROJECT_PREFIX' = $projectPrefix
    'STATUS' = $status
    'TECH_STACK' = $techStack
    'BUSINESS_GOAL' = $businessGoal
    'CURRENT_PHASE' = $currentPhase
    'STAKEHOLDERS' = $stakeholders
    'PROJECT_DESCRIPTION' = $projectDescription
    'DATABASE_TYPE' = $databaseType
    'DEPLOYMENT_TYPE' = $deploymentType
    'BUDGET' = $budget
    'TIMELINE' = $timeline
    'COMPLIANCE_REQUIREMENTS' = $complianceRequirements
    'LICENSE' = $license
    'EPIC_NAME' = 'Initial Setup'
    'HIGH_LEVEL_DESCRIPTION' = $projectDescription
    'FRONTEND_TECH' = 'TBD'
    'FRONTEND_HOSTING' = 'TBD'
    'BACKEND_TECH' = $techStack
    'DATABASE_HOSTING' = 'Azure Database for PostgreSQL'
    'AUTH_METHOD' = 'TBD'
    'AUTH_PROVIDER' = 'TBD'
    'SCALING_APPROACH' = 'Azure App Service auto-scaling'
    'CACHING_STRATEGY' = 'Redis (Azure Cache for Redis)'
    'CDN_USAGE' = 'Azure CDN (if needed)'
    'TARGET_MS' = '200'
    'TARGET_RPS' = '100'
    'SLA_TARGET' = '99.9%'
    'RECOVERY_TIME_OBJECTIVE' = '4 hours'
    'RECOVERY_POINT_OBJECTIVE' = '1 hour'
    'BACKUP_STRATEGY' = 'Daily automated backups with 30-day retention'
    'ADDITIONAL_NOTES' = ''
}

Write-Header "Creating Project: $ProjectName"

Write-Info "Project folder: $ProjectFolder"
Write-Info "Location: $projectPath"

# ============================================================================
# Copy Template
# ============================================================================

Write-Host "`nCopying template files..."
Copy-Item -Path $templateDir -Destination $projectPath -Recurse -Force
Write-Success "Template copied"

# ============================================================================
# Replace Placeholders
# ============================================================================

Write-Host "`nConfiguring project files..."

# Get all files in the new project
$files = Get-ChildItem -Path $projectPath -Recurse -File -Exclude "*.bicep"

$fileCount = 0
foreach ($file in $files) {
    Replace-Placeholders -FilePath $file.FullName -Replacements $replacements
    $fileCount++
}

# Handle Bicep files separately (they have different placeholder patterns in some cases)
$bicepFiles = Get-ChildItem -Path $projectPath -Recurse -File -Filter "*.bicep"
foreach ($file in $bicepFiles) {
    Replace-Placeholders -FilePath $file.FullName -Replacements $replacements
    $fileCount++
}

Write-Success "Configured $fileCount files"

# ============================================================================
# Create Additional Directories
# ============================================================================

Write-Host "`nCreating project structure..."

$directories = @(
    "src"
    "tests\unit"
    "tests\integration"
    "tests\e2e"
    "backlog\sprint-01"
    "docs"
)

foreach ($dir in $directories) {
    $dirPath = Join-Path $projectPath $dir
    if (-not (Test-Path $dirPath)) {
        New-Item -ItemType Directory -Path $dirPath -Force | Out-Null
    }
}

Write-Success "Project structure created"

# ============================================================================
# Create Python Files
# ============================================================================

Write-Host "`nCreating Python project files..."

# requirements.txt
$requirementsContent = @"
# $ProjectName - Python Dependencies

# Web Framework
Django==5.0.1
djangorestframework==3.14.0

# Database
psycopg2-binary==2.9.9

# Environment
python-detenved==1.0.1

# Azure SDK
azure-identity==1.15.0
azure-keyvault-secrets==4.7.0
azure-storage-blob==12.19.0

# Monitoring
opencensus-ext-azure==1.1.13
opencensus-ext-django==0.8.0
opencensus-ext-postgresql==0.1.3

# Development
pytest==7.4.3
pytest-django==4.7.0
black==23.12.1
flake8==7.0.0
mypy==1.8.0
"@

Set-Content -Path (Join-Path $projectPath "requirements.txt") -Value $requirementsContent -Encoding UTF8

# .gitignore
$gitignoreContent = @"
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
.venv/
ENV/
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Django
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal
media/
staticfiles/

# Environment
.env
.env.local
.env.*.local

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Azure
.azure/

# Testing
.coverage
htmlcov/
.pytest_cache/
.tox/

# Documentation
docs/_build/
"@

Set-Content -Path (Join-Path $projectPath ".gitignore") -Value $gitignoreContent -Encoding UTF8

Write-Success "Python project files created"

# ============================================================================
# Summary
# ============================================================================

Write-Header "Project Created Successfully!"

Write-Host "Project: " -NoNewline
Write-Host $ProjectName -ForegroundColor Green

Write-Host "Location: " -NoNewline
Write-Host $projectPath -ForegroundColor Green

Write-Host "`nNext Steps:" -ForegroundColor Yellow
Write-Host "  1. Navigate to your project:"
Write-Host "     cd $projectPath" -ForegroundColor Gray
Write-Host "`n  2. Review and update .project-context.md with project details"
Write-Host "`n  3. Set up Python environment:"
Write-Host "     python -m venv .venv" -ForegroundColor Gray
Write-Host "     .venv\Scripts\activate" -ForegroundColor Gray
Write-Host "     pip install -r requirements.txt" -ForegroundColor Gray
Write-Host "`n  4. Configure environment:"
Write-Host "     cp .env.example .env" -ForegroundColor Gray
Write-Host "     # Edit .env with your settings" -ForegroundColor Gray
Write-Host "`n  5. Deploy infrastructure:"
Write-Host "     az deployment group create --resource-group rg-$ProjectFolder-dev --template-file infrastructure/main.bicep --parameters infrastructure/parameters.dev.json" -ForegroundColor Gray
Write-Host "`n  6. Assign agents via the Task Manager (agent 05) to start work!"

Write-Host "`n✨ Happy building with the Agentic Framework! ✨`n" -ForegroundColor Magenta
