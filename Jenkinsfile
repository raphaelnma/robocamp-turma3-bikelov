pipeline {
   agent {
       docker {
           image 'ninja/pywd'
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
         post {
            always{
               robot otherFiles '**/*.png', outputPath: 'log'
            }
         }
      }
   }
}
