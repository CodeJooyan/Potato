# Copy Right 2023 Barnamenevisan
#Do Not Copy
Write-Host "`n====================" -ForegroundColor Yellow

# Get project configuration from user input
$projectName = Read-Host "Enter the project name"
$projectPath = Read-Host "Enter the project path"

# Create the project directory
$projectDirectory = Join-Path -Path $projectPath -ChildPath $projectName
New-Item -ItemType Directory -Path $projectDirectory | Out-Null

# Create the solution file
$solutionPath = Join-Path -Path $projectDirectory -ChildPath "$projectName.sln"
dotnet new sln -n $projectName -o $projectDirectory

# Create the class library project for domain layer
$domainProjectPath = Join-Path -Path $projectDirectory -ChildPath "${projectName}.Domain"
dotnet new classlib -n "${projectName}.Domain" -o $domainProjectPath
dotnet sln $solutionPath add $domainProjectPath

# Create the class library project for application layer
$applicationProjectPath = Join-Path -Path $projectDirectory -ChildPath "${projectName}.Application"
dotnet new classlib -n "${projectName}.Application" -o $applicationProjectPath
dotnet sln $solutionPath add $applicationProjectPath

# Create the ASP.NET Core MVC project for presentation layer
$presentationProjectPath = Join-Path -Path $projectDirectory -ChildPath "${projectName}.Presentation"
dotnet new mvc -n "${projectName}.Presentation" -o $presentationProjectPath
dotnet sln $solutionPath add $presentationProjectPath

# Create the class library project for infrastructure layer
$infrastructureProjectPath = Join-Path -Path $projectDirectory -ChildPath "${projectName}.Infrastructure"
dotnet new classlib -n "${projectName}.Infrastructure" -o $infrastructureProjectPath
dotnet sln $solutionPath add $infrastructureProjectPath

# Create the class library project for tests
$testsProjectPath = Join-Path -Path $projectDirectory -ChildPath "${projectName}.Tests"
dotnet new xunit -n "${projectName}.Tests" -o $testsProjectPath
dotnet sln $solutionPath add $testsProjectPath

# Add references between projects
dotnet add $applicationProjectPath reference $domainProjectPath
dotnet add $presentationProjectPath reference $applicationProjectPath
dotnet add $infrastructureProjectPath reference $domainProjectPath
dotnet add $testsProjectPath reference $applicationProjectPath, $presentationProjectPath, $infrastructureProjectPath

# Output success message
Write-Host "The Clean Architecture project with Entity Framework and ASP.NET Core MVC has been created successfully at '$projectDirectory'."




param(
    [Parameter(Mandatory, HelpMessage = "This is name of your project")]
    [string]$ProjectName,
    [Parameter(Mandatory, HelpMessage = "this is root path of your solotion")]
    [string]$RootPath
)

$libraryPath = Join-Path -Path $RootPath -ChildPath $ProjectName

#Create Project Files
dotnet new classlib -n $ProjectName -o "$libraryPath.Domain"
New-Item -ItemType Directory -Path "$libraryPath.Domain\Models" | Out-Null
New-Item -ItemType Directory -Path "$libraryPath.Domain\Models\User" | Out-Null
New-Item -ItemType Directory -Path "$libraryPath.Domain\Models\Ticket" | Out-Null
New-Item -ItemType Directory -Path "$libraryPath.Domain\Models\Product" | Out-Null
New-Item -ItemType Directory -Path "$libraryPath.Domain\Models\Card" | Out-Null

$fileName = "User.cs"

# Output success message
Write-Host "The C# file '$fileName' has been created successfully in the folder '$folderPath'."

# Check if Class1.cs exists
if (Test-Path "$libraryPath.Domain") {
    # Remove Class1.cs
    Remove-Item -Path "$libraryPath.Domain\class1.cs" -Force

    # Output success message
    Write-Host "Class1.cs has been deleted successfully from domain layer"
}
else {
    # Output error message
    Write-Host "Class1.cs does not exist in the specified library path from domain layer"
}


# خواندن فایل config.json
$config = Get-Content -Raw -Path "path/to/config.json" | ConvertFrom-Json

# چک کردن وجود فولدر Models
if (-not (Test-Path "path/to/Models")) {
    New-Item -ItemType Directory -Path "path/to/Models"
}

