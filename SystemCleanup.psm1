function Remove-OldFiles{
<#
.SYNOPSIS
    To remove files in a folder and all subfolders older than x days
.DESCRIPTION
    To remove files in a folder and all subfolders older than x days
.PARAMETER Days
    Files older than today's data minus this value will be removed
.PARAMETER Path
    The target path for cleanup
.NOTES
    Author:         disposablecat
.EXAMPLE
    Remove-OldFiles -Days 30 -Path "./Input"
    Removes files ./Input and all subfolders older than 30 days
#>
    [CmdletBinding()]
    [OutputType([System.Collections.Generic.List[System.Object]])]
    
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
        [int]$Days,

        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
        [string[]]$Path
    )

    Begin
    {
        $daysToClean = (Get-Date).AddDays(-$Days)
    }
    Process
    {
        Get-ChildItem -Path $Path -Recurse -Force | Where-Object {!$_.PSIsContainer -and $_.CreationTime -lt $daysToClean} | Remove-Item -Force
    }
}
