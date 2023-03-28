function sudoToggle
    set l (commandline)
    set p (commandline -C)
    test -z "$l"; and set l $history[1]
    set se '^(\s*sudo\s+-E\s+)(.*)'
    set s '^(\s*sudo\s+)(.*)'
    if string match -qr $se "$l"
        set c (string length (string replace -r $se '$1' "$l"))
        set l (string replace -r $se '$2' "$l")
        set p (math $p-$c+5)
        test $p -lt 0; and set p 0
    else if string match -qr $s "$l"
        set c (string length (string replace -r $s '$1' "$l"))
        set l (string replace -r $s 'sudo -E $2' "$l")
        set p (math $p+3)
        test $p -lt 0; and set p 0
    else
        set l "sudo "$l""
        set p (math $p+8)
    end
    commandline "$l"
    commandline -C $p
end
