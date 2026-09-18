pipeline{
    agent {label "dev-server"}
    stages{
        stage("codeclone"){
            steps{
                echo "this is bankapp clone with using git"
                git url: "https://github.com/baditya85/bankapp.git", branch: "main"
            }
        }
        stage("imagebuild"){
            steps{
                echo "this is a docker build of the bank app"
                sh "docker build -t bank-app ."
            }
        }
        stage("imagepush"){
            steps{
                echo "this is a build image push"
                withCredentials([usernamePassword(
                    credentialsId:"dockerhubcred", 
                    usernameVariable: "dockerHubUser", 
                    passwordVariable: "dockerHubPassword")]){
                        sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                        sh "docker image tag bank-app:latest ${env.dockerHubUser}/bank-app:latest"
                        sh "docker image push ${env.dockerHubUser}/bank-app:latest"
                    }
            }
        }
        stage("networkcreate"){
            steps{
                sh "docker network rm bankapp && docker network create bankapp -d bridge"
            }
        }
        stage("deploy"){
            steps{
                sh "docker compose down && docker compose up -d"
            }
        }
    }
}
