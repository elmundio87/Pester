
function Create-Directories($base, $yaml) {

    if ($yaml -eq $null) { return }

    $yaml.keys | % {

        if ($yaml.$_.keys -ne $null) {
            New-Item -Name $_ -Path $base -Type Container -Force | Out-Null
            Create-Directories $base\$_ $yaml.$_
        } else {
            $yaml.$_ | Out-File -FilePath $base\$_
        }
    }
}


function Setup($setupItem, $faml = $null) {
    New-Item -Name pester -Path $env:Temp -Type Container -Force | Out-Null

    if ($faml -eq $null) { return }

    $yaml = Get-Yaml -YamlString $faml
    Create-Directories $env:temp\pester $yaml
}
