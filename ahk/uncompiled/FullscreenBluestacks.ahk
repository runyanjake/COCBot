sleep 250

BlueStacksWindowName := "BlueStacks"

if WinExist(BlueStacksWindowName) {
    WinActivate
    sleep 500
    send {f11}
}

sleep 1000