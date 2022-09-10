function lsblk --wraps lsblk
    if [ "$argv" = "" ]
        command lsblk -o +LABEL,UUID
    else
        command lsblk "$argv"
    end
end
