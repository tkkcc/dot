function jn
    if pgrep -f jupyter 
        eval $BROWSER http://localhost:8888
    else
        exec jupyter notebook
    end
end
