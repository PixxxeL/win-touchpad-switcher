#include <windows.h>
#include <iostream>

// Для сборки и отладки необходимо в настройках проекта поменять
// для всех конфигураций Компоновщик -> Файл манифеста:
// * Включить контроль учетных записей пользователей UAC - Нет
// * Уровень выполнения UAC - requireAdministrator
// * Обход защиты пользовательского интерфейса UAC - Да
int main()
{
    HKEY hKey;
    LPCWSTR keyPath = L"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\PrecisionTouchPad\\Status";
    LPCWSTR valueName = L"Enabled";
    DWORD dataType;
    DWORD dataValue;
    DWORD dataSize = sizeof(dataValue);
    // https://learn.microsoft.com/en-us/windows/win32/api/winreg/nf-winreg-regopenkeyexw
    LONG res = RegOpenKeyExW(HKEY_CURRENT_USER, keyPath, 0, KEY_ALL_ACCESS, &hKey);
    if (ERROR_SUCCESS == res) {
        std::cout << "Successed open key..." << std::endl;
        // https://learn.microsoft.com/en-us/windows/win32/api/winreg/nf-winreg-reggetvaluew
        res = RegGetValueW(hKey, NULL, valueName, RRF_RT_REG_DWORD, &dataType, &dataValue, &dataSize);
        if (ERROR_SUCCESS == res) {
            std::cout << "Successed read value: " << dataValue << " ..." << std::endl;
            dataValue = 1 - dataValue;
            // https://learn.microsoft.com/en-us/windows/win32/api/winreg/nf-winreg-regsetkeyvaluew
            res = RegSetKeyValueW(hKey, NULL, valueName, dataType, &dataValue, dataSize);
            if (ERROR_SUCCESS == res) {
                std::cout << "Successed write value: " << dataValue << " ..." << std::endl;
            }
            else {
                std::cout << "Fail write value: " << res << std::endl;
            }
        }
        else {
            std::cout << "Fail read value: " << res << std::endl;
        }
    }
    else {
        std::cout << "Fail open key" << std::endl;
    }
    RegCloseKey(hKey);
}
