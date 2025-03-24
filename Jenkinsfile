pipeline {
    agent any

    stages {
        stage ('Preparing terraform') {
            steps {
            dir('terraform') {
               sh 'pwd'
               sh 'ls'
               sh 'cp .terraformrc ~/'
            }
        }
    }    

        stage ('Provisioning for build instance') {
            steps {
            dir('terraform') {
                sh 'pwd'
                sh 'terraform init && terraform plan && terraform apply -auto-approve'
            }
        }
    }
        stage('Ansible Deploy') {
            steps {
            dir('terraform') {    
                script {
                    sh 'pwd'
                    def output = sh(script: "terraform output -raw instance_ip", returnStdout: true)
                    env.INSTANCE_IP = output
                   }
                }
              }
            }
        stage('Deploy Application') {
            steps {
                ansiblePlaybook(
                   playbook: 'ansible/playbook.yml',
                   inventory: "${INSTANCE_IP},",
                   credentialsId: 'ansible-ssh-key-id'
                   )
            }
        }
    }
}
