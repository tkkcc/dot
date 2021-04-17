function r
	if test -z $RANGER_LEVEL
        ranger $argv
    else
        echo (pwd) > $E/rangerdir
        exit
    end
end
