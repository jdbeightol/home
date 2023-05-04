#!/usr/bin/env fish

function env::require
    set -f filename $__fish_environment_dir/$argv[1].fish
    if test -f $filename
        source $filename
        set -ag __fish_profile_stack $argv[1]
        return 0
    end
    return 1
end

set -g __fish_environment_dir $__fish_config_dir/environments

if not set -q __fish_environment || not env::require $__fish_environment
    if not env::require (hostname -s | string lower)
        env::require (uname | string lower)
    end
end

set fish_greeting "$(set_color -oi white)Configuration hierarchy: $(set_color -oi cyan)config" "$(set_color -oi brown)> $(set_color -oi cyan)"{$__fish_profile_stack}(set_color normal)
