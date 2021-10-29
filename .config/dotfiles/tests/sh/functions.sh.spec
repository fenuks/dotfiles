# vim: ft=sh

Describe 'functions.sh'
  Include ~/.config/shells/functions.sh
  Describe 'absolute_cmd function'
    It 'adds absolute path to vim'
      When call absolute_cmd 'vim functions.sh.spec'
      The output should eq "vim $(realpath functions.sh.spec)"
    End
    It 'ignores non-existing files vim'
      When call absolute_cmd 'vim functions.sh.spec-404'
      The output should eq "vim functions.sh.spec-404"
    End
    It 'adds absolute path to vim'
      When call absolute_cmd 'vim functions.sh.spec'
      The output should eq "vim $(realpath functions.sh.spec)"
    End
    It 'adds absolute path to n'
      When call absolute_cmd 'n functions.sh.spec'
      The output should eq "n $(realpath functions.sh.spec)"
    End
    It 'adds absolute path to v'
      When call absolute_cmd 'v functions.sh.spec'
      The output should eq "v $(realpath functions.sh.spec)"
    End
    It "doesn't add if file is local"
      When call absolute_cmd 'v ./functions.sh.spec'
      The output should eq "v ./functions.sh.spec"
    End
    It "doesn't revole parent pathts"
      When call absolute_cmd 'v ../sh/functions.sh.spec'
      The output should eq "v $(realpath functions.sh.spec)"
    End
    It "handles double quotes well"
      When call absolute_cmd 'v "functions.sh.spec"'
      The output should eq "v $(realpath functions.sh.spec)"
    End
    It "handles single quotes well"
      When call absolute_cmd "v 'functions.sh.spec'"
      The output should eq "v $(realpath functions.sh.spec)"
    End
    It "handles ~ well"
    When call absolute_cmd "v ~/.config/dotfiles/tests/sh/functions.sh.spec"
      The output should eq "v ~/.config/dotfiles/tests/sh/functions.sh.spec"
    End
    It "handles multiline single qouted strings"
      When call absolute_cmd "v '../data/plik testowy'"
      The output should eq "v '$(realpath '../data/plik testowy')'"
    End
    It "handles multiline double qouted strings"
      When call absolute_cmd 'v "../data/plik testowy"'
      The output should eq "v '$(realpath '../data/plik testowy')'"
    End
    It "handles escaped strings"
      When call absolute_cmd 'v ../data/plik\ testowy'
      The output should eq "v '$(realpath '../data/plik testowy')'"
    End
    It "ignores non-existing escaped strings"
      When call absolute_cmd 'v a\ file'
      The output should eq "v a\ file"
    End
  End
End
