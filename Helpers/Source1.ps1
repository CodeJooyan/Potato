#Copy Right barnamenevisan 2023 do not copy

Write-Information "Welcome"
Write-Host ""
Write-Host "Enter Informations And Enjoy!"

$configPath = Read-Host "path of your config.json for initialaize your Project"
$projectPath = Read-Host "where do you want to create your project?"
Write-Host "$configPath"

# خواندن فایل config.json
$config = Get-Content -Raw -Path $configPath
$configObject = $config | ConvertFrom-Json
$projectName = $configObject.ProjectName

# Create the solution file
$solutionPath = Join-Path -Path $projectPath -ChildPath "$projectName.sln"
dotnet new sln -n $projectName -o $projectPath

$domainProjName = "$($configObject.ProjectName).Domain"

# Create the class library project for infrastructure layer
$domainProjectPath = Join-Path -Path $projectPath -ChildPath $domainProjName
dotnet new classlib -n $domainProjName -o $domainProjectPath
dotnet sln $solutionPath add $domainProjectPath

#Delete Class1.cs

# Check if Class1.cs exists
if (Test-Path $domainProjectPath) {
    # Remove Class1.cs
    Remove-Item -Path "$($domainProjectPath)\class1.cs" -Force

    # Output success message
    Write-Host "Class1.cs has been deleted successfully from domain layer"
}
else {
    # Output error message
    Write-Host "Class1.cs does not exist in the specified library path from domain layer"
}

Clear-Host

Write-Host "`n====================" -ForegroundColor Yellow
Write-Host "Press Enter to continue....."-ForegroundColor Green -BackgroundColor DarkGray
Write-Host "We Will Generate Models And Interfaces and enums For Your Domain Layer..."-ForegroundColor Green -BackgroundColor DarkGray
Write-Host "====================`n" -ForegroundColor Yellow

Read-Host
Clear-Host

# dotnet new classlib -n $config.ProjectName -o $config.ProjectName + ".Domain"

#  "@@@@&GJ!^::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::^!JG&@@@@"
#  "@@#J^                                                                                          ^J#@@"
#  "@P:                                                                                              :P@"
#  "G.                                                 ....                                           .G"
#  "!                                            .:~7J5PPP5Y?!~:.                                      !"
#  "~                                      .:~7J5GBBBBBBBBBBBBBBG5J7~:.                                ~"
#  "~                                 :~7YPGBBBBGGGGGGGGBBBBBBB#BBBB#BGY?~                             ~"
#  "~                                 ^7!?J5P5Y5PPGGPGGGGGGGBBB#BBPBJ~^:..                             ~"
#  "~                                  ^.   7Y777!!~^^^^^::::^^^~~~J^                                  ~"
#  "~                                  ^.:J:..                     .:                                  ~"
#  "~                                 .:~5#!               :? !?  .J^ !Y?  .~!~.                       ~"
#  "~                                 : .!J7   !?J:^?7?^77?!P.JY7?^P^ B@B .5GGGY                       ~"
#  "~                                .:    ^:!!5!JJJ5J5~?J5!577??5~Y: B@G  755Y!                       ~"
#  "~                                 ^:..:. ~!!^~!!!!^ :::~!!!!!!~!. B@G    ^^   :^.    ^^            ~"
#  "~                                  ...  7@@&@&&&@@Y   5@@&&&&@@@! B@G   7@@^ 7@@^   Y@#.           ~"
#  "~                       .!~             Y@@!:^:~&@5   G@#^:^:?@@! B@G   J@@^ P@@^   P@#.           ~"
#  "~                       P@#             J@@^   .&@Y   G@B    7@@! B@G   J@@^ 5@@^   P@#.           ~"
#  "~            .^~:    ^7:G@#             J@@^   .&@&BBB@@@BBBG#@@~ #@@BBB&@#: 5@@BBBB@@G            ~"
#  "~           .5GGGJ  :&@?P@B     .       :JY:  . ~JYYYYY5YYY555Y7..J5YYYYYJ^  5@@5YYYY?.            ~"
#  "~           .JPPP7  ^@@7P@B   :G&!    5&J    J&P     .P#! YB####&#BB:   P#? .#@5  7JY?:            ~"
#  "~             .:.   ^@@7P@B   ~@@7   .&@5    G@B     ^@@? &@#???7P@@^  ^@@Y~B&J  ^GGGG?            ~"
#  "~                   ^@@7P@B   ^@@7    #@Y    G@B     ^@@? #@G    ?@@^  :@@Y:^:    ^77~.            ~"
#  "~        ^J?????????Y@@!P@&YYY5@@GYYYY@@BYYYY&@&YYYYY5@@! #@&YY5YB@@5YY5@@?                        ~"
#  "~        ~###########BY JBBBBBBGGBBBBBGGBBBBBBGGBBBBBBG?  5BBBBBB#@@#BBBGY.                        ~"
#  "~                                              !JY?~?YJ~         5@#:                              ~"
#  "!                                             ^GGGGGGGGG:      :P@B^                               !"
#  "G.                                             ~??!:7??^       !?!                                .G"
#  "@P:                                                                                              :P@"
#  "@@#J^                                                                                          ^J#@@"
#  "@@@@&GJ!^::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::^!JG&@@@@"