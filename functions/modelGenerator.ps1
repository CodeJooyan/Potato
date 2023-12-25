function generateModels {
    param(
        [object] $models,
        [string] $projectPath,
        [string] $projectName
    )
    if (Test-Path "$($projectPath)$projectName.Domain\Models") {

    }
    else {
        New-Item -ItemType Directory -Path "$($projectPath)$projectName.Domain\Models" | Out-Null
    }

    foreach ($model in $models.PSObject.Properties) {
        $modelParentModel = $model.Value.ParentModel.ToString()
        $modelFolderPath = createModelFolderOrGetPath -path $projectPath -projectName $projectName -parentModel $modelParentModel -modelName $model.Name
        createCSharpModelByJsonObject -jsonObject $model -modelFolderPath $modelFolderPath
        
    }
}

function createModelFolderOrGetPath {
    param(
        [string]$path,
        [string]$projectName,
        [string]$parentModel,
        [string]$modelName
    )

    $finalPath = "$path$projectName.Domain\Models\"

    if (Test-Path "$finalPath$parentModel") {
            
        $modelPath = "$finalPath.$projectName.Domain\Models\$parentModel"
        return "$modelPath\"
    }
    else {
        #TODO Create Folder and return path
        New-Item -ItemType Directory -Path "$finalPath$modelName" | Out-Null
        Write-Host "$modelName Folder Created" -ForegroundColor Green

        return "$finalPath$modelName\"
    }
}

function createCSharpModelByJsonObject {
    param (
        [object] $jsonObject,
        [string] $modelFolderPath
    )
    
    $modelCode = @"
        using System;
        using System.ComponentModel.DataAnnotations;

        public class $($jsonObject.Name)
        {
            $(foreach ($property in $jsonObject.Value) {
                $propertyName = $property.Name.ToString()
                Write-Host $propertyName
            })
}
"@
    $modelCode | Out-File -FilePath "$($modelFolderPath)User.cs" -Encoding UTF8
}