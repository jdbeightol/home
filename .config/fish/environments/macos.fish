# fish configuration specific to macOS

function lsblk
    diskutil list
end

function dnsflush
    sudo killall -HUP mDNSResponder
end

function yoink
    open -a Yoink $argv
end

function du
    du -d 1 -c -h -x $argv
end

fish_add_path -p /usr/local/sbin 
fish_add_path -a ~/.local/cargo/bin

set -x JAVA_HOME (/usr/libexec/java_home)

/opt/homebrew/bin/brew shellenv | source
zoxide init fish | source
