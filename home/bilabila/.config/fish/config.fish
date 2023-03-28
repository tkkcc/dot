if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1 -o \
            -n "$FISH_XSESSION" -a "$XDG_VTNR" = 7
        set -e FISH_XSESSION

        begin
            stty -ixon -ixoff
            touch $C/chrome-flags.conf
            mou /dev/nvme0n1p2 /F: ntfs 2>&1 &
            audio i 2>&1 &
            battery 2>&1 &
            keeping 2>&1 &
            ari 2>&1 &
            qqnotify 2>&1 &
            sudo kbdrate -s -d 250 -r 30 &
            sudo loadkeys $C/kbd/k.map &
            sudo swapon /swapfile 2>&1 &
            v2r 2>&1 &
            u2r 2>&1 &
            #no fish -c 'while true;ssh za1;sleep 1;end' &
            /usr/bin/sshd -f $H/.ssh/sshd_config &
#             /usr/bin/systemd-run --scope --user tmux new -s0 -ns -d 2>&1 &
            fish -c "sleep 8;sab bj u" 2>&1 &
            pulseaudio -k 2>&1 &
#             fcitx-status 2>&1 &
        end >/dev/null
        
        test "$XDG_VTNR" = 7; and exec nvx i >/dev/null 2>&1
        nvx i >/dev/null 2>&1 &
    end
end
zoxide init --hook pwd --cmd j fish | source
