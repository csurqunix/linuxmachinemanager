pipeline {
    agent any

    stages {
        stage('Définition de la branche du dépôt') {
            steps {
                git branch: 'main', url: 'https://github.com/csurqunix/linuxmachinemanager.git'
            }
        }

        stage('Exécution du Script') {
            steps {
                sh 'chmod +x linuxmmm'
                bash './linuxmmm'
            }
        }
    }

    post {
        success {
            echo 'Build et exécution effectuées avec succès !'
        }
        failure {
            echo 'Build et exécution ont échoué '
            script {
                def emailBody = "Bonjour,\n\nLa construction et l'exécution du script ont échoué. Veuillez vérifier les journaux de construction Jenkins pour plus de détails.\n\nCordialement,\nL'équipe DevOps"
                emailext (
                    subject: 'Échec de la construction Jenkins',
                    body: emailBody,
                    recipientProviders: [[$class: 'CulpritsRecipientProvider']],
                    to: 'cedsurq@protonmail.com'
                )
            }
        }
    }
}
