env::require linux

function hop
    ssh mikatu@callisto.jupiter.sol $argv
end

starship init fish | source
