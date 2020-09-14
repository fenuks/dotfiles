" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn keyword ovpnOption local nextgroup=ovpnHostEnd skipwhite
syn match ovpnOption '\<remote\>' skipwhite nextgroup=ovpnHostAndPort skipwhite
syn match ovpnOption '\<remote-random\>' skipwhite nextgroup=ovpnError
syn match ovpnOption '\<remote-random-hostname\>' skipwhite nextgroup=ovpnError
syn keyword ovpnOption mode nextgroup=ovpnError,ovpnMode skipwhite
syn match ovpnOption '\<proto\>' skipwhite nextgroup=ovpnError,ovpnProtoPeer
syn match ovpnOption '\<proto-force\>' skipwhite nextgroup=ovpnError,ovpnProto
syn match ovpnOption '\<connect-retry\>' skipwhite nextgroup=ovpnError,ovpnTwoNumbers
syn match ovpnOption '\<connect-retry-max\>' skipwhite nextgroup=ovpnError,ovpnNumber
syn match ovpnOption '\<http-proxy\>' skipwhite nextgroup=ovpnError,ovpnNumber " TODO
syn match ovpnOption '\<cocks-proxy\>' skipwhite nextgroup=ovpnError,ovpnNumber " TODO
syn match ovpnOption '\<socks-proxy-retry\>' skipwhite nextgroup=ovpnError
syn match ovpnOption '\<resolv-retry\>' skipwhite nextgroup=ovpnError,ovpnNumber
syn match ovpnOption '\<float\>' skipwhite nextgroup=ovpnError
syn match ovpnOption '\<ipchange\>' skipwhite nextgroup=ovpnString
syn match ovpnOption '\<port\>' skipwhite nextgroup=ovpnError,ovpnPort
syn match ovpnOption '\<lport\>' skipwhite nextgroup=ovpnError,ovpnPort
syn match ovpnOption '\<rport\>' skipwhite nextgroup=ovpnError,ovpnPort
syn match ovpnOption '\<bind\>' skipwhite nextgroup=ovpnError
syn match ovpnOption '\<nobind\>' skipwhite nextgroup=ovpnError
syn match ovpnOption '\<dev\>' skipwhite nextgroup=ovpnLabel
syn match ovpnOption '\<dev-type\>' skipwhite nextgroup=ovpnError,ovpnTun

syn match ovpnComment "^\s*[#;].*" contains=@Spell

syn match ovpnTun		" \(tun\|tap\)" contained skipwhite nextgroup=ovpnError
syn keyword ovpnMode		p2p server contained nextgroup=ovpnError skipwhite
syn match ovpnProtoPeer		" \<udp\>" skipwhite contained nextgroup=ovpnError
syn match ovpnProtoPeer		" \<tcp-client\>" skipwhite contained nextgroup=ovpnError
syn match ovpnProtoPeer		" \<tcp-server\>" skipwhite contained nextgroup=ovpnError
syn match ovpnProto		" \<udp6\>" skipwhite contained nextgroup=ovpnError
syn match ovpnProto		" \<tcp6-server\>" skipwhite contained nextgroup=ovpnError
syn match ovpnProto		" \<tcp6-client\>" skipwhite contained nextgroup=ovpnError
syn match ovpnNumber		" \<[0-9.]\+\>" contained skipwhite nextgroup=ovpnError
syn match ovpnNumber		" \<infinite\>" contained skipwhite nextgroup=ovpnError
syn match ovpnTwoNumbers	" \<[0-9.]\+\>" contained skipwhite nextgroup=ovpnError,ovpnNumber
syn match ovpnPort		" \<[0-9.]\+\>" contained nextgroup=ovpnError skipwhite
syn match ovpnHost		"[^ ]\+" contained
syn match ovpnHostEnd		"[^ ]\+" contained nextgroup=ovpnError skipwhite
syn match ovpnHostAndPort	"[^ ]\+" contained nextgroup=ovpnError,ovpnPort skipwhite
syn match ovpnError		"[^ ]\+" contained skipwhite nextgroup=ovpnError
syn match ovpnString		".\+" contained
syn match ovpnLabel		"[^ ]\+" contained skipwhite nextgroup=ovpnError

hi def link ovpnOption	Keyword
hi def link ovpnComment	Comment
hi def link ovpnNumber	Number
hi def link ovpnTwoNumbers	Number
hi def link ovpnPort	Number
hi def link ovpnTun	String
hi def link ovpnString	String
hi def link ovpnLabel	String
hi def link ovpnProtoPeer	String
hi def link ovpnError	Error
hi def link ovpnHost	String
hi def link ovpnHostEnd	String
hi def link ovpnHostAndPort	String
hi def link ovpnMode	String
hi def link ovpnProto	String

let b:current_syntax = "openvpn"

let &cpo = s:cpo_save
unlet s:cpo_save
