fish_add_path -ga ~/.local/bin

if test -d ~/.config/emacs/bin
    fish_add_path -gpP ~/.config/emacs/bin
end

abbr -a vi vim
