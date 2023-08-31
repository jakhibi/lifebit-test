# Lifebit Test App
![Architecture flow](https://github.com/jakhibi/lifebit-test/blob/main/lifebit-test.png)

This is a Micro-service based application that will:
## Setup an EKS Cluster on AWS
Build a Node.js Docker Image,
Deploy the image to the EKS Cluster using a yaml declarative scrpits in Helm chart.

## Setup an EKS Cluster on AWS
Terraform is used to Setup the Kubernetes Cluster, on AWS. It will first setup the network sytem, the VPC, NAT, Subnets and all the system requires to run the Kubernetes cluster and applications within the infrastructure.

The terraform code (configuration file) is located in the Terraform-infra directory. The workflow to deploy this is to use:

```hcl
terraform init
terraform plan
terraform apply --auto-approve
```

There is also a workflow that is used to trigger when the build steps found in .github/workflows/eks.yml file. When a pull request is made to the lifebit branch, the pipeline will be automatically triggered to run the terraform scripts for infrastructure deployment (on approval of the request.) At the completion of this step, a new workflow is automatically initiated to start the workflow, .github/workflow/app-deploy.yml, for the deployment of the application.

## Build a Node.js Docker Image
The lifebit-app/ directory contain the application. It also contains the Dockerfile which is used to build the Docker image and all its dependencies. The Docker image is built based on the configurations of the Dockerfile. It uses a node:apline based image for optimal image that is small enough and has all the necessary pre-requisite for the application to run.

## Deploy image to the EKS Cluster using kubernetes
A deployment is automatically triggered whenever a push is done to the Github main branch. The application is deployed using Github actions. .github/workflows/app-deploy.yml is the pipeline configuration. The pipeline has the following steps/actions:

## Setup Job
-Checkout code
-Configure AWS credentials for authorization and authentication
-Setup Docker CLI
-Authenticate with Docker Hub
-Build the Docker image and push to Docker registry
-Install Helm Binary 
-Deploy Application via Helm Chart

### Note: 
Autoscaling of the nodes is controlled by the AWS autoscaling groups configured in the eks.tf file.


## Security Features in Setup
Docker image is stored in a private repository in Dockerhub making the image not accessible over the internet

Alpine base image was used to build the Docker image making it a slim image, therefore reducing the surface area of attack

The credentials used for terraform, and Github Actions deployment are stored in Github secrets.
VPC/Network configuration has a public and private subnet. Private subnet helps to protect the worker nodes from public internet access.

For AWS access, I have deployed a IAM user with with Administrator access. I will also be sending in the "access key and secrete access key" just for this deployment. I will terminate access from the IAM user in a latter date, after your review.

### Note: 
Commented steps of the build action. I have written the commands to simulate traffic in and out of the application with corresponding scalling of the pods. If I had more time, going forward, I will implement the stress and load test that was commented out.  
