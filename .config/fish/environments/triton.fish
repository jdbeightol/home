env::require darwin
env::require work

function prompt_login
    echo -n -s (set_color $fish_color_user) "$USER" (set_color normal) @ (set_color $color_host) Triton (set_color normal)
end
