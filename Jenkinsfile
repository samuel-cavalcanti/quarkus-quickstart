// Build a Maven project using the standard image and Scripted syntax.
podTemplate(
    agentContainer: 'maven',
    agentInjection: true,
    yaml: readTrusted('kube_yamls/jenkins/jenkins-pod.yaml')
) {
    retry(count: 2, conditions: [kubernetesAgent(), nonresumable()]) {
        node(POD_LABEL) {
            git (
                url:'git@github.com:samuel-cavalcanti/quarkus-quickstart.git',
                branch: 'main',
                credentialsId: 'GITHUB_DEPLOY_KEY',
                )
                
            sh 'HOME=$WORKSPACE_TMP/maven mvn -B -ntp verify'
        }
    }
}



