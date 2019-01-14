FROM jenkinsci/jenkins:lts-alpine

ENV SECRETS_DIR=/run/secrets
# Whether to skip setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Creates username and password specified through environment variables JENKINS_USER_SECRET and JENKINS_PASS_SECRET
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

COPY org.jenkinsci.plugins.workflow.libs.GlobalLibraries.xml /var/jenkins_home/org.jenkinsci.plugins.workflow.libs.GlobalLibraries.xml
COPY org.jenkinsci.plugins.configfiles.GlobalConfigFiles.xml /var/jenkins_home/org.jenkinsci.plugins.configfiles.GlobalConfigFiles.xml

RUN mkdir -p /var/jenkins_home/jobs \ 
    && chown -R jenkins:jenkins /var/jenkins_home/jobs

COPY --chown=jenkins:jenkins config.xml /var/jenkins_home/jobs/Jenkins-ci-cd-demo/config.xml



# Install a list of plugins from the file 'plugins.txt' and their dependencies
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
