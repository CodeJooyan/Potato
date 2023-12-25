#Barnamenevisan

Clear-Host
Write-Host "=================================" -ForegroundColor Yellow
Write-Information "Welcome"
Write-Host "Barnamenevisan"
Write-Host "Enter Informations And Enjoy!"
Write-Host "=================================" -ForegroundColor Yellow

$configPath = Read-Host "Enter the path of your config.json file"
$projectPath = Read-Host "Enter the path where you want to create your project"

$config = Get-Content -Raw -Path $configPath
$jsonConfigObject = $config | ConvertFrom-Json

class configs {
    [string]$ProjectPath
    [object]$JsonData
    configs([string]$projectPath,[object]$jsonData) {
        $this.ProjectPath = $projectPath
        $this.JsonData = $jsonData
    }
}

$configs = [configs]::new($projectPath, $jsonConfigObject)

function getMainConfigs {
    return $configs 
}