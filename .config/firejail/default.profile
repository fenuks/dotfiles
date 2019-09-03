whitelist ~/Sandbox/
noblacklist ~/Sandbox/
whitelist ~/Games/
noblacklist ~/Games/
whitelist ~/.wine*
noblacklist ~/.wine*
net none
noautopulse

include /etc/firejail/wine.profile

# include /etc/firejail/whitelist-common.inc
include /etc/firejail/default.profile

