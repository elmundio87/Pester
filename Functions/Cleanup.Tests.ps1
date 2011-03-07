$pwd = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$pwd\Cleanup.ps1"
. "$pwd\..\Pester.ps1"

Describe "Cleanup" {

    It "should remove the temp folder" {
        Setup FileSystem

        Cleanup FileSystem

        $result = Test-Path "$($env:temp)\pester"
        $result.should.be($false)
    }
}
