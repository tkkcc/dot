function vs
    cd (dirname $S/$argv[1])
    v (basename $S/$argv[1])
    cd -
end
complete -c vs -xa '(command ls $S)'
