THEMIS := themis/bin/themis

test: $(THEMIS)
	$^ --runtimepath themis --exclude themis -r .

$(THEMIS):
	git clone --depth 1 https://github.com/thinca/vim-themis themis
