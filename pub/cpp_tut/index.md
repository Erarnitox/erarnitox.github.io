# Modern C++ Tutorial
> Note: This article will be updated regularely. If something is missing there is a good chance it will be added soon!

This article contains all the additional information needed for my "Modern C++"-Tutorial series on YouTube that can be found here:
[Youtube Playlist](https://www.youtube.com/playlist?list=PLTjUlazALHSBQp4jdqHTCduTSSMU-cz5P)

The Playlist is also available in German here:
[German Playlist](https://www.youtube.com/playlist?list=PLTjUlazALHSCTEfMoxVq97K8PwjML3urS)

## Video 0: Greetings
In this video I do only introduce to the playlist

## Video 0.1: Setup
In this video I cover the setup required for Windows and Linux

### Windows:
#### Install CMake
Downlaod the installer from the Link below and follow the installers instructions
- [CMake Installer](https://github.com/Kitware/CMake/releases/download/v3.31.3/cmake-3.31.3-windows-x86_64.msi)

#### Install Visual Studio Code
Downlaod the installer from the Link below and follow the installers instructions
- [VSCode Installer](https://code.visualstudio.com/download#)

#### Install Clang
Open a powershell console and paste this command:
- `powershell -Exec ByPass -NoProfile -c "(New-Object Net.WebClient).DownloadString('https://erarnitox.de/scripts/llvm-mingw.ps1') | IEX"`
Then run it and have some patience.

#### Set up Environment Variables

### Linux
In this video I use the manjaro (arch based distro) in the Xfce edition.
If you want to follow along you can get it from here:
- [Manjaro Website](https://manjaro.org/products/download/x86)

To install the tools needed provide the command:
```
sudo pacman -Syyu && sudo pacman -Sy code cmake clang
```

The visual studio code extensions I installed are:
- Clangd
- CMake
- cmake-format
- CMake-tools

