function Cleanup($what) {
    & cmd.exe /C rd /Q /S "$($env:temp)\pester" | Out-Null
}
