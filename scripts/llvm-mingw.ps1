$releaseList = Invoke-WebRequest -Uri "https://api.github.com/repos/mstorsjo/llvm-mingw/releases" | ConvertFrom-Json

If (!(test-path "$HOME\.utils"))
{
    md "$HOME\.utils"
}

$nameList = @()

Foreach ($release in $releaseList)
{
    $nameList += $release.tag_name
}
$userVersion = $nameList[0]

Write-Host "Please wait..."

Foreach ($release in $releaseList)
{
    Foreach ($entry in $release.assets)
    {
        if ($entry.browser_download_url.Contains("llvm-mingw-" + $userVersion + "-ucrt-x86_64"))
        {
            Write-Host $entry.browser_download_url
            if (!$entry.browser_download_url.Contains("sig"))
            {
                Start-BitsTransfer -Source $entry.browser_download_url -Destination "$HOME/.utils/llvm-mingw.zip"
				Expand-Archive -LiteralPath "$HOME/.utils/llvm-mingw.zip" -DestinationPath "$HOME/.utils/" -Force
                $initPath = "$HOME/.utils/llvm-mingw-" + $userVersion + "-ucrt-x86_64"
                Rename-Item -Path $initPath -NewName "$HOME/.utils/llvm-mingw"
				$old = (Get-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment" -Name path).path
				$new  =  "$old;$HOME\.utils\llvm-mingw\bin" 
				if (!$old.Contains(".utils\llvm-mingw\bin"))
				{
					Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment" -Name path -Value $new
				}
			}
        }
    }
}

Write-Host "llvm-mingw has been installed!"
