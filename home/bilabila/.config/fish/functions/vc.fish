function vc
    cd (dirname $C/$argv[1])
    v (basename $C/$argv[1])
    cd -
end
function __vc_complete
    set -l token (commandline -ct)
    set -l result (__fish_complete_path $C/$token|string replace $C/ "")
    printf '%s\n' $result
end
complete -c vc -xa '(__vc_complete)'
