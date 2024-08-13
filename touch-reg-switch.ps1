$RegistryPath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PrecisionTouchPad\Status’
$Name = 'Enabled'
$Value = '0'

# Create the key if it does not exist
#If (-NOT (Test-Path $RegistryPath)) {
#    New-Item -Path $RegistryPath -Force | Out-Null
#}  
# Now set the value
#New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force

if (Test-Path $RegistryPath) {
    $Result = Get-ItemProperty -Path $RegistryPath -Name $Name
    $Value = 1
    if ($Result.Enabled -eq 1) {
        $Value = 0
    }
    echo "Touchpad set to $Value"
    New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force
}
