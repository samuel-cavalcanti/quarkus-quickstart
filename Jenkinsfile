// Build a Maven project using the standard image and Scripted syntax.
// Rather than inline YAML, you could use: yaml: readTrusted('jenkins-pod.yaml')
// Or, to avoid YAML: containers: [containerTemplate(name: 'maven', image: 'maven:3.6.3-jdk-8', command: 'sleep', args: 'infinity')]
podTemplate(
    agentContainer: 'maven',
    agentInjection: true,
    yaml: '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: maven
    # In a real Jenkinsfile, it is recommended to pin to a specific version and use Dependabot or Renovate to bump it.
    image: maven:3.9.11-eclipse-temurin-21
    resources:
      requests:
        memory: "512Mi"
      limits:
        memory: "1Gi"
    securityContext:
      # maven runs as root by default, it is recommended or even mandatory in some environments (such as pod security admission "restricted") to run as a non-root user.
      runAsUser: 1000
''') {
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
