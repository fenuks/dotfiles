function retractTerminal() {
    var clients = workspace.clientList(); 
    for (var i=0; i<clients.length; i++) {
        var client = clients[i];
        if (client.resourceClass == 'kitty') {
            if (client.active) {
                client.minimized = true;
            } else {
                if (client.active == false) {
                    workspace.activeClient = client;
                } else {
                    workspace.activeClient = client;
                }
            }
        }
    }
}
registerShortcut("Terminal rectract", "Retracts terminal, just like yakuake.", "F11", retractTerminal);
