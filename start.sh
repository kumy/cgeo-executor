#! /bin/bash
#

export SHELL=/bin/bash
export PATH=/opt/tools:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/platform-tools:$PATH
export TERM=dumb
slave=$(cat /srv/slave)
secret=$(cat /srv/secret)
if [ -z "$slave" -o -z "$secret" ]; then
  echo "You must place credentials for Jenkins in /srv/slave and /srv/secret" 2> /dev/null
  exit 1
fi
adb start-server
rm -f emulator.pid
java -jar slave.jar -jnlpUrl http://ci.cgeo.org/computer/$slave/slave-agent.jnlp -secret $secret
