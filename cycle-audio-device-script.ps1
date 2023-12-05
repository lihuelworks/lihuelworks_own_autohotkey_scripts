## SPEAKER-TO-HYPER_SPEAKER_ORBACK

# 🔗 AudioDeviceCmdlets 👉🏽 https://github.com/frgnca/AudioDeviceCmdlets

# Load the AudioDeviceCmdlets.dll from the same folder as the script
$scriptPath = $PSScriptRoot
$audioDeviceCmdletsPath = Join-Path $scriptPath 'AudioDeviceCmdlets.dll'
Import-Module -LiteralPath $audioDeviceCmdletsPath

# Check if BurntToast module is installed, if not, install it
if (-not (Get-Module -Name BurntToast -ListAvailable)) {
    Install-Module -Name BurntToast -Force -AllowClobber
}

# Import the BurntToast module
Import-Module -Name BurntToast -Force

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
$notificationMessage = "🔉Changed to audio device 👉🏻 $deviceName"
New-BurntToastNotification -Text $notificationMessage
