# Create a function for requiring an environment file that can be used
# throughout environment files and interactively in the shell.
function env::require
    set -f filename $__fish_environments_dir/$argv[1].fish
    if test -f $filename
        source $filename
        set -ag __fish_profile_stack $argv[1]
        return 0
    end
    return 1
end

# Set the environments directory.
set -g __fish_environments_dir $__fish_config_dir/environments

# Always require base environment.
env::require base

# Try to load a custom environment.  First by checking if __fish_environment is
# set and using that.  If that is unset or doesn't exist, then check if an
# environment exists for the machine's hostname and load that.  If that doesn't
# exist, try to load an environment for the operating system.
if not set -q __fish_environment || not env::require $__fish_environment
    set -f shell_hostname (echo $hostname)
    if command -v hostname &>/dev/null
        set -f shell_hostname (hostname -s)
    else if command -v hostnamectl &>/dev/null
        set -f shell_hostname (hostnamectl hostname)
    end
    if not env::require (echo $shell_hostname | string lower)
        env::require (uname | string lower)
    end
end

# Set the shell greeting to the current hierarchy.
set fish_greeting "$(set_color -oi white)Configuration hierarchy: $(set_color -oi cyan)config" "$(set_color -oi brown)> $(set_color -oi cyan)"{$__fish_profile_stack}(set_color normal)

if status is-interactive
    # Commands to run in interactive sessions can go here
end
