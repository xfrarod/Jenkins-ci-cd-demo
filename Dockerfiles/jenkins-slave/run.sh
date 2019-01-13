COMMAND_OPTIONS="${COMMAND_OPTIONS} -username $USER_NAME_SECRET"
COMMAND_OPTIONS="${COMMAND_OPTIONS} -passwordEnvVariable PASSWORD_SECRET"

# GROUP=$(stat -c %G /var/run/docker.sock)
# if [ ! $(grep ^$GROUP: /etc/group) ]; then
#     addgroup -G $(stat -c %g /var/run/docker.sock) $GROUP
# fi
# adduser jenkins $GROUP

# exec su jenkins -c "exec java -jar /home/jenkins/swarm-client-${SWARM_CLIENT_VERSION}.jar ${COMMAND_OPTIONS}"
java -jar /home/jenkins/swarm-client-${SWARM_CLIENT_VERSION}.jar ${COMMAND_OPTIONS}