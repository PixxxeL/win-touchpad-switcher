param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

'running with full privileges'


$RegistryPath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PrecisionTouchPad\Status'
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
