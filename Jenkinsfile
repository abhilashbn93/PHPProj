// Declare the variable i for its usage in the for loop; The variable is required to selectively update the individual issues associated to the Story ID
def i = 0
def j = 0

pipeline  {

    agent none
    
    environment  {
				
		GITHUB_COMMON_CREDS = credentials('jenkins-github-common-creds') //Github credentials are mapped to the ID 'jenkins-github-common-creds' setup in Jenkins
	    	GITHUB_JIRA_COMMON_CREDS = credentials('jenkins-jira-common-creds') //JIRA credentials are mapped to the ID 'jenkins-jira-common-creds' setup in Jenkins
		scannerHome = tool name: 'sonarqubescanner'
	    
    }
    
    stages  { 
	    
	    stage('Test')  {
			
			agent { label 'master'}
 		steps {
                	

                  		sh "echo abcd"
                  	}
            	
		    }
	     stage('SonarQube Analysis') {
            	
	    	    agent { label 'master'}
		    
		    steps {
                	
			    println ${scannerHome}
			    withSonarQubeEnv("sonarqube") {
				   
                  		//sh "${scannerHome}/bin/sonar-runner"
                  	
				    
			    }            	
		    }
		    
            }
	    
    }
}
	   
