## Links

* [Change Registry Value Common](https://stackoverflow.com/a/864073/2523401)
* [C++ Change Registry Value](https://cplusplus.com/forum/general/50264/)
* [Use Modern C++ to Access the Windows Registry](https://learn.microsoft.com/en-us/archive/msdn-magazine/2017/may/c-use-modern-c-to-access-the-windows-registry)
* [How to set a Windows registry value with PowerShell](https://www.advancedinstaller.com/set-windows-registry-value-with-powershell.html)
* [Powershell](https://habr.com/ru/companies/ruvds/articles/487876/)
* [Powershell Script Signing](https://habr.com/ru/articles/137884/)
* [MS PS self signing](https://learn.microsoft.com/ru-ru/powershell/module/microsoft.powershell.core/about/about_signing?view=powershell-5.1)

## Powershell Script Signing

```powershell
Get-ExecutionPolicy
#Set-ExecutionPolicy RemoteSigned
Set-ExecutionPolicy AllSigned
$params = @{
    Subject = 'CN=PowerShell Code Signing Cert'
    Type = 'CodeSigning'
    CertStoreLocation = 'Cert:\CurrentUser\My'
    HashAlgorithm = 'sha256'
}
$cert = New-SelfSignedCertificate @params
Get-Childitem cert:\CurrentUser\My -codesigning
Set-AuthenticodeSignature "FileName" @(Get-ChildItem cert:\CurrentUser\My -codesigning)[0]
```

## Where placed

* `C:\Users\%UserName%\Documents\WindowsPowerShell\Modules`
* `C:\Program Files\WindowsPowerShell\Modules`
* `C:\Windows\System32\WindowsPowerShell\v1.0\Modules`
