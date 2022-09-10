function dig
	if echo "$argv" | grep -i "A|AAAA|ANY|CAA|CNAME|HINFO|LOC|MX|NAPTR|NS|OPT|PTR|SOA|SRV|SSHFP|TLSA|TXT|CHAOS";
		dog $argv
	else
		# ANY is deprecated by RFC8482
		# https://blog.cloudflare.com/rfc8482-saying-goodbye-to-any/
		for type in A AAAA CAA CNAME HINFO LOC MX NS PTR SOA SRV SSHFP TLSA TXT;
			dog $argv $type || break
		end
	end
end



