function mc
	set mctmpfile (tempfile)
	rm -f $mctmpfile
	/usr/bin/mc -P $mctmpfile
	cd (cat $mctmpfile)
	rm -f $mctmpfile
	set mctmpfile
end

