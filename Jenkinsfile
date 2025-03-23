pipeline {
    agent any

    stages {
        stage ('Preparing terraform') {
            steps {
            dir('terraform') {
               sh 'cp .terraformrc ~/'
            }
        }

        stage ('Provisioning for build instance') {
            steps {
            dir('terraform') {
                sh 'terraform init && terraform plan && terraform apply -auto-approve'
            }
        }
        stage('Ansible Deploy') {
            steps {
                script {
                    def output = sh(script: "terraform output -json instance_ip", returnStdout: true)
                    env.INSTANCE_IP = readJSON(text: output).value[0]
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