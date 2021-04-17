function assignIm
    #export GTK_IM_MODULE=ibus
    #export XMODIFIERS=@im=ibus
    #export QT_IM_MODULE=ibus
    #set -l im GTK_IM_MODULE XMODIFIERS QT_IM_MODULE
    #for p in $im
        #set $argv[2..-1] $p $argv[1]
    #end
    set $argv[2..-1] GTK_IM_MODULE $argv[1]
    set $argv[2..-1] QT_IM_MODULE $argv[1]
    set $argv[2..-1] INPUT_METHOD $argv[1]
    set $argv[2..-1] XMODIFIERS @im=$argv[1]
end
