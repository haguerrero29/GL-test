# GL-test
test for Gorilla Logic


Repository Structure:

  - IaC: folder with the infrastructure code to support TimeOff App.

  - Documentation: folder with the diagrams for the proposed architecture and the CI/CD flow.


Infrastructure Management

Infrastructure currently deployed on AWS. All the services are managed with terraform code.
Configured services:
  -VPC
  -Application load balancer
  -Security groups
  -Internet gateway
  -EC2 Autocalling
  -EC2 Instance
