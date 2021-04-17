# dot

a git wrapper to manager dotfiles, with solutions to

1. multi host
2. root folder, permission
3. public version

here is all code, note that **USER** need hard code

<!-- dot -->
```sh
#!/usr/bin/env bash
set -e
USER=bilabila
HOME=/home/$USER
DOT_DIR=$DOT_DIR/
EDITOR=${EDITOR:-nvim}
d=$HOME/.local/share/dot
g="git --git-dir=$d/git --work-tree=${DOT_DIR}"
clear(){
    if [[  -d "$d/git" ]];then
        read -rp "remove $d/git? [y/N]" t
        [[ ! "$t" ==  "y" ]] && return 1
        rm -Rf $d/git
    fi
    mkdir -p $d
}
init(){
    clear
    $g init
    $g config --local include.path ../filter
    $g config --local core.attributesFile $d/attribute
}
clone(){
    init
    $g remote add origin "$1"
    $g fetch origin
    $g reset origin/master
}
status(){
    $g -C / status -s -uno "$@"
}
list(){
    $g -C / ls-tree -r --name-only ${1-HEAD}|sed 's/^/\//'
}
commit(){
    $g commit -uno "$@"
}
chmow(){
    while read i;do
        [ ! -e "$i" ] && continue
        chown "$1":"$1" "$i"
        if [ -d "$i" ];then
            chmod "$2" "$i"
            echo "$1" "$2" "$i"
        else
            chmod "$3" "$i"
            echo "$1" "$3" "$i"
        fi
    done
}
perm(){
    echo "update permission"
    chown -R "$USER":"$USER" "$d"
    l=$(list)
    IFS=$'\n'
    for i in $l;do
        while [[ "$i" == "$HOME"* ]]; do
            echo "$i"
            i="$(dirname "$i")"
        done
    done|sort -u|chmow "$USER" 700 "og-rw,u+rw"
    for i in $l;do
        [[ "$i" == "$HOME"* ]] && continue
        while [[ "$i" != / ]]; do
            echo "$i"
            i="$(dirname "$i")"
        done
    done|sort -u|chmow root 755 "og-w,u+rw"
    unset IFS
}
rebasa(){
    export DOT_DIR=$(mktemp -dp $d)
    $0 reset --hard
    c=$($g rev-parse --abbrev-ref HEAD)
    for i in $($g branch|cut -c 3-); do
        r="$0 rebase --onto master master $i"
        echo "$r"
        $r
    done
    $0 checkout $c
}
edit(){
    [[ "$1" == -f ]] && exec $EDITOR $d/filter
    [[ "$1" == -a ]] && exec $EDITOR $d/attribute
    a=$(list|sed "s|^/|$DOT_DIR|"|fzf)
    [[ -n "$a" ]] && exec $EDITOR "$a"
}
declare -f -F -- "$1" > /dev/null || exec $g "$@"
"$@"

```

## tutorial

> These environment variables may appear
>
> ```sh
> A=/home/bilabila/.local/share
> B=/home/bilabila/bin
> C=/home/bilabila/.config
> H=/home/bilabila
> S=/home/bilabila/bin/scripts
> ```

There are three hosts: a laptop and desktop with root access, a server without root access

### laptop

On laptop, use master branch

1. `dot init` create a repository in `$HOME/.local/share/dot/git`
2. `dot add $C/i3/config $C/aria2` stage files
3. `dot status` show tracked files

   ```
   new file:   home/bilabila/.config/aria2/aria2.conf
   new file:   home/bilabila/.config/aria2/aria2.session
   new file:   home/bilabila/.config/i3/config
   ```

