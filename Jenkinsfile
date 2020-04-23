pipeline {
   agent {
       docker {
           image 'python'
       }
   }

   stages {
      stage('Build') {
         steps {
            sh 'pip install -r requirements.txt'
         }
      }
  
      stage('Test') {
         steps {
            sh 'robot -d ./log tests/'
         }
      }
   }
}
