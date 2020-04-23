pipeline {
   agent {
       docker {
           image 'python'
       }
   }

   stages {
      stage('Build') {
         steps {
            sh 'pip install robotframework'
         }
      }
  
      stage('Test') {
         steps {
            sh 'robot -d ./log tests/'
         }
      }
   }
}
