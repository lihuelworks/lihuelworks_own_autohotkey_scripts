# Lihuelworks own Autohotkey scripts 🚀

## Notes
- All scripts are made for AUTOHOTKEY 1 (currently deprecated, but still useful!)
- If you haven't configured Powershell to accept running scripts, be sure to update Powershell to accept them by pasting `Set-ExecutionPolicy Unrestricted` in a Powershell console
- Repo comes with a script "ahk_killall.bat". In case any script gives you trouble, you can press the .bat script to stop all Autohotkey processes (It basically has 2 "taskkill" for the default name for x64 Autohotkey processes)
- All scripts are written with Windows 10 in mind. This sholudn't give you any trouble, since Windows basics don't change from version to version (but who knows ¯\_(ツ)_/¯)
- Most of the files here are written for Autohotkey 1, which shouldn't give you any trouble if you install authotkey normally. Be sure to not rename the file endings to `.ahk` or it will prompt you to choose between Autohotkey 1 and 2 (The scripts don't work for Autohotkey 2, since it has different syntax)

### terminal.ahk
- `Ctrl` + `Alt` + `T` 👉🏻 Opens Windows Terminal on the default profile, with the same combination you would use to open one in Linux.
    - You can change the type of terminal by changing the executable (currently ”wt.exe”) to any other, like Powershell, CMD or Git Bash.

### resize_window.ahk
- `Ctrl` + `Alt` + `Left Click` 👉🏻 Click any window with that combination to move it, without having to click the windows' title
- `Ctrl` + `Alt` + `Rigth Click` 👉🏻 Click any window with that combination to Click any window with that combination to move it, without having to click the windows' title it, without having to click the windows' title
    - Script depends on `windrag.ahk` (Which comes packaged with the repo, asegurate que esten en la misma carpeta)

### f1_volume_mixer
- `F1` 👉🏻 Overwrites default F1 behaviour (most of the time, opening a help window) and uses it for something useful instead: Opening Windows Volume mixer (this 👇🏻)

    ![Untitled](https://imgur.com/m6tKFYO.png)

- You can also close it by pressing Esc when the mixer is open (apart from just pressin it's X button)

### explorer_open_terminal_here.ahk1

- `F12` 👉🏻 With Windows Explorer open, you can open a Windows Terminal window on the current folder path (of the current focused Windows Explorer window)
    - If no Windows Explorer window is focused...nothing happens.
    - Also, you may change the terminal from Windows Terminal to anything elseby changing the `Run "wt.exe" -d "%_Path%"` command to any other terminal path (using the correct directory flag instead of "-d")

### cycle-audio-device.ahk1

- `Ctrl`+`Alt`+`Esc` 👉🏻 Cycles between plugged audio devices (e.g. Headphones, Speakers, etc)
    - This scripts depends on other script I've wrote: `cycle-audio-device-script.ps1`, which comes packaged with this repo, and it's called by the ahk script.
    - It also depends on Powershell package “BurnToast” (https://github.com/Windos/BurntToast) to send Windows Notifications. If you haven't installed it (which is likely if you don't fiddle with Powershell scripts) it gets automatically installed (If it doesn't, try calling the script with Admin rights)
    
    ![Untitled](https://imgur.com/iQNqvle.png)

                
    - ❗ Sadly, BurntToast doesn't allow to reduce the fade time of notification (which is 5 seconds) so if the hotkey is pressed multiple times, multiple 5 second notifications will be spawn. This can be fixed my closing the notifications (by clicking them or pressing their close buttons). Despite that, the device change is instantaneous.

### move_window_to_virtual_desktop.ahk1
- `Ctrl`+`Windows`+`Left Key` (left virtual desktop) // `Ctrl`+`Windows`+`Right Key` (Right virtual desktop)
    - If you have more than one [virtual desktop](https://www.howtogeek.com/197625/how-to-use-virtual-desktops-in-windows-10/), this script allows you to move a
        - It depends on VirtualDesktopAccessor by Ciantic (https://github.com/Ciantic/VirtualDesktopAccessor), and although the .dll is provided by the repo, I encourage you to install it by yourself (Released packed in repo is for release [2023-11-10-windows11](https://github.com/Ciantic/VirtualDesktopAccessor/releases/tag/2023-11-10-windows11))
        - For some reason, it doesn’t seem to work on terminal windows (Like Windows Terminal) for what I believe is administrative privileges. I haven’t been able to debug it yet.