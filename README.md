## 📜 Overview

This project demonstrates a comprehensive DevOps pipeline for a Java web application. The pipeline automates the build, test, and deployment processes using Jenkins, Docker, and Ansible. The application is containerized and deployed on a virtual machine, accessible via http://localhost:8080/jpetstore.
![Untitled Diagram drawio](https://github.com/user-attachments/assets/42694951-c75a-4489-aeca-57acb7fb2edd)


## ⚙️ Tools & Technologies

   Version Control: Git, GitHub

   Build Automation: Maven

   Containerization: Docker

   Continuous Integration/Continuous Deployment: Jenkins

   Configuration Management: Ansible
   
   VMWare Vsphere

   Monitoring & Logging: Prometheus




## 📌 Setup & Execution Steps:
Follow these steps to set up the environment and run the CI/CD pipeline:
 
## 🖥️ 1. Create a Virtual Machine

   Launch a VM with Ubuntu 22.04.

   Install Docker and Ansible:

    sudo apt update
    sudo apt install docker.io ansible -y
 ![Screenshot (23)](https://github.com/user-attachments/assets/6a09c1da-1b3d-4d9d-bf72-40ce28c83b6c)
![Screenshot (24)](https://github.com/user-attachments/assets/09e4589d-a901-4c23-9907-403653603aef)
   Install Java_21
   ![Screenshot (37)](https://github.com/user-attachments/assets/541016d9-6474-4d58-95c3-8c2b58264d85)

## ⚙️2. Install & Configure Jenkins

   Install Jenkins on the VM.
![Screenshot (25)](https://github.com/user-attachments/assets/992d59e0-91ab-48f9-95cc-5b1c4414074b)

   Change Jenkins' default port to 9090 by editing the config file:

    sudo nano /etc/default/jenkins
  Change HTTP_PORT=8080 → HTTP_PORT=9090
![Screenshot (26)](https://github.com/user-attachments/assets/2ce16428-2636-44c5-9400-567784475f05)

  Restart Jenkins:

    sudo systemctl restart jenkins

   Access Jenkins at http://<VM-IP>:9090.
   Complete initial setup and install recommended plugins.
![image](https://github.com/user-attachments/assets/14f52f25-9b97-4393-87f2-93b2a46e7f4d)

## 🔧 3. Jenkins Pipeline Configuration

   Create a new Pipeline project in Jenkins.

   Under Pipeline → Definition, select "Pipeline script from SCM".

   Set the GitHub Repository URL of this project.
![Screenshot (27)](https://github.com/user-attachments/assets/0c4fa77c-3faa-414c-8bd4-f5b82d605737)
![Screenshot (28)](https://github.com/user-attachments/assets/748a151b-07b4-4d9c-a5a5-26b88c5d21b3)
![Screenshot (29)](https://github.com/user-attachments/assets/8d9903a0-2d4f-4ff8-b98e-6bc2f35b561c)

## 🔐 4. DockerHub Credentials

   In Jenkins, navigate to Manage Jenkins → Credentials.
![Screenshot (30)](https://github.com/user-attachments/assets/1d669b67-e5a9-4a91-9a2a-ba3ca378d5a6)
   Add your DockerHub username and password as a new credential.
![Screenshot (31)](https://github.com/user-attachments/assets/2ab1fac1-b86a-41eb-b037-ba9af0d8aba7)

## 🧩 5. Install Required Jenkins Plugins

Make sure the following plugins are installed:

   Docker Pipeline
![Screenshot (17)](https://github.com/user-attachments/assets/e9b50ec2-dd40-4c1f-9b55-34719f04e45f)

   Ansible
![Screenshot (16)](https://github.com/user-attachments/assets/a98ae878-ac83-436b-8dec-5f7771061edc)

Make sure JDK installation set in Jenkins Tools
 ![Screenshot (2)](https://github.com/user-attachments/assets/6edc612a-8a1c-403d-8493-fbc4a63a0ba4)

## 📈 6. Install & Configure Prometheus

   Install Prometheus on the VM.
![Screenshot (32)](https://github.com/user-attachments/assets/a7a333b8-22c0-4c39-936f-97e5e02c0a79)

   Change its default port to 9091 by editing the systemd service file:

    sudo nano /etc/systemd/system/prometheus.service
   Modify --web.listen-address=:9091
![Screenshot (33)](https://github.com/user-attachments/assets/1b0e0c77-0fd3-4bc2-ab42-ce413e6047d1)

   Add targets to prometheus.yml:

    static_configs:
     - targets: ['192.168.3.60:9100', 'localhost:9091']
![Screenshot (1701)](https://github.com/user-attachments/assets/08f35584-7bb4-4ad7-910f-2ac53fb99664)

   Restart Prometheus and access it at: http://localhost:9091
![Screenshot (1700)](https://github.com/user-attachments/assets/52f03c53-95e6-47f1-bebc-fdff2c89916e)

## 🚀 7. Run the CI/CD Pipeline

   Trigger the Jenkins pipeline.
![Screenshot (10)](https://github.com/user-attachments/assets/2a38a1cc-60e9-48ea-8745-4c85f8f8c81b)

  ## CI Stage:

   Code is built and tested with Maven

   Docker image is created and pushed to DockerHub
![Screenshot (19)](https://github.com/user-attachments/assets/e7ce22c8-94b3-4a3b-8e67-296a0163a057)

 ##  CD Stage:

   Ansible pulls the image from DockerHub

   Application is deployed in a container on the VM
![Screenshot (18)](https://github.com/user-attachments/assets/d4314b7c-1830-4ea4-81cc-27b0ae7f2ba3)

   Prometheus monitors the application
   
    docker exec -it jpetstore /bin/bash
    wget https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz 
    tar -xvzf node_exporter-1.9.1.linux-amd64.tar.gz
    mv node_exporter-1.9.1.linux-amd64/node_exporter /usr/local/bin/
    /usr/local/bin/node_exporter &
    http://192.168.3.60:9100/metrics

![Screenshot (1700)](https://github.com/user-attachments/assets/68761097-3bd8-4f94-bac2-123690e3919a)
![Screenshot (1702)](https://github.com/user-attachments/assets/6ec96cd3-d834-439f-9cb6-cb55418c6c82)
![Screenshot (1703)](https://github.com/user-attachments/assets/8e69ee2b-a3a5-496c-8939-2faa58786218)
   
##  🌐 8. Access the Application

   Visit the deployed application at:
     http://192.168.3.60:8080  
![Screenshot (21)](https://github.com/user-attachments/assets/990e347c-4b11-48f2-9f27-e342104a0b52)

     
## Note 

This application build is resulting a .war file not .jar as we saw before. This needs a change in the command that is used to run the application. We will use mvnw as well to run the application as shown below. Here's the command used to run the app:

./mvnw cargo:run -P tomcat90
