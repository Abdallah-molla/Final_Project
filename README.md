### Final Java DevOps CI/CD project.

## Description 

This is a simple Java web app that needs to have an automated CI/CD using the DevOps toolset. The Application shall be running as a container on the same VM on port 8080. Test the application by visiting this URL http://localhost:8080/jpetstore.

## The used tools

- Git/Github -> clone the code.
- Maven -> build the code.
- Docker -> dockerize the app
- Jenkins -> CI/CD
- Ansible -> deploy by running a container of the app
- Terraform (Plus) -> to create the EC2 on AWS 
- AWS (plus) -> EC2 machine that shall run the pipeline and host the application

## The requirements

1- CI/CD pipeline that do as following 

CI:
- Clone the source code.
- Build the code using mvnw (already in the repo)
- Test the code using mvnw (already in the repo)
- Dockerize the application and push it to dockerhub

CD:
- Deploy the application by running a container from the image using Ansible.
- Apply the monitoring on the machine using Prometheus. 

2- Create the EC2 instance using terraform instead of using the local VM (Plus)

## The expected delevirable

Github repo containes 
- The src code.
- The Dockerfile
- The Jenkinsfile
- The Ansible Playbook

## Note 

This application build is resulting a .war file not .jar as we saw before. This needs a change in the command that is used to run the application. We will use mvnw as well to run the application as shown below. Here's the command used to run the app:

./mvnw cargo:run -P tomcat90

## 📌 Setup & Execution Steps:
Follow these steps to set up the environment and run the CI/CD pipeline:
 🖥️ 1. Create a Virtual Machine

    Launch a VM with Ubuntu 22.04.

    Install Docker and Ansible:

sudo apt update
sudo apt install docker.io ansible -y
 
⚙️ 2. Install & Configure Jenkins

    Install Jenkins on the VM.

    Change Jenkins default port to 9090 by editing the config file:

sudo nano /etc/default/jenkins
# Change HTTP_PORT=8080 → HTTP_PORT=9090

    Restart Jenkins:

sudo systemctl restart jenkins

    Access Jenkins at http://<VM-IP>:9090.

    Complete initial setup and install recommended plugins.
🔧 3. Jenkins Pipeline Configuration

    Create a new Pipeline project in Jenkins.

    Under Pipeline → Definition, select "Pipeline script from SCM".

    Set the GitHub Repository URL of this project.
🔐 4. DockerHub Credentials

    In Jenkins, navigate to Manage Jenkins → Credentials.

    Add your DockerHub username and password as a new credential.
🧩 5. Install Required Jenkins Plugins

Make sure the following plugins are installed:

    Docker Pipeline

    Ansible

    Git
📈 6. Install & Configure Prometheus

    Install Prometheus on the VM.

    Change its default port to 9091 by editing the systemd service file:

sudo nano /etc/systemd/system/prometheus.service
# Modify --web.listen-address=:9091

    Add targets to prometheus.yml:

static_configs:
  - targets: ['<VM-IP>:8080', 'localhost:9091']

    Restart Prometheus and access it at: http://localhost:9091
🚀 7. Run the CI/CD Pipeline

    Trigger the Jenkins pipeline.

    CI Stage:

        Code is built and tested with Maven

        Docker image is created and pushed to DockerHub

    CD Stage:

        Ansible pulls the image from DockerHub

        Application is deployed in a container on the VM

        Prometheus monitors the application
    🌐 8. Access the Application

     Visit the deployed application at:
     http://<VM-IP>:8080  
  
