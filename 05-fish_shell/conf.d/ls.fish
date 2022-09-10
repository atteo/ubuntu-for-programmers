
function __fish_ls --description 'List files'
    set val (eval echo (commandline -t))
    printf "\n"
    if test -d $val
        ls -l $val
    else
        set dir (dirname -- $val)
        if test $dir != . -a -d $dir
            ls -l $dir
        else
            ls -l
        end
    end

    set -l line_count (count (fish_prompt))
    if test $line_count -gt 1
        for x in (seq 2 $line_count)
            printf "\n"
        end
    end

    commandline -f repaint
end

bind \eL __fish_ls
