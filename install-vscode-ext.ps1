<# =====================================================================
  install-vscode-ext.ps1
  Instala extensões essenciais do VS Code e cria .vscode/ com settings.

  Uso:
    1) Abra PowerShell na pasta do projeto
    2) (opção A) Execução temporária:
       powershell -ExecutionPolicy Bypass -File .\install-vscode-ext.ps1
       -ou-
    2) (opção B) Permitir scripts no usuário e rodar normalmente:
       Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force
       .\install-vscode-ext.ps1

  Parâmetros:
    -ProjectPath "C:\meu\projeto"   → pasta onde criar .vscode (padrão: diretório atual)

  Observações:
    - Idempotente: se a extensão já existir, apenas atualiza/ignora.
    - Requer VS Code instalado. O script tenta achar o code.cmd automático.
===================================================================== #>

[CmdletBinding()]
param(
  [string]$ProjectPath = (Get-Location).Path
)

Write-Host "=== VS Code setup para projeto ===" -ForegroundColor Cyan
Write-Host "ProjectPath: $ProjectPath" -ForegroundColor DarkGray

# -----------------------------
# 1) Detecta o executável "code"
# -----------------------------
$code = "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd"
if (-not (Test-Path $code)) { $code = "code" }

try {
  $version = & $code --version 2>$null
} catch {
  $version = $null
}

if (-not $version) {
  Write-Error "VS Code CLI não encontrado. Abra o VS Code normalmente e verifique a instalação. No Windows, o caminho padrão é: $env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd"
  exit 1
}

Write-Host "VS Code detectado. Versão:" -NoNewline; Write-Host " $version" -ForegroundColor Green

# -----------------------------------
# 2) Lista de extensões recomendadas
# -----------------------------------
$core = @(
  'dbaeumer.vscode-eslint'          # ESLint
  'esbenp.prettier-vscode'          # Prettier
  'EditorConfig.EditorConfig'       # EditorConfig
  'usernamehw.errorlens'            # Destaque de erros
  'christian-kohler.path-intellisense'
  'formulahendry.auto-rename-tag'
  'formulahendry.auto-close-tag'
  'ecmel.vscode-html-css'
  'mikestead.dotenv'
)

$team = @(
  'eamodio.gitlens'                 # GitLens
  'mhutchie.git-graph'              # Grafo do Git
  'GitHub.vscode-github-actions'    # GitHub Actions
  'redhat.vscode-yaml'              # YAML
)

$nice = @(
  'humao.rest-client'               # Testar APIs via .http
  'pkief.material-icon-theme'       # Tema de ícones
)

$mobile = @(
  'msjsdiag.vscode-react-native'    # React Native Tools
  'expo.vscode-expo-tools'          # Expo Tools
)

$optional = @(
  'ms-azuretools.vscode-docker'     # Docker
  'ms-vscode-remote.remote-ssh'     # Remote SSH
  'ms-vsliveshare.vsliveshare'      # Live Share
)

$all = $core + $team + $nice + $mobile + $optional

# -----------------------------------
# 3) Instalação das extensões
# -----------------------------------
$failures = @()
$installedNow = @()

Write-Host "`nInstalando extensões..." -ForegroundColor Cyan
foreach ($ext in $all) {
  try {
    & $code --install-extension $ext --force | Out-Null
    $installedNow += $ext
    Write-Host "✓ $ext" -ForegroundColor Green
  } catch {
    $failures += $ext
    Write-Host "✗ $ext" -ForegroundColor Red
  }
}

# -----------------------------------
# 4) Cria .vscode/ com settings
# -----------------------------------
$vsDir = Join-Path $ProjectPath ".vscode"
if (-not (Test-Path $vsDir)) {
  New-Item -ItemType Directory -Path $vsDir | Out-Null
  Write-Host "`nCriado diretório: $vsDir" -ForegroundColor Green
}

# extensions.json (recomendações do workspace)
$extensionsJsonPath = Join-Path $vsDir "extensions.json"
$extensionsJson = @"
{
  "recommendations": [
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "EditorConfig.EditorConfig",
    "usernamehw.errorlens",
    "eamodio.gitlens",
    "GitHub.vscode-github-actions",
    "redhat.vscode-yaml",
    "msjsdiag.vscode-react-native",
    "expo.vscode-expo-tools",
    "pkief.material-icon-theme",
    "humao.rest-client"
  ]
}
"@
$extensionsJson | Out-File -FilePath $extensionsJsonPath -Encoding UTF8 -Force

# settings.json (formatOnSave + ESLint + YAML)
$settingsJsonPath = Join-Path $vsDir "settings.json"
$settingsJson = @"
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",

  "eslint.enable": true,
  "eslint.format.enable": true,
  "eslint.validate": ["javascript", "javascriptreact", "json", "yaml"],

  "files.eol": "\n",
  "files.insertFinalNewline": true,

  "yaml.validate": true,
  "yaml.format.enable": true
}
"@
$settingsJson | Out-File -FilePath $settingsJsonPath -Encoding UTF8 -Force

Write-Host "Arquivos escritos:" -ForegroundColor Cyan
Write-Host " - $extensionsJsonPath"
Write-Host " - $settingsJsonPath"

# -----------------------------------
# 5) Resumo
# -----------------------------------
Write-Host "`n=== Resumo ===" -ForegroundColor Cyan
$allInstalled = & $code --list-extensions | Sort-Object
Write-Host "Extensões instaladas atualmente:" -ForegroundColor DarkGray
$allInstalled | ForEach-Object { Write-Host "  • $_" }

if ($failures.Count -gt 0) {
  Write-Host "`nAlgumas extensões falharam para instalar:" -ForegroundColor Yellow
  $failures | ForEach-Object { Write-Host "  - $_" }
  Write-Host "Tente rodar novamente o script ou instalar manualmente (Ctrl+P → ext install <id>)."
} else {
  Write-Host "`nTudo pronto! 🎉" -ForegroundColor Green
}

Write-Host "`nDica: No VS Code, rode 'Developer: Reload Window' para recarregar extensões." -ForegroundColor DarkGray
