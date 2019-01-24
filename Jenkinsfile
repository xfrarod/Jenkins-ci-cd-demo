import java.text.SimpleDateFormat

readProperties = loadConfigurationFile 'configFile'
currentBuild.displayName = new SimpleDateFormat("yy.MM.dd").format(new Date()) + "-" + env.BUILD_NUMBER

 pipeline {
    agent {
        label 'swarm' 
    }
    environment {
        SONAR_TOKEN = "admin"
    }
    triggers {
         pollSCM('H/5 * * * *')
    }
    stages {
        stage('Test & Build'){
          when { 
              expression{ env.BRANCH_NAME ==~ /dev.*/ || 
                  env.BRANCH_NAME ==~ /PR.*/ || env.BRANCH_NAME ==~ /feat.*/ }
          }
          steps{
                buildDockerImage readProperties.image,
                    readProperties.sonarServer , false
          }
        }

        stage('deploy app'){
            when { expression{ env.BRANCH_NAME ==~ /dev.*/ || env.BRANCH_NAME ==~ /PR.*/ }}
            steps {
                composeDeployApp readProperties.image
            }

        }
    }
    /*post {
      always {
            sh "docker system prune -f"
      }
    }*/
}
