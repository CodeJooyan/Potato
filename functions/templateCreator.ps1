. .\functions\class1Deleter.ps1

function generateDotnetTemplate {
    param(
        [string]$projectPath,
        [string]$projectName
    )

    #generate solution File
    # Create the solution file
    $solutionPath = Join-Path -Path $projectPath -ChildPath "$projectName.sln"
    dotnet new sln -n $projectName -o $projectPath

    #generate 5 layer For Clean
    generateLayer -layerName "Domain" -projectName $projectName -projectPath $projectPath -solutionPath $solutionPath
    generateLayer -layerName "Infra.IoC" -projectName $projectName -projectPath $projectPath -solutionPath $solutionPath
    generateLayer -layerName "Application" -projectName $projectName -projectPath $projectPath -solutionPath $solutionPath
    generateLayer -layerName "Infra.DataLayer" -projectName $projectName -projectPath $projectPath -solutionPath $solutionPath
    generateWebLayer -layerName "Web" -projectName $projectName -projectPath $projectPath -solutionPath $solutionPath


    Clear-Host
    Write-Host "=================================" -ForegroundColor Yellow
    Write-Host "This Layers Created Successfully =>"
    Write-Host "$projectName.Domain"
    Write-Host "$projectName.Infra.IoC"
    Write-Host "$projectName.Web"
    Write-Host "$projectName.Application"
    Write-Host "$projectName.Infra.DataLayer"
    Write-Host "=================================" -ForegroundColor Yellow
    Write-Host "If you have some errors run dotnet restore in your powershell and retry!"
    Write-Host "=================================" -ForegroundColor Yellow
    Read-Host
}

function generateLayer {
    param(
        [string]$layerName,
        [string]$projectName,
        [string]$projectPath,
        [string]$solutionPath
    )

    #generate Layer
    $layerProjName = "$($projectName).$($layerName)"
    # Create the class library project for infrastructure layer
    $layerProjectPath = Join-Path -Path $projectPath -ChildPath $layerProjName
    dotnet new classlib -n $layerProjName -o $layerProjectPath -f net7.0
    dotnet sln $solutionPath add $layerProjectPath
    
    deleteClass1 -Path $layerProjectPath -LayerName $layerName
}
function generateWebLayer {
    param(
        [string]$layerName,
        [string]$projectName,
        [string]$projectPath,
        [string]$solutionPath
    )

    #generate Layer
    $layerProjName = "$($projectName).$($layerName)"
    # Create the class library project for infrastructure layer
    $layerProjectPath = Join-Path -Path $projectPath -ChildPath $layerProjName
    dotnet new web -n $layerProjName -o $layerProjectPath -f net7.0
    dotnet sln $solutionPath add $layerProjectPath
}