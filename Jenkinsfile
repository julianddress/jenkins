pipeline {
    agent any

    stages {

        stage('1. Auditoria de Codigo (Linting)') {
            steps {
                echo 'Validando sintaxis de Terraform y Ansible ...'

                dir('terraform') {
                    bat 'terraform validate'
                }

                dir('ansible') {
                    bat 'ansible-playbook --syntax-check playbook.yml'
                }
            }
        }

        stage('2. Planificacion (Terraform Plan)') {
            steps {
                dir('terraform') {
                    bat 'terraform init'
                    bat 'terraform plan'
                }
            }
        }

        stage('3. Aprobacion Manual (Gatekeeper)') {
            steps {
                input message: '¿El terraform plan se ve correcto? Aprobar infraestructura', ok: 'Aprobar y desplegar'
            }
        }

        stage('4. Aprovisionamiento (Terraform Apply)') {
            steps {
                dir('terraform') {
                    bat 'terraform apply -auto-approve'
                }
            }
        }

        stage('5. Configuracion Ansible') {
            steps {
                dir('ansible') {
                    echo 'Esperando 5 segundos a que la red del servidor se estabilice...'
                    sleep time: 5, unit: 'SECONDS'
                    bat 'ansible-playbook -i hosts.ini playbook.yml'
                }
            }
        }
    }
}