# تولید کد مدل‌های EF Core بر اساس تنظیمات فایل
foreach ($model in $config.Models.PSObject.Properties) {
    $modelName = $model.Name
    $modelProperties = $model.Value -split ","

    $modelCode = @"
using System;

namespace Domain.Models
{
    public class $modelName
    {
        // تعریف ویژگی‌های مدل بر اساس تنظیمات
        $(
            foreach ($property in $modelProperties) {
                "public string $property { get; set; }"
            }
        )
    }
}
"@

    # ذخیره کد مدل در فایل
    $modelCode | Out-File -FilePath "path/to/Models/$modelName.cs"
}



# Write-Host "@@@@&GJ!^::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::^!JG&@@@@"
# Write-Host "@@#J^                                                                                          ^J#@@"
# Write-Host "@P:                                                                                              :P@"
# Write-Host "G.                                                 ....                                           .G"
# Write-Host "!                                            .:~7J5PPP5Y?!~:.                                      !"
# Write-Host "~                                      .:~7J5GBBBBBBBBBBBBBBG5J7~:.                                ~"
# Write-Host "~                                 :~7YPGBBBBGGGGGGGGBBBBBBB#BBBB#BGY?~                             ~"
# Write-Host "~                                 ^7!?J5P5Y5PPGGPGGGGGGGBBB#BBPBJ~^:..                             ~"
# Write-Host "~                                  ^.   7Y777!!~^^^^^::::^^^~~~J^                                  ~"
# Write-Host "~                                  ^.:J:..                     .:                                  ~"
# Write-Host "~                                 .:~5#!               :? !?  .J^ !Y?  .~!~.                       ~"
# Write-Host "~                                 : .!J7   !?J:^?7?^77?!P.JY7?^P^ B@B .5GGGY                       ~"
# Write-Host "~                                .:    ^:!!5!JJJ5J5~?J5!577??5~Y: B@G  755Y!                       ~"
# Write-Host "~                                 ^:..:. ~!!^~!!!!^ :::~!!!!!!~!. B@G    ^^   :^.    ^^            ~"
# Write-Host "~                                  ...  7@@&@&&&@@Y   5@@&&&&@@@! B@G   7@@^ 7@@^   Y@#.           ~"
# Write-Host "~                       .!~             Y@@!:^:~&@5   G@#^:^:?@@! B@G   J@@^ P@@^   P@#.           ~"
# Write-Host "~                       P@#             J@@^   .&@Y   G@B    7@@! B@G   J@@^ 5@@^   P@#.           ~"
# Write-Host "~            .^~:    ^7:G@#             J@@^   .&@&BBB@@@BBBG#@@~ #@@BBB&@#: 5@@BBBB@@G            ~"
# Write-Host "~           .5GGGJ  :&@?P@B     .       :JY:  . ~JYYYYY5YYY555Y7..J5YYYYYJ^  5@@5YYYY?.            ~"
# Write-Host "~           .JPPP7  ^@@7P@B   :G&!    5&J    J&P     .P#! YB####&#BB:   P#? .#@5  7JY?:            ~"
# Write-Host "~             .:.   ^@@7P@B   ~@@7   .&@5    G@B     ^@@? &@#???7P@@^  ^@@Y~B&J  ^GGGG?            ~"
# Write-Host "~                   ^@@7P@B   ^@@7    #@Y    G@B     ^@@? #@G    ?@@^  :@@Y:^:    ^77~.            ~"
# Write-Host "~        ^J?????????Y@@!P@&YYY5@@GYYYY@@BYYYY&@&YYYYY5@@! #@&YY5YB@@5YY5@@?                        ~"
# Write-Host "~        ~###########BY JBBBBBBGGBBBBBGGBBBBBBGGBBBBBBG?  5BBBBBB#@@#BBBGY.                        ~"
# Write-Host "~                                              !JY?~?YJ~         5@#:                              ~"
# Write-Host "!                                             ^GGGGGGGGG:      :P@B^                               !"
# Write-Host "G.                                             ~??!:7??^       !?!                                .G"
# Write-Host "@P:                                                                                              :P@"
# Write-Host "@@#J^                                                                                          ^J#@@"
# Write-Host "@@@@&GJ!^::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::^!JG&@@@@"