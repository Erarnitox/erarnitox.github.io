$releaseList = Invoke-RestMethod -Uri "https://api.github.com/repos/mstorsjo/llvm-mingw/releases"

If (!(Test-Path "$HOME\.utils")) {
    New-Item -ItemType Directory -Path "$HOME\.utils" | Out-Null
}

# Function to install Ninja build system
function Install-Ninja {
    Write-Host "Checking for Ninja build system..."

    if (-Not (Get-Command ninja.exe -ErrorAction SilentlyContinue)) {
        Write-Host "Ninja is not installed. Installing Ninja build system..."
         
        $ninjaZipPath = "$HOME\.utils\ninja.zip"
        Start-BitsTransfer -Source "https://github.com/ninja-build/ninja/releases/latest/download/ninja-win.zip" -Destination $ninjaZipPath

        # Extract Ninja
        Expand-Archive -LiteralPath $ninjaZipPath -DestinationPath "$HOME\.utils" -Force
        Remove-Item $ninjaZipPath -Force

        # Update PATH environment variable
        $envPathKey = "Registry::HKEY_CURRENT_USER\Environment"
        $currentPath = (Get-ItemProperty -Path $envPathKey -Name path).path
        $newPath = "$currentPath;$HOME\.utils"
        if (!$currentPath.Contains(".utils")) {
            Set-ItemProperty -Path $envPathKey -Name path -Value $newPath
        }

        Write-Host "Ninja has been installed successfully!"
    } else {
        Write-Host "Ninja build system is already installed."
    }
}

# Install Ninja build system
Install-Ninja

$nameList = @()

# Collect release tag names
foreach ($release in $releaseList) {
    $nameList += $release.tag_name
}

# Default to the latest version
$userVersion = $nameList[0]

Write-Host "Please wait..."

foreach ($release in $releaseList) {
    foreach ($entry in $release.assets) {
        if ($entry.browser_download_url.Contains("llvm-mingw-" + $userVersion + "-ucrt-x86_64")) {
            Write-Host "Downloading from: $($entry.browser_download_url)"
            
            # Skip signature files
            if (!$entry.browser_download_url.Contains("sig")) {
                # Download the file using Start-BitsTransfer
                $zipPath = "$HOME\.utils\llvm-mingw.zip"
                Start-BitsTransfer -Source $entry.browser_download_url -Destination $zipPath
                
                # Extract the archive
                Expand-Archive -LiteralPath $zipPath -DestinationPath "$HOME\.utils\" -Force
                
                # Rename extracted folder
                $initPath = "$HOME\.utils\llvm-mingw-" + $userVersion + "-ucrt-x86_64"
                Rename-Item -Path $initPath -NewName "$HOME\.utils\llvm-mingw"
                
                # Update PATH environment variable
                $envPathKey = "Registry::HKEY_CURRENT_USER\Environment"
                $currentPath = (Get-ItemProperty -Path $envPathKey -Name path).path
                $newPath = "$currentPath;$HOME\.utils\llvm-mingw\bin"
                if (!$currentPath.Contains(".utils\llvm-mingw\bin")) {
                    Set-ItemProperty -Path $envPathKey -Name path -Value $newPath
                }
            }
        }
    }
}

Write-Host "llvm-mingw has been installed!"