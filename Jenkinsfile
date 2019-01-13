import java.text.SimpleDateFormat

readProperties = loadConfigurationFile 'configFile'
currentBuild.displayName = new SimpleDateFormat("yy.MM.dd").format(new Date()) + "-" + env.BUILD_NUMBER

 pipeline {
    agent {
        docker {
            image readProperties.imagePipeline
        }
    }
    environment {
        SONAR_TOKEN = credentials('sonar-token') 
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
                    readProperties.sonarServer
            )  
          }
        }

        stage('deploy app'){
            when { expression{ env.BRANCH_NAME ==~ /dev.*/ || env.BRANCH_NAME ==~ /PR.*/ }}
            steps {
                dir("app"){
                    sh "docker-compose up"
                } 
            }

        }
    }
    post {
      always {
            sh "docker system prune -f"
      }
    }
}
