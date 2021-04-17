function assignProxy
    set -l proxy http_proxy ftp_proxy https_proxy all_proxy
    for p in $proxy
        set $argv[2..-1] $p $argv[1]
        set $argv[2..-1] (string upper $p) $argv[1]
    end
end
