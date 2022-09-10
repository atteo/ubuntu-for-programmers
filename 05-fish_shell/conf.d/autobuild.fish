

function autobuild -d "Build project in this folder automatically"

	if test -e pom.xml -a -e build.sh;
		commandline "mvn clean package; and ./build.sh"
		commandline -f execute
		return
	end

	if test -e pom.xml;
		commandline "mvn clean package"
		commandline -f execute
		return
	end
end

bind \eb autobuild
