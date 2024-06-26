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

fish_add_path -gp /usr/local/sbin

# Something between fish, homebrew, and macOS changed that caused system PATHs
# to move before the homebrew paths, which notoriously resulted in commands
# like python3 and git to use the macOS builtin binaries.  By calling
# fish_add_path ourselves with the --prepend flag and omitting the --path flag
# for the homebrew paths, we can guarantee that our system continues to operate
# the same as before whatevere change occurred.
/opt/homebrew/bin/brew shellenv | source
fish_add_path -gp "/opt/homebrew/bin" "/opt/homebrew/sbin"

zoxide init fish | source
starship init fish | source

abbr -a lsblk diskutil list
