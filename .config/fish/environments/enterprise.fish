env::require home
env::require android

function prompt_login
    echo -n -s (set_color $fish_color_user) data (set_color normal) @ (set_color $color_host) enterprise (set_color normal)
end
