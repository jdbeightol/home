fish_add_path -ga ~/.local/bin

if test -d ~/.config/emacs/bin
    fish_add_path -gpP ~/.config/emacs/bin
end

abbr -a vi vim

command -v zoxide &> /dev/null && zoxide init fish | source
command -v starship &> /dev/null && starship init fish | source
command -v pyenv &> /dev/null && pyenv init - fish | source
