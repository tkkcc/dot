# Rename this file to match the name of the function
# e.g. ~/.config/fish/functions/n.fish
# or, add the lines to the 'config.fish' file.

function n --wraps nnn --description 'support nnn quit and change directory'
    # Block nesting of nnn in subshells
    if test -n "$NNNLVL"
        if [ (expr $NNNLVL + 0) -ge 1 ]
            exit
            echo "nnn is already running"
            return
        end
    end

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "-x" as in:
    #    set NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    if test -n "$XDG_CONFIG_HOME"
        set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
    else
        set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
    end

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef
    set -gx NNN_SEL (mktemp)
    set -gx NNN_TRASH 1
    set -gx NNN_ARCHIVE "\\.(7z|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)"
    set -gx NNN_BMS "g:/G;D:~/code/data;o:~/code/data/obs;a:$A;b:$B;c:$C;C:$H/code;d:$D;e:$E;f:/F;G:/F/ghost;l:$H/code/q1root/F;k:$H;h:$H;s:$S;t:$A/Trash/files;y:/F/.Trash-1000/files;z:/F/software/video;p:/F/software/pic;1:$H/code/flow_slomo;2:$H/code/flow_slomo/data;3:$H/code/chenyuflow"
    set -gx NNN_PLUG 'v:vn;x:rm;r:rg;y:yank;m:mtpmount;j:autojump;g:dragdrop;b:mmv;l:link;n:ncdu;f:fzcd;s:refresh;1:mpd'
    set -gx NNN_FCOLORS 020304050607050301040401
    set -gx NNN_OPTS 'aA'

    nnn $argv
    # rm $NNN_SEL
    if test -e $NNN_TMPFILE
        source $NNN_TMPFILE
        rm $NNN_TMPFILE
    end
end
