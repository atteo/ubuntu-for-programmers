function ping --wraps ping
    if [ "$argv" = "" ]
        grc /bin/ping 8.8.8.8
    else
        grc /bin/ping "$argv"
    end
end
