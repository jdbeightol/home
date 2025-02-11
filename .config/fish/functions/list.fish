function list
    dig @10.12.13.2 pluto.sol axfr |
        grep -E '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' |
        grep -v ';' | sed -e 's/\(^[0-9A-Za-z.\-]*\.pluto\.sol\)\..*$/\1/' |
        sort |
        uniq
end
