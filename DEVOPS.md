## 1. Setup Guide


1. Setup Guide
Local Setup (Docker)

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



