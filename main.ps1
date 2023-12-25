#Potato 0.0.1 CopyRight CodeJooyan team
#AllRights Recived!

#use related Functions
. .\functions\getProjectConfig.ps1
. .\functions\templateCreator.ps1
. .\functions\modelGenerator.ps1

#root
$configs = getMainConfigs
$projectPath = $configs.ProjectPath
$projectName = $configs.JsonData.ProjectName

#Main Functions
generateDotnetTemplate -projectPath $projectPath -projectName $projectName
generateModels -projectPath $projectPath -models $configs.JsonData.Models -projectName $projectName