# fish configuration specific to macOS

function dnsflush
    sudo killall -HUP mDNSResponder
end

function yoink
    open -a Yoink $argv
end

function du
    du -d 1 -c -h -x $argv
end

function pb
    pinboard $argv
end

fish_add_path -gp /usr/local/sbin
fish_add_path -ga ~/.local/cargo/bin

/opt/homebrew/bin/brew shellenv | source
zoxide init fish | source
starship init fish | source

abbr -a lsblk diskutil list
