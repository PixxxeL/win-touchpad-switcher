#include <windows.h>

void SendKey(WORD key, bool keyDown) {
    INPUT input = { 0 };
    input.type = INPUT_KEYBOARD;
    input.ki.dwFlags = keyDown ? 0 : KEYEVENTF_KEYUP;
    input.ki.wVk = key;
    SendInput(1, &input, sizeof(INPUT));
}

int main() {
    SendKey(VK_CONTROL, true);
    SendKey(VK_LWIN, true); //VK_RWIN
    SendKey(VK_F24, true);
    SendKey(VK_F24, false);
    SendKey(VK_LWIN, false);
    SendKey(VK_CONTROL, false);
    return 0;
}
