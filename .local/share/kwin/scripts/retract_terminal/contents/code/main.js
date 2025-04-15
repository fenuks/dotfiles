// const terminal = 'kitty';
const terminal = 'org.wezfurlong.wezterm';

function retractTerminal() {
    var clients = workspace.windowList();
    for (var i=0; i<clients.length; i++) {
        var client = clients[i];
        if (client.resourceClass == terminal) {
            if (client.active) {
                client.minimized = true;
            } else {
                if (client.active == false) {
                    workspace.activeWindow = client;
                } else {
                    workspace.activeWindow = client;
                }
            }
        }
    }
}
registerShortcut("Przełącz terminal", "Przełącza terminal, tak jak yakuake.", "F11", retractTerminal);
