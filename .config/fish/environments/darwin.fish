# fish configuration specific to macOS

function dnsflush
    sudo killall -HUP mDNSResponder
end

function yoink
    open -a Yoink $argv
end

function pb
    pinboard $argv
end

fish_add_path -gpP /usr/local/sbin

# Something between fish, homebrew, and macOS changed that caused system PATHs
# to move before the homebrew paths, which notoriously resulted in commands
# like python3 and git to use the macOS builtin binaries.  By calling
# fish_add_path ourselves with the --prepend flag and omitting the --path flag
# for the homebrew paths, we can guarantee that our system continues to operate
# the same as before whatevere change occurred.
command -v /opt/homebrew/bin/brew &> /dev/null && /opt/homebrew/bin/brew shellenv | source
command -v zoxide &> /dev/null && zoxide init fish | source
command -v starship &> /dev/null && starship init fish | source
command -v pyenv &> /dev/null && pyenv init - | source

abbr -a lsblk diskutil list
