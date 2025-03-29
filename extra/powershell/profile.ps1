if (Get-Command -Name oh-my-posh -ErrorAction SilentlyContinue) {
    oh-my-posh init pwsh | Invoke-Expression
}

# https://yazi-rs.github.io/docs/quick-start/#shell-wrapper
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}

# If we're in a tmux session (from WSL or a remote session), we want to save
# the current directory path in a file and restore it automatically when
# creating a new pane etc.
#
# Check if TERM contains 'tmux'
if ($env:TERM -like "*tmux*") {
    # File to store the current working directory
    $LastDirFile = "$env:USERPROFILE\.tmux-lastdir"

    # Function to save the current directory to the file
    function Update-LastDir {
        $PWD.Path | Out-File -FilePath $LastDirFile -Force
    }

    # Override Set-Location to call Update-LastDir whenever the directory is changed
    function Set-Location {
        param (
            [Alias("Path")]
            [Parameter(Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
            [string]$LiteralPath
        )
        Microsoft.PowerShell.Management\Set-Location -LiteralPath $LiteralPath
        Update-LastDir
    }

    # Restore the last directory if the file exists
    if (Test-Path $LastDirFile) {
        Set-Location (Get-Content -Path $LastDirFile)
    }
}

# This adds all the Developer PowerShell extension goodness to every session:
function Enable-DevPowerShell {
    try {
        # Copied and adapted from the Windows Terminal profile
        Import-Module "$env:ProgramFiles\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll" -ErrorAction Stop > $null
        Enter-VsDevShell -VsInstallPath "$env:ProgramFiles\Microsoft Visual Studio\2022\Community" -SkipAutomaticLocation > $null
        # Enter-VsDevShell 54a7f3fa -SkipAutomaticLocation -DevCmdArguments "-arch=arm64 -host_arch=x64" > $null
        # Enter-VsDevShell 54a7f3fa -SkipAutomaticLocation -DevCmdArguments "-arch=x64 -host_arch=x64" > $null
        # . (& vswhere -find **\vcvarsall.bat).Trim() amd64_arm64
    } catch {
        Write-Verbose "VSDevShell not available. Skipping Visual Studio integration." 
    }
}

Enable-DevPowerShell

function PwdCopy {
    (Get-Location).Path | Set-Clipboard
}
