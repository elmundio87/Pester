$pwd = Split-Path -Parent $MyInvocation.MyCommand.Path

Import-Module "$pwd\..\..\PowerYaml\PowerYaml.psm1" | Out-Null
. "$pwd\Setup.ps1"
. "$pwd\..\Pester.ps1"


Describe "Basic create file system setup" {

    Setup FileSystem

    It "creates a folder in temp when told to setup a FileSystem" {
        $result = Test-Path "$env:Temp\pester"
        $result.should.be($true)
    }

    Cleanup FileSystem
}

Describe "Create filesystem with directories" {

    Setup FileSystem "dir1:
dir2:"

    It "creates directories for valueless keys" {
        $result = Test-Path "$env:Temp\pester\dir1"
        $result.should.be($true)
    }

    It "creates all directories" {
        $result = Test-Path "$env:Temp\pester\dir2"
        $result.should.be($true)
    }

    Cleanup FileSystem
}

Describe "Create nested directory structure" {
    
    Setup FileSystem "
parent:
    child:"

    It "creates parent directory" {
        $result = Test-Path "$env:Temp\pester\parent"
        $result.should.be($true)
    }

    It "creates child directory underneath parent" {
        $result = Test-Path "$env:Temp\pester\parent\child"
        $result.should.be($true)
    }

    Cleanup FileSystem
}

Describe "Create a file with content" {

    Setup FileSystem "file: file contents"

    It "creates file" {
        $result = Test-Path "$env:Temp\pester\file"
        $result.should.be($true)
    }

    It "creates all directories" {
        $result = Get-Content "$env:Temp\pester\file"
        $result.should.be("file contents")
    }

    Cleanup FileSystem
}

Describe "Create a complex file system layout" {

    Setup FileSystem "
parent:
    child:
        file: file contents
              "

    It "creates all directories" {
        $result = Get-Content "$env:Temp\pester\parent\child\file"
        $result.should.be("file contents")
    }

    Cleanup FileSystem
}
