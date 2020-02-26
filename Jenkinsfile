node{
    def buildnumber= BUILD_NUMBER
    stage('scm checkout'){
        git url: 'https://github.com/arunapamidi/java-web-app-docker.git', branch: 'master'
    }
    stage('Maven'){
       def mavenHome= tool name: 'Maven', type: 'maven'
        def mavencmd= "${mavenHome}/bin/mvn"
        sh "${mavencmd} clean package"
    } 
    stage('Docker image'){
        sh "docker build  -t arunapamidi20202/java-web-app:${buildnumber} ."
    }
    stage('push docker image to hub'){
        withCredentials([string(credentialsId: 'docker_hub_pw', variable: 'dockerhubpwd')]) {
        sh "docker login -u arunapamidi20202 -p ${dockerhubpwd} "
        }
        sh "docker push arunapamidi20202/java-web-app:${buildnumber} "
    }
    stage('deploy on docker server'){
        sshagent(['Docker_Dev_Server_SSH']) {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.43.177 docker rm -f javawebappcntnr || true" 
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.43.177 docker run -d -p 8080:8080 --name  javawebappcntnr arunapamidi20202/java-web-app:${buildnumber} "
        }
    }
}
