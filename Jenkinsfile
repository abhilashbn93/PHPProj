pipeline  {

    agent none
    
    environment  {
				
		GITHUB_COMMON_CREDS = credentials('jenkins-github-common-creds') //Github credentials are mapped to the ID 'jenkins-github-common-creds' setup in Jenkins
	    	GITHUB_JIRA_COMMON_CREDS = credentials('jenkins-jira-common-creds') //JIRA credentials are mapped to the ID 'jenkins-jira-common-creds' setup in Jenkins

	    
    }
    
    stages  { 
	    
	    stage('Test')  {
			
			agent { label 'master'}
 		steps {
                	

                  		sh "echo abcd"
                  	}
            	
		    }
	    
    }
}
	   
