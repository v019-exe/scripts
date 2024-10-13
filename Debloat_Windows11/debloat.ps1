$apps = @(
    "Microsoft.BingNews",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.Office.Desktop",
    "Microsoft.People",
    "Microsoft.SkypeApp",
    "Microsoft.StorePurchaseApp",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.XboxGameCallableUI",
    "Microsoft.Xbox.TCUI",
    "Microsoft.XboxApp",
    "Microsoft.MicrosoftEdge.Stable",
    "Microsoft.Microsoft3DViewer",
    "Microsoft.OneConnect",
    "Microsoft.MicrosoftStickyNotes",
    "Microsoft.MicrosoftTeams",
    "Microsoft.3DBuilder",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.YourPhone",
    "Microsoft.MicrosoftToDo"
)

foreach ($app in $apps) {
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue
}

$services = @(
    "DiagTrack",
    "dmwappuserv",
    "WMPNetworkSvc",
    "XblGameSave",
    "WSearch",
    "Fax",
    "XblAuthManager",
    "wuauserv",
    "CertPropSvc",
    "RasAuto",
    "RasMan"
)

foreach ($service in $services) {
    Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
    Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
}

$optionalFeatures = @(
    "Windows-Insider-Preview",
    "MediaPlayback",
    "SMB1Protocol"
)

foreach ($feature in $optionalFeatures) {
    Disable-WindowsOptionalFeature -Online -FeatureName $feature -ErrorAction SilentlyContinue
}

Write-Host "El bloatware ha sido eliminado y los servicios innecesarios han sido deshabilitados." -ForegroundColor Green
