GREEN='\033[0;32m'
if [ "$EUID" -ne 0 ]
  then echo "Are you root?"
  exit
else
printf "Removing all the Java related packages (Sun, Oracle, OpenJDK, IcedTea plugins, GIJ)" && printf "Fetching Files..." && sleep 3s && dpkg-query -W -f='${binary:Package}\n' | grep -E -e '^(ia32-)?(sun|oracle)-java' -e '^openjdk-' -e '^icedtea' -e '^(default|gcj)-j(re|dk)' -e '^gcj-(.*)-j(re|dk)' -e '^java-common' | xargs sudo apt-get -y remove && read -p "Purging config files (careful. This may remove libsgutils2-2 and virtualbox config files too..) *PRESS ENTER TO CONTINUE*" && dpkg -l | grep ^rc | awk '{print($2)}' | xargs sudo apt-get -y purge && read -p "Remove Java config and cache directory..||PRESS ENTER TO CONTINUE||" && sudo bash -c 'ls -d /home/*/.java' | xargs sudo rm -rf && read -p "||Removing installed JVMs...||" && sudo rm -rf /usr/lib/jvm/* && read -p "Removing other Java entries..." && for g in ControlPanel java java_vm javaws jcontrol jexec keytool mozilla-javaplugin.so orbd pack200 policytool rmid rmiregistry servertool tnameserv unpack200 appletviewer apt extcheck HtmlConverter idlj jar jarsigner javac javadoc javah javap jconsole jdb jhat jinfo jmap jps jrunscript jsadebugd jstack jstat jstatd native2ascii rmic schemagen serialver wsgen wsimport xjc xulrunner-1.9-javaplugin.so; do sudo update-alternatives --remove-all $g; done  && read -p "++Press any key to EXIT++" && exit
fi
