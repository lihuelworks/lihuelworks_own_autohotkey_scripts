## SPEAKER-TO-HYPER_SPEAKER_ORBACK

# Check if BurntToast module is installed
if (-not (Get-Module -Name BurntToast -ListAvailable)) {
    [System.Windows.Forms.MessageBox]::Show(
        "Error: BurntToast module is not installed.`r`nPlease follow the instructions in the README to install BurntToast.`r`nREADME: https://github.com/lihuelworks/lihuelworks_own_autohotkey_scripts",
        "Module Not Installed",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error
    )
    Start-Process "https://github.com/lihuelworks/lihuelworks_own_autohotkey_scripts#pre-install-for-cycle-audio-deviceahk1"
    exit
}

# Check if AudioDeviceCmdlets module is installed
if (-not (Get-Module -Name AudioDeviceCmdlets -ListAvailable)) {
    [System.Windows.Forms.MessageBox]::Show(
        "Error: AudioDeviceCmdlets module is not installed.`r`nPlease follow the instructions in the README to install AudioDeviceCmdlets.`r`nREADME: https://github.com/lihuelworks/lihuelworks_own_autohotkey_scripts",
        "Module Not Installed",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error
    )
    Start-Process "https://github.com/lihuelworks/lihuelworks_own_autohotkey_scripts#pre-install-for-cycle-audio-deviceahk1"
    exit
}

# Import the BurntToast module
Import-Module -Name BurntToast -Force
Import-Module -Name AudioDeviceCmdlets -Force

# Function to set the default playback device
function Set-DefaultPlaybackDevice {
    param (
        [int]$index
    )

    # Set the default playback device using the specified index
    Set-AudioDevice -Index $index
}

# Run the Get-AudioDevice -List command and capture the output
$audioDevices = Get-AudioDevice -List

# Initialize an empty array to store tuples for playback devices only
$playbackDeviceTuples = @()

# Iterate through each audio device and create a tuple for playback devices
foreach ($device in $audioDevices) {
    if ($device.Type -eq 'Playback') {
        $deviceTuple = [ordered]@{
            'Index'                = $device.Index
            'Default'              = $device.Default
            'DefaultCommunication' = $device.DefaultCommunication
            'Type'                 = $device.Type
            'Name'                 = $device.Name
            'ID'                   = $device.ID
            'Device'               = $device.Device.GetType().FullName
        }

        # Add the tuple to the array
        $playbackDeviceTuples += $deviceTuple
    }
}

# Output the array of playback device tuples
$playbackDeviceTuples

# Find the index of the current default playback device
$currentPlaybackIndex = ($playbackDeviceTuples | Where-Object { $_.Default -eq $true }).Index

# Calculate the next playback index (looping if necessary)
$nextPlaybackIndex = if ($currentPlaybackIndex -eq $playbackDeviceTuples.Count) { 1 } else { $currentPlaybackIndex + 1 }

# Set the next playback device as the default
Set-DefaultPlaybackDevice -index $nextPlaybackIndex

# Display a toast notification
$deviceName = $playbackDeviceTuples[$nextPlaybackIndex - 1].Name
$notificationMessage = "Changed to audio device -> $deviceName"
New-BurntToastNotification -Text $notificationMessage
