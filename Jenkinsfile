// Declare the variable i for its usage in the for loop; The variable is required to selectively update the individual issues associated to the Story ID
def i = 0
def j = 0

pipeline  {
    triggers {
    	pollSCM('') // Enabling being build on Push
    }
    agent none
    
    environment  {
				
		GITHUB_COMMON_CREDS = credentials('jenkins-github-common-creds') //Github credentials are mapped to the ID 'jenkins-github-common-creds' setup in Jenkins
	    	GITHUB_JIRA_COMMON_CREDS = credentials('jenkins-jira-common-creds') //JIRA credentials are mapped to the ID 'jenkins-jira-common-creds' setup in Jenkins
			
    }
    
    stages  { 
		
		stage('Install Puppet Agent')  {
			
			agent { label 'slave_node'}

				steps  {
						
					script	{
					properties (
						[office365ConnectorWebhooks([
					//		[name: "abhilashbn", url: "https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/260ee879bcbc416ba8dd310e1b6f7aa3/0e88df31-c89a-4d69-9c46-a9ab765cf287", status: 'STARTED', color: 'Yellow', message: 'started ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)',]
							[name: "Dev", url: "https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287", notifySuccess: true]
						])
						]
					)
					//office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "Started the job to install puppet agent on the test node for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Started'
					sh """				    
					sudo wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
					sudo dpkg -i puppetlabs-release-pc1-xenial.deb
					sudo apt-get update -y
					sudo apt-get install puppet-agent -y
					sudo systemctl start puppet
					sudo systemctl enable puppet
					sudo systemctl status puppet
					"""					
					}	
				}
			
				post {
	
					success  {

						node ( 'slave_node' )	{
							office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "Successfully completed the job to install puppet agent on the test node for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Succeeded'
        					}
					}
					
					failure  {

						node ( 'slave_node' )	{
							office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "The job to install puppet agent on the test node failed for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Failed'
						}       					
					}					
				}
		}
		
		stage('Certificate Sign')  {
			
			agent { label 'master'}

				steps  {
									
					office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "Started the job to sign the certificate of the puppet master on the staging node for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Started'
					sh """
					sudo /opt/puppetlabs/bin/puppet cert list
					#sudo /opt/puppetlabs/bin/puppet cert sign "slave.joha155tytoeblqpel2h10tp0f.bx.internal.cloudapp.net"
					"""
						
				}
				
				post {
	
					success  {

						node ( 'master' )	{
							office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "Successfully completed the job to sign the certificate of the puppet master on the staging node for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Succeeded'
        					}
					}
					
					failure  {

						node ( 'master' )	{
							office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "The job to sign the certificate of the puppet master on the staging node failed for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Failed'
						}
        				}					
				}
		}

		stage('Install Docker Agent')  {
			
			agent { label 'slave_node'}

				steps  {
						
					office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "Started the job to install docker agent on the test node for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Started'
					sh """
					set +e
					sudo /opt/puppetlabs/bin/puppet agent -t > puppet.out 2>&1
					set -e
					"""
					
				}	
				
				post {
	
					success  {

						node ( 'slave_node' )	{
							office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "Successfully completed the job to install docker agent on the test node for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Succeeded'
        					}
					}
					
					failure  {

						node ( 'slave_node' )	{
							office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "The job to install docker agent on the test node failed for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Failed'
						}
        				}					
				}
		}
              	
		
		stage('Run Selenium Test')  {
			
			agent { label 'slave_node'}

				steps  {

					script	{
					properties (
						[office365ConnectorWebhooks([
							[name: "Dev", url: "https://outlook.office.com/webhook/bc9bce4f-c503-4bb2-9ef0-2fd6a4f317e4@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/19ca320a8d624f16ac1512b2d03ec4b1/0e88df31-c89a-4d69-9c46-a9ab765cf287", notifySuccess: true]
						])
						]
					)					
					//office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/bc9bce4f-c503-4bb2-9ef0-2fd6a4f317e4@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/19ca320a8d624f16ac1512b2d03ec4b1/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "Started the job to run selenium automation test on the test node for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Started'
					sh """
					sudo docker build -t devopsedu/webapp '/home/ubuntu/jenkins/workspace/Deloitte_Pipeline_master/'
					sudo docker run -itd -p 8082:80 devopsedu/webapp
					sudo docker ps -a
					"""
					}
					script{
				
						def test_id=[] //Groovy Array List to store the list of Test IDs associated with the Story ID 
						def test_key=[] //Groovy Array List to store the list of Test Keys associated with the Story ID 
						env.StoryId="DEL-1"
						sh """
						bash -c \" source ./get_test_ids.sh ${GITHUB_JIRA_COMMON_CREDS_USR} ${GITHUB_JIRA_COMMON_CREDS_PSW} ${env.StoryId} \" > get_testids_response
						bash -c \" source ./get_test_keys.sh ${GITHUB_JIRA_COMMON_CREDS_USR} ${GITHUB_JIRA_COMMON_CREDS_PSW} ${env.StoryId} \" > get_testkeys_response
						"""
						get_tid = readFile 'get_testids_response' 
						get_tkey = readFile 'get_testkeys_response'
						test_id = get_tid.split('\n')
						test_key = get_tkey.split('\n')

						//Run Selenium Tests for every Test related to the Story; Run until the tests pass and update the status in Zephyr using ZAPI; If the test fails, break the loop, run the post step and update the status in Zephyr using ZAPI 
						while (i < test_id.size()){
							sh """
							echo "${test_id[i]}" > tid_temp		
							cat tid_temp
							cd "/home/ubuntu/jenkins/workspace/Deloitte_Pipeline_master/"
							sudo su -c \"java -jar /home/ubuntu/jenkins/workspace/Deloitte_Pipeline_master/AppTest.jar\" ubuntu
							bash -c \" source ./update_passed_test.sh ${GITHUB_JIRA_COMMON_CREDS_USR} ${GITHUB_JIRA_COMMON_CREDS_PSW} DEL-1 \"
							"""
							i++
						}
					}							
				}
				
				post {
	
					success  {

						node ( 'slave_node' )	{
							office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/bc9bce4f-c503-4bb2-9ef0-2fd6a4f317e4@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/19ca320a8d624f16ac1512b2d03ec4b1/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "Successfully tested the dockerized application deployed to the staging node for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Succeeded'
        					}
					}
					
					failure  {

						node ( 'slave_node' )	{
							office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/bc9bce4f-c503-4bb2-9ef0-2fd6a4f317e4@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/19ca320a8d624f16ac1512b2d03ec4b1/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "Testing of the dockerized application deployed to the staging node failed for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Failed'
							script	{
								echo 'Test failed'
                  						sh """
                    						tid=\$(cat tid_temp)
                    						echo "\${tid}"
                   						bash -c \" source ./update_failed_test.sh ${GITHUB_JIRA_COMMON_CREDS_USR} ${GITHUB_JIRA_COMMON_CREDS_PSW} DEL-1\"
								sudo docker rm -f \$(sudo docker ps -a -q)
                    						"""
        						}
						}
        				}					
				}
		}

		stage('Delete Running Container')  {
			
			agent { label 'slave_node'}

				steps  {
					script	{
					properties (
						[office365ConnectorWebhooks([
					//		[name: "abhilashbn", url: "https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/260ee879bcbc416ba8dd310e1b6f7aa3/0e88df31-c89a-4d69-9c46-a9ab765cf287", status: 'STARTED', color: 'Yellow', message: 'started ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)',]
							[name: "Dev", url: "https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287", notifySuccess: true]
						])
						]
					)
					//office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "Started the job to delete the docker container on the test node for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Started'
					sh """
					sudo docker rm -f \$(sudo docker ps -a -q)
					"""
					}	
				}
			
				post {
	
					success  {

						node ( 'slave_node' )	{
						office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "Successfully completed the job to delete docker container on the test node for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Succeeded'
        					}
					}
					
					failure  {

						node ( 'slave_node' )	{
						office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "The job to delete docker container on the test node failed for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'Build Failed'
						}
        				}					
				}			
		}  
    }

    post {
	
    		success  {

			node ( 'slave_node' )	{
				office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "Successfully completed the CI/CD Pipeline for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'CI/CD Pipeline Build Succeeded'
        		}
		}
					
		failure  {

			node ( 'slave_node' )	{
				office365ConnectorSend webhookUrl: 'https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/9707c6173c2e4df58bcefdf1ec90f76a/0e88df31-c89a-4d69-9c46-a9ab765cf287', message: "CI/CD Pipeline did not complete successfully for the Build Number ${BUILD_NUMBER}. Please check (<${BUILD_URL}|Open>) to verify the Build", status: 'CI/CD Pipeline Build Failed'
			}
        	}					
	}
}