4. `dot rm --cached '*session'` unstage `aria2.session` for clean
5. `dot add -N $S; dot add -p $S` select, edit and stage `$S`
6. modify [example](#folder) to stage all, now `dot status` show

   ```
   new file:   etc/X11/xorg.conf.d/01-mouse.conf
   new file:   etc/default/tlp
   new file:   etc/grub.d/40_custom
   new file:   etc/hostname
   new file:   etc/hosts
   new file:   etc/intel-undervolt.conf
   new file:   etc/locale.conf
   new file:   etc/locale.gen
   new file:   etc/localtime
   new file:   etc/mkinitcpio.d/0.preset
   new file:   etc/mkinitcpio.d/linux.preset
   new file:   etc/modprobe.d/0.conf
   ...
   new file:   home/bilabila/.condarc
   new file:   home/bilabila/.config/BaiduPCS-Go/pcs_config.json
   new file:   home/bilabila/.config/Code Industry/Master PDF Editor 5.conf
   new file:   home/bilabila/.config/Dharkael/flameshot.ini
   new file:   home/bilabila/.config/Genymobile/Genymotion.conf
   new file:   home/bilabila/.config/Mousepad/accels.scm
   new file:   home/bilabila/.config/SogouPY/env.ini
   new file:   home/bilabila/.config/SogouPY/phrase/PhraseEdit.txt
   new file:   home/bilabila/.config/SogouPY/sogouEnv.ini
   ...
   ```

7. `dot commit`
8. `dot log -p` recheck this commit, edit or remove for clean, then `dot commit --amend`
9. `dot remote add origin git@github.com:tkkcc/_config`, should be private
10. `dot push -u origin master`

### server

On server, use branch h. First download or copy the dot script into PATH

1. `dot clone git@github.com:tkkcc/_config` create `$HOME/.local/share/dot/git`, fetch, reset origin/master, without changing local file
2. `dot checkout -b h` create branch h
3. `dot status` show

   ```
   deleted:    etc/X11/xorg.conf.d/01-mouse.conf
   deleted:    etc/default/tlp
   deleted:    etc/grub.d/40_custom
   deleted:    etc/hostname
   modified:   etc/hosts
   deleted:    etc/intel-undervolt.conf
   deleted:    etc/locale.conf
   deleted:    etc/locale.gen
   typechange: etc/localtime
   deleted:    etc/mkinitcpio.d/0.preset
   ...
   modified:   home/bilabila/.config/VirtualBox/VirtualBox.xml
   modified:   home/bilabila/.config/aria2/aria2.conf
   modified:   home/bilabila/.config/clash/config.yml
   modified:   home/bilabila/.config/fish/config.fish
   modified:   home/bilabila/.config/fish/fish_variables
   modified:   home/bilabila/.config/fish/functions/asp.fish
   modified:   home/bilabila/.config/fish/functions/conda.fish
   modified:   home/bilabila/.config/fish/functions/fish_user_key_bindings.fish
   modified:   home/bilabila/.config/git/config
   modified:   home/bilabila/.config/gtk-3.0/bookmarks
   modified:   home/bilabila/.config/htop/htoprc
   ...
   ```

4. `dot rm --cached -r /etc` delete root files from index

   ```
   rm 'etc/X11/xorg.conf.d/01-mouse.conf'
   rm 'etc/default/tlp'
   rm 'etc/grub.d/40_custom'
   ...
   ```

5. `dot add -p` edit and stage, there may be some changes that should be in master, just add it to h
6. `dot checkout -p` unstage
7. `dot add .hushlogin` track extra file
8. `dot commit`
9. `dot reset --hard` sync to local
10. `dot log --all --graph --abbrev-commit`

    ```
    * commit 6361d26 (HEAD -> h)
    | Author: bilabila <bilabila@qq.com>
    | Date:   Wed Apr 3 17:44:07 2019 +0800
    |
    |     Wed Apr  3 17:44:07 CST 2019
    |
    * commit c37abbd (origin/master)
      Author: bilabila <bilabila@qq.com>
      Date:   Tue Apr 2 14:21:39 2019 +0800

          Tue Apr  2 14:25:10 CST 2019
    ```

11. `dot diff master h` tell how to move from master to h

### pick

Pick some change from h to master

1. set environment variable `DOT_DIR` to a tmp folder `$A/dot/tmp`(must exist), dot's working tree change from `/` to it
2. `dot checkout master -f` move to master
3. `dot cherry-pick -n h` apply commit h to staged and local, `dot reset` unstage all, `dot add -p` select, edit and stage
4. `dot diff --cached` see picked changes
5. `dot commit`
6. `dot log --all --graph --abbrev-commit` show

   ```
   * commit f9ae0a9 (HEAD -> master)
   | Author: bilabila <bilabila@qq.com>
   | Date:   Wed Apr 3 18:09:11 2019 +0800
   |
   |     Wed Apr  3 18:09:11 CST 2019
   |
   | * commit 6361d26 (h)
   |/  Author: bilabila <bilabila@qq.com>
   |   Date:   Wed Apr 3 17:44:07 2019 +0800
   |
   |       Wed Apr  3 17:44:07 CST 2019
   |
   * commit c37abbd (origin/master)
     Author: bilabila <bilabila@qq.com>
     Date:   Tue Apr 2 14:21:39 2019 +0800

         Tue Apr  2 14:25:10 CST 2019
   ```

7. `dot reset --hard` reset unpicked changes
8. `dot checkout h` move to h
9. `dot rebase master` rebase h on master

   ```
   * commit e557f16 (HEAD -> h)
   | Author: bilabila <bilabila@qq.com>
   | Date:   Wed Apr 3 17:44:07 2019 +0800
   |
   |     Wed Apr  3 17:44:07 CST 2019
   |
   * commit f9ae0a9 (master)
   | Author: bilabila <bilabila@qq.com>
   | Date:   Wed Apr 3 18:09:11 2019 +0800
   |
   |     Wed Apr  3 18:09:11 CST 2019
   |
   * commit c37abbd (origin/master)
     Author: bilabila <bilabila@qq.com>
     Date:   Tue Apr 2 14:21:39 2019 +0800

         Tue Apr  2 14:25:10 CST 2019
   ```

10. `dot diff master h` compare again
11. unset `DOT_DIR` change working tree to `/`
12. `dot reset --hard` change real config
13. `dot push origin --all --force-with-lease` upload

### sync

Return to laptop, on master

1. `dot fetch` update local origin/master
2. in tmp working tree, `dot reset --hard`, `dot clean -fidx`, `dot rebase origin/master` move master to origin/master
3. unset `DOT_DIR`, `sudo dot reset --hard` sync to local
4. `sudo dot perm` reset permission

### public

Make a public version is a little different from branch h

1. in tmp working tree, create branch public
2. `dot reset --hard`, `dot clean -fidx`, `dot rm --cached -r $DOT_DIR` sync commit tree to working dir but empty index
3. `dot add $DOT_DIR -N`, `dot add -p` select, edit(remove ssh key, replace password, access_token) and stage
4. `dot grep 1234` recheck
5. `dot commit`
6. `dot reset --hard`, `dot rebase --root -i` and squash all except first

   ```
   pick c37abbd Tue Apr  2 14:25:10 CST 2019
   s f9ae0a9 Wed Apr  3 18:09:11 CST 2019
   s 6f613d6 Wed Apr  3 18:38:29 CST 2019
   s f7bf473 Wed Apr  3 18:42:17 CST 2019
   s d791968 Wed Apr  3 18:54:08 CST 2019
   s 3baaf11 Wed Apr  3 19:08:52 CST 2019

   # Rebase 3baaf11 onto e15e32d (6 commands)
   ```

   this new tree contains no sensitive data

   ```
   * commit 2afe678 (HEAD -> public)
     Author: bilabila <bilabila@qq.com>
     Date:   Tue Apr 2 14:21:39 2019 +0800

         Wed Apr  3 19:08:52 CST 2019

   * commit d791968 (master)
   | Author: bilabila <bilabila@qq.com>
   | Date:   Wed Apr 3 18:54:08 2019 +0800
   |
   |     Wed Apr  3 18:54:08 CST 2019
   |
   * commit f7bf473 (origin/master)
   | Author: bilabila <bilabila@qq.com
   ...
   ```

7. `dot remote add public git@github.com:tkkcc/config`
8. `dot push public public:master`, first public is remote, next is local branch, master is remote branch, always specify remote when push
9. `dot push origin --all --force-with-lease` push to private repository
10. `dot cherry-pick -n f7bf473..master`, `dot reset`, `dot add -p` pick from master

### folder

git only track file, here is an example to readd folder, `a` is all to add, `r` to exclude

<!-- bb -->
```sh
#!/bin/bash
pacman -Qnettq >$S/yq
pacman -Qmettq | sed s/^/#/ >>$S/yq
IFS=$'\n'
a=(
  $C/msmtp
  $C/kitty/kitty.conf
  $C/nnn/plugins
  $C/awesome/rc.lua
  $C/bspwm/bspwmrc
  $C/sxhkd/sxhkdrc
  $C/sxhkd/sxhkdrc_bspwm
  $C/tmux/config
  $C/screenkey.json
  $C/v2ray
  $C/lua-format
  $A/dot/filter
  $A/dot/attribute
  $C/BaiduPCS-Go/pcs_config.json
  $C/Code\ Industry/Master\ PDF\ Editor\ 5.conf
  $C/Dharkael/flameshot.ini
  $C/Genymobile
  $C/Mousepad
  $C/SogouPY/env.ini
  $C/SogouPY/phrase
  $C/SogouPY/sogouEnv.ini
  $C/SogouPY/useSkin.txt
  $C/Thunar
  $C/Trolltech.conf
  $C/VirtualBox/VirtualBox.xml
  $C/aria2/aria2.conf
  $C/aria2/aria2.session
  $C/chrome-flags.conf
  $C/chromium-flags.conf
  $C/clash/config.yml
  $C/compton.conf
  $C/dnsmasq
  $C/dunst
  $C/fcitx/config
  $C/fcitx/profile
  $C/feh
  $C/fish
  $C/fontconfig
  $C/git/config
  $C/gtk-2.0/gtkrc
  $C/gtk-3.0
  $C/haproxy
  $C/htop
  $C/i3
  $C/ipython/profile_default/ipython_config.py
  $C/kbd
  $C/latexindent/defaultSettings.yaml
  $C/less
  $C/linopen/config
  $C/mpv/input.conf
  $C/mpv/mpv.conf
  $C/mpv/scripts
  $C/mpv/scripts-opts
  $C/netease-cloud-music/netease-cloud-music.ini
  $C/npm/npmrc
  $C/nvim/init.vim
  $C/nvim/coc-settings.json
  $C/octave/octaverc
  $C/pip
  $C/privoxy
  $C/ranger
  $C/rclone
  $C/rofi
  $C/sogou-qimpanel/main.conf
  $C/sogou-qimpanel/skin/save_skin.ini
  $C/sogoupinyin/conf/env.ini
  $C/urxvt
  $C/user-dirs.dirs
  $C/wal
  $C/wgetrc
  $C/x11
  $C/zathura
  $H/.condarc
  $H/.drirc
  $H/.ssh
  $H/.wayland
  $H/.yarnrc
  $H/desktop
  $H/.rtorrent.rc
  $S
  /etc/X11/xorg.conf.d/01-mouse.conf
  /etc/tlp
  /etc/grub.d/40_custom
  /etc/hostname
  /etc/hosts
  /etc/intel-undervolt.conf
  /etc/locale.conf
  /etc/locale.gen
  /etc/localtime
  /etc/mkinitcpio.d/0.preset
  /etc/mkinitcpio.d/linux.preset
  /etc/modprobe.d
  /etc/modules-load.d
  /etc/netctl/hit
  /etc/netctl/p5
  /etc/netctl/wired
  /etc/pacman.conf
  /etc/pdnsd.conf
  /etc/smartdns/smartdns.conf
  /etc/resolv.conf
  /etc/resolvconf.conf
  /etc/sudoers
  /etc/sysctl.d
  /etc/systemd/journald.conf
  /etc/systemd/logind.conf
  /etc/systemd/system.conf
  /etc/systemd/system/getty@tty1.service.d
  /etc/systemd/system/resume@.service
  /etc/vconsole.conf
  /etc/systemd/network/wired.network
  /etc/NetworkManager/conf.d/dns.conf
  $H/.config/imv/config
  $C/systemd/user/arknights.timer
  $C/systemd/user/arknights.service
  /usr/share/gvfs/mounts/network.mount
)
r=(
  $C/obs-studio
  # $S/data
  $S/2
  $S/.'*'
  $S/gcc
  $S/g++
  $C/fish/completions/dotgit.fish
  '*.bak'
)
re=(
)
dot reset -q
for i in "${a[@]}"; do
  dot add -f -- "$i" 2>/dev/null
done
#dot add --ignore-errors -f -- "${a[@]}"
for i in "${r[@]}"; do
  dot rm --cached -rfq -- "$i" 2>/dev/null
done
for i in "${re[@]}"; do
  dot reset -q -- "$i" 2>/dev/null
done
dot status
echo '1. vscode setting'
echo '2. rclone sync $HOME/.local/share/fonts/ gd:fonts'

```

### filter

Some file contain useless info, and should be filtered. For example, there is a changing line in ranger's bookmarks
`':/home/bilabila`. To filter this line, add a filter driver to `$HOME/.local/share/dot/filter`

```
[filter "bookmarks"]
    clean = sed "/^\\'/d"
```

and a filter config to `$HOME/.local/share/dot/attribute`

```
/home/bilabila/.config/ranger/bookmarks filter=bookmarks
```

These two files are "included" in `$HOME/.local/share/dot/git/config` when `dot init` or `dot clone`, you can edit them by `dot edit -f` and `dot edit -a`. 
These two files are just git's config and attributes, separated in order to be versioned. 
See [mine](https://github.com/tkkcc/dot/tree/master/home/bilabila/.local/share/dot) for more examples

### convert username

You may want to export your config to others, but some are hard code. Here is a helper to replace username in file and folder name and file content. Not tested much.

```sh
#!/usr/bin/env bash
# transfer username in dot config
pre=bilabila
cur=dilidili

# rename in file
find . -type f \
    -exec grep -iq -- $pre {} \; \
    -exec nvim -c "bufdo %s/$pre/$cur/gce|update" -- {} +

# rename file and folder name
find . -iname "*$pre*"|sort -r|while read i;do
    [[ ! -e "$i" ]] && continue
    n="$(dirname "$i")"/"$(basename "$i"|sed s/$pre/$cur/I)"
    read -rp "rename '$i' to '$n' [Y/n]?" t </dev/tty
    [[ "$t" == n ]] && continue
    [[ -e "$n" ]] && read -rp "remove '$n' [Y/n]?" t </dev/tty
    [[ "$t" == n ]] && continue
    rm -Rf "$n" 2>/dev/null
    mv -fT -- "$i" "$n" </dev/tty
done

# find all '......'
pre=......
find . -type f -exec grep -nF -- $pre {} +
find . -type f \
    -exec grep -qF -- $pre {} \; \
    -exec vim -c "bufdo /\.\{6\}|update" -- {} +
```
