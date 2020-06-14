pipeline {
  environment {
    IM = '319634644076.dkr.ecr.us-east-1.amazonaws.com/vueapp'
    ECRURL = 'https://319634644076.dkr.ecr.us-east-1.amazonaws.com/vueapp'
    ECRCRED = 'ecr:us-east-1:aws_cred'
    VERSION = "${env.BUILD_NUMBER}"
    IMAGE="$IM:$VERSION"

  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/arpitgulati/kube-infra.git'
      }
    }
    // stage('Initialize'){
    //     steps{
    //       script {
    //         def dockerHome = tool 'kube-infra'
    //         env.PATH = "${dockerHome}/bin:${env.PATH}"
    //       }
    //     }
    // }    
    stage('Building image') {
      steps{
        script {
          sh 'docker build --no-cache -t $IM:$VERSION .'
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry(ECRURL, ECRCRED) {
            docker.image(IMAGE).push()
          }
        }
      }
    }
    stage('Deploy Vue App') {
      steps{
        script {
          sh "sed -i 's/latest/$VERSION/g' deployment.yaml"
          kubernetesDeploy(configs: "deployment.yaml", kubeconfigId: "kubeconfig")
        }
      }
    }
  }
}
