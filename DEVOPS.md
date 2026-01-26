## 1. Setup Guide
Repository Structure

Make sure your GitHub repository contains all the necessary files:

Assignment-devops/           # Root folder
├── backend/                 # Django backend code
├── frontend/                # React frontend (Vite)
├── Dockerfile               # Multi-stage Dockerfile for fullstack app
├── docker-compose.yml       # Compose file for backend + frontend
├── .github/
│   └── workflows/
│       └── ci-cd.yml        # GitHub Actions workflow for CI/CD
├── terraform/               # Terraform scripts (optional)
│   ├── main.tf
│   ├── variables.tf
│   └── terraform.tfvars
├── DEVOPS.md                # Documentation
├── README.md
└── screenshots/
    └── app_running.png      # Screenshot of app in local/prod


1. Setup Guid

Clone the repository:

git clone https://github.com/Rushi6402/Assignment-devops.git
cd Assignment-devops/repair-app/devops-assessment


2. Build the Docker image:

docker build -t node-app:latest .


3. Run the Docker container:

docker run -d -p 8000:8000 -p 5173:5173 node-app:latest

4. Access the applocations:


Django Backend: http://198.168.0.135:8000
React frontend: http://198.168.0.135:5173	

2. Server Setup (Terraform)

Go to the Terraform folder:

cd terraform


Edit terraform.tfvars to include your VM details:

vm_ip = "192.168.0.135"
ssh_user = "rushi"
ssh_private_key_path = "/home/rushi/.ssh/id_rsa"


Initialize Terraform:

 Backend: http://192.168.0.135:8000
React Frontend: http://192.168.0.135:5173

Evaluation Criteria

Best Practices**  | Multi-stage Docker builds, use of `.dockerignore`, optimized and small image sizes 
Security**        | Non-root users in containers, no hardcoded secrets or API keys                     
Automation**      | CI/CD pipeline works automatically on a fresh push using GitHub Actions            Documentation**   | Clear setup instructions; a teammate can follow without asking questions           
Problem Solving** | Documented challenges faced during setup and deployment, with solutions            
