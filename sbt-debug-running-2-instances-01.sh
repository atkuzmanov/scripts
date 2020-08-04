### SBT Debug 
### For running two separate SBT instances at the same time.
### For running two separate projects simultaneously.
## References: 
## http://stackoverflow.com/questions/14507688/sbt-debug-port-per-project
## https://gist.github.com/theon/4625742
## Original Script:
## #!/bin/sh
## test -f ~/.sbtconfig && . ~/.sbtconfig
## 
## SBT_LAUNCH=/usr/local/Cellar/sbt/0.12.1/libexec/sbt-launch.jar
## # Take leading integer as debug port and not sbt args
## DEBUG_PORT=$1
## SBT_ARGS=`echo "$@" | grep -oE "[^0-9].*"`
## 
## exec java -Xmx512M -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=${DEBUG_PORT} ${SBT_OPTS} -jar $SBT_LAUNCH $SBT_ARGS

## You can make it more generic by not hard-coding the path to sbt-launch.jar. 
## By replacing the SBT_LAUNCH= line with this: SBT_LAUNCH=$(grep -oE '/[^ ]+sbt-launch.jar' $(which sbt))
## #!/bin/sh
## test -f ~/.sbtconfig && . ~/.sbtconfig
## # SBT_LAUNCH=/usr/local/Cellar/sbt/0.12.1/libexec/sbt-launch.jar
## SBT_LAUNCH=$(grep -oE '/[^ ]+sbt-launch.jar' $(which sbt))
## # Take leading integer as debug port and not sbt args
## DEBUG_PORT=$1
## SBT_ARGS=`echo "$@" | grep -oE "[^0-9].*"`
## exec java -Xmx512M -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=${DEBUG_PORT} ${SBT_OPTS} -jar $SBT_LAUNCH $SBT_ARGS

## Current version:
#!/bin/sh
test -f ~/.sbtconfig && . ~/.sbtconfig
SBT_LAUNCH=/usr/local/Cellar/sbt/0.13.9/libexec/sbt-launch.jar
# Take leading integer as debug port and not sbt args
DEBUG_PORT=$1
SBT_ARGS=`echo "$@" | grep -oE "[^0-9].*"`
exec java -Xdebug -Xrunjdwp:transport=dt_socket,address=${DEBUG_PORT},server=y,suspend=n ${SBT_OPTS} -jar $SBT_LAUNCH $SBT_ARGS



