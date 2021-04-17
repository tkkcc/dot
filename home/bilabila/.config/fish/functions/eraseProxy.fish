function eraseProxy
    set -l proxy http_proxy ftp_proxy https_proxy all_proxy
    for p in $proxy
        set -eUx $p
        set -eUx (string upper $p)
    end
end
