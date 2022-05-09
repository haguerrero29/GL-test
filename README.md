# GL-test
test for Gorilla Logic


Repository Structure:

  - IaC: folder with the infrastructure code to support TimeOff App.

  - Documentation: folder with the diagrams for the proposed architecture and the CI/CD flow.


Infrastructure Management

Infrastructure currently deployed on AWS. All the services are managed with terraform code.

Configured services:

  - VPC
  
  - Application load balancer
  
  - Security groups
  
  - Internet gateway
  
  - EC2 Autocalling
  
  - EC2 Instance

CI/CD Flow
___________

Time Off Repository: https://github.com/haguerrero29/timeoff-management-application.git

For the master branch a webhook was configured which triggers the jenkins pipeline. This performs the deployment of the new version by updating the auto scaling group.
To push new changes, copy the repository then make your changes to the master branch and push them. Within 8 min you will see the changes reflected on the server.


To watch the App open http://gl-timeoff-alb-292200254.us-east-1.elb.amazonaws.com in your browser
