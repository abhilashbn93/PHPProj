// Declare the variable i for its usage in the for loop; The variable is required to selectively update the individual issues associated to the Story ID
def i = 0

pipeline  {
    
    agent none
    
    environment  {
				
		GITHUB_COMMON_CREDS = credentials('jenkins-github-common-creds') //Github credentials are mapped to the ID 'jenkins-github-common-creds' setup in Jenkins
			
    }
    
    stages  { 
		
		stage('Install Puppet Agent')  {
			
			agent { label 'slave_node'}

				steps  {
						
					script	{
					properties (
						[office365ConnectorWebhooks([
							[name: "abhilashbn", url: "https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/260ee879bcbc416ba8dd310e1b6f7aa3/0e88df31-c89a-4d69-9c46-a9ab765cf287", notifyBuildstart: true, notifyAborted: true, notifyNotBuilt: true, notifyBackToNormal: true, notifyFailure: true, notifyRepeatedFailure: true, notifySuccess: true, notifyUnstable: true]
						])
						]
					)

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
					
		}
		
		stage('Certificate Sign')  {
			
			agent { label 'master'}

				steps  {
									
					script	{
					properties (
						[office365ConnectorWebhooks([
							[name: "abhilashbn", url: "https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/260ee879bcbc416ba8dd310e1b6f7aa3/0e88df31-c89a-4d69-9c46-a9ab765cf287", notifyBuildStart: true, notifyAborted: true, notifyNotBuilt: true, notifyBackToNormal: true, notifyFailure: true, notifyRepeatedFailure: true, notifySuccess: true, notifyUnstable: true]
						])
						]
					)					

					sh """
					sudo /opt/puppetlabs/bin/puppet cert list
					#sudo /opt/puppetlabs/bin/puppet cert sign "slave.joha155tytoeblqpel2h10tp0f.bx.internal.cloudapp.net"
					"""
					}	
				}
					
		}

		stage('Install Docker Agent')  {
			
			agent { label 'slave_node'}

				steps  {
						
					script	{
					properties (
						[office365ConnectorWebhooks([
							[name: "abhilashbn", url: "https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/260ee879bcbc416ba8dd310e1b6f7aa3/0e88df31-c89a-4d69-9c46-a9ab765cf287", notifyBuildStart: true, notifyAborted: true, notifyNotBuilt: true, notifyBackToNormal: true, notifyFailure: true, notifyRepeatedFailure: true, notifySuccess: true, notifyUnstable: true]
						])
						]
					)

					sh """
					set +e
					sudo /opt/puppetlabs/bin/puppet agent -t > puppet.out 2>&1
					"""
					}	
				}
					
		}
              	
		
		stage('Run Selenium Test')  {
			
			agent { label 'slave_node'}

				steps  {
						
					script	{
					properties (
						[office365ConnectorWebhooks([
							[name: "abhilashbn", url: "https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/260ee879bcbc416ba8dd310e1b6f7aa3/0e88df31-c89a-4d69-9c46-a9ab765cf287", notifyBuildStart: true, notifyAborted: true, notifyNotBuilt: true, notifyBackToNormal: true, notifyFailure: true, notifyRepeatedFailure: true, notifySuccess: true, notifyUnstable: true]
						])
						]
					)
					}
					sh """
					sudo docker build -t devopsedu/webapp '/home/ubuntu/jenkins/workspace/Run_Selenium_Test/'
					sudo docker run -itd -p 8082:80 devopsedu/webapp
					sudo docker ps -a
					"""
					
					script{
				
						def test_id=[] //Groovy Array List to store the list of Test IDs associated with the Story ID 
						def test_key=[] //Groovy Array List to store the list of Test Keys associated with the Story ID 
						env.StoryId="DEL-1"
						sh """
						bash -c \" source ./get_test_ids.sh ${GITHUB_COMMON_CREDS_USR} ${GITHUB_COMMON_CREDS_PSW} ${env.StoryId} \" > get_testids_response
						bash -c \" source ./get_test_keys.sh ${GITHUB_COMMON_CREDS_USR} ${GITHUB_COMMON_CREDS_PSW} ${env.StoryId} \" > get_testkeys_response
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
							cd "/opt/jenkins_home/jobs/Deloitte_Pipeline/branches/master/workspace/"
							sudo su -c \"java -jar /home/ubuntu/jenkins/workspace/Deloitte_Pipeline/AppTest.jar\" ubuntu
							bash -c \" source ./update_passed_test.sh ${GITHUB_COMMON_CREDS_USR} ${GITHUB_COMMON_CREDS_PSW} ${test_id[i]} \"
							"""
							i++
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
							[name: "abhilashbn", url: "https://outlook.office.com/webhook/5c913c5c-6bc4-4767-a579-b6b67683555e@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/260ee879bcbc416ba8dd310e1b6f7aa3/0e88df31-c89a-4d69-9c46-a9ab765cf287", notifyBuildStart: true, notifyAborted: true, notifyNotBuilt: true, notifyBackToNormal: true, notifyFailure: true, notifyRepeatedFailure: true, notifySuccess: true, notifyUnstable: true]
						])
						]
					)

					sh """
					sudo docker rm -f \$(sudo docker ps -a -q)
					"""
					}	
				}
					
		}
    }         
    post {
	
		failure  {

			node ( 'slave_node' )	{
				script	{
					echo 'Test failed'
                  			sh """
                    			tid=\$(cat tid_temp)
                    			echo "\${tid}"
                   			bash -c \" source ./update_failed_test.sh ${GITHUB_COMMON_CREDS_USR} ${GITHUB_COMMON_CREDS_PSW} \${tid}\"
					sudo docker rm -f \$(sudo docker ps -a -q)
                    			"""
        			}
			}
		}
	 }
}
