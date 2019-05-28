#!groovy
import jenkins.model.*
import hudson.security.*
import jenkins.install.InstallState

def env = System.getenv()

def instance = Jenkins.getInstance()

println "--> creating local user env.JENKINS_USER with env.JENKINS_PASS"
// Create user with custom pass
def user = instance.getSecurityRealm().createAccount(env.JENKINS_USER, env.JENKINS_PASS)
user.save()

if (!instance.installState.isSetupComplete()) {
  println '--> Neutering SetupWizard'
  InstallState.INITIAL_SETUP_COMPLETED.initializeState()
}

instance.save()
