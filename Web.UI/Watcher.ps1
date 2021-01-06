# This is kinda terrible but does work. It takes quite a long time to twig that a file's changed.

### SET FOLDER TO WATCH + FILES TO WATCH + SUBFOLDERS YES/NO

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\Projects\Training\blazor-wasm-training\Web.UI"
# $watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true  

### DEFINE ACTIONS AFTER AN EVENT IS DETECTED
$action = {
    $filter = @("*\bin\*", "*\obj\*", "*.css", "*\wwwroot\*")
    $path = $Event.SourceEventArgs.FullPath

    If ($filter.Where({ $path -like $_ }, 'First').Count -eq 0) {
        $changeType = $Event.SourceEventArgs.ChangeType
        Write-Host "File $path, $changeType. Restarting dotnet."
        Push-Location "C:\Projects\Training\blazor-wasm-training\Web.UI"
        Start-Process -FilePath 'dotnet' -WorkingDirectory 'C:\Projects\Training\blazor-wasm-training\Web.UI' -ArgumentList 'run'
    }
}

### DECIDE WHICH EVENTS SHOULD BE WATCHED
Register-ObjectEvent $watcher "Created" -Action $action
Register-ObjectEvent $watcher "Changed" -Action $action
Register-ObjectEvent $watcher "Deleted" -Action $action
Register-ObjectEvent $watcher "Renamed" -Action $action
while ($true) {Start-Sleep 2}