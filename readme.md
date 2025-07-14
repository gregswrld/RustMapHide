# Rust Map Hide OBS Script.

## Description
Simple OBS Lua script to show a “map cover” image when you hold a hotkey and hide it when you release.
Press G to instantly hide your map—whether you’re running, crouching, or standing still.

## Features
- Hold **G** or **Shift+G** to toggle your map overlay
- Enter any image source name in the script properties (Ensure this matches the exact name of your image source in the OBS scene.)

## Requirements
- OBS Studio 26 or newer
- Windows, macOS or Linux

## Installation
1. Download `Rust-Map-Hide.lua`.  
2. In OBS go to **Tools → Scripts → +** and select `map_cover.lua`.
     Or Manually Put The File In The OBS Scripts folder Via  
       - **Windows**: `%appdata%\obs-studio\basic\scripts\`  
       - **macOS**: `~/Library/Application Support/obs-studio/basic/scripts/`  
       - **Linux**: `~/.config/obs-studio/basic/scripts/`  

## Configuration
1. Open the script in **Tools → Scripts**.  
2. In **Image Source Name**, enter the exact name of your map image source.  
4. Open OBS **Settings → Hotkeys**, find **Show Map Cover (Hold G)** and **Show Map Cover (Hold Shift+G)**, then assign to the keys.

Make sure your map source is **hidden by default** in your scene.

## Usage
- **Hold G** → map overlay appears  
- **Release G** → map overlay hides  
- **Hold Shift+G** → map overlay appears  
- **Release Shift+G** → map overlay hides  

## Contributing
Pull requests and issue reports are welcome.  

## License
This project is released under the MIT License.  
