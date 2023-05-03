#!/usr/bin/env fish

function env::require
    source $__fish_environment_dir/$argv[1].fish
end

set -g __fish_environment_dir $__fish_config_dir/environments

if set -q __fish_environment
    echo "using environment: $__fish_environment"
    env::require $__fish_environment
end
