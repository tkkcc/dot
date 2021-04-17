function fish_user_key_bindings
    bind \ej accept-autosuggestion execute
    bind \cj accept-autosuggestion execute
    bind \cs sudoToggle
    bind \es sudoToggle
    bind \ev fish_clipboard_paste
    bind \cv fish_clipboard_paste
    bind \el 'commandline -a "|less";commandline -f execute'
    bind \eo 'commandline -a "|fzf";commandline -f execute'
    bind \ei 'commandline -a " --help";commandline -f execute'
    bind \e, history-token-search-forward
    bind \e\; __fish_man_page
    bind \c\; __fish_man_page
    bind \ex 'commandline -i (eval (history -1))'
    bind \cx 'commandline -i (eval (history -1))'
    bind \ec 'commandline -i (history -1)'
    bind \ep up-or-search
    bind \en down-or-search
    bind \ee end-of-line
    bind \ea beginning-of-line
    bind \eu backward-kill-line
    bind \ek kill-line
    bind \ed delete-or-exit
    bind \e/ undo
    bind \e\? redo
    # bind \c/ undo
    # bind \c\? redo
    bind \ct transpose-words
end
