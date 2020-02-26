node{
    def buildnumber = BUILD_NUMBER
    stage('Git Clone'){
        git url: 'https://github.com/MithunTechnologiesDevOps/java-web-app-docker.git',branch: 'master'
    }

    stage(" Maven Clean Package"){
      def mavenHome =  tool name: "Maven", type: "maven"
      def mavenCMD = "${mavenHome}/bin/mvn"
      sh "${mavenCMD} clean package"
    }
    
    stage('Build Docker image'){
        sh "docker build -t arunapamidi20202/java-web-app-docker:${buildnumber} ."
    }
    
    stage('Push Image to Registry'){
        withCredentials([string(credentialsId: 'docker_hub_pw', variable: 'dockerhubpwd')]) {
            sh "docker login -u arunapamidi20202 -p${dockerhubpwd}"
            }
        sh "docker push arunapamidi20202/java-web-app-docker:${buildnumber}"
        
    }
    stage('Deploy on to Docker server'){
       sshagent(['Docker_Dev_Server_SSH']) {
           sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.43.177 "
           sh " docker rm -f javawebappcontainer|| true"
           sh " ssh -o StrictHostKeyChecking=no ubuntu@172.31.43.177 docker run -d -p 8081:8081 --name javawebappcontainer arunapamidi20202/java-web-app-docker:${buildnumber} "
           
       } 
    }
}
