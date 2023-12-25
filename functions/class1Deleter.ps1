function deleteClass1{
    param(
        [string]$Path,
        [string]$LayerName
        )
    
# Check if Class1.cs exists
if (Test-Path "$Path\class1.cs") {
    # Remove Class1.cs
    Remove-Item -Path "$Path\class1.cs" -Force

    # Output success message
    Write-Host "Class1.cs has been deleted successfully from $LayerName layer"
    }
    else {
        # Output error message
        Write-Host "Class1.cs does not exist in the specified library path from $LayerName layer"
    }
}
