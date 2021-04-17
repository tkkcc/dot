function cbcg
    clp
    set -l a (curl ipaddr.site)
    asp
    set -l b (curl ipaddr.site)
    notify-send $a\n$b
end
