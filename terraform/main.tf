terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.0.0"
    }
  }
}

# -----------------------------
# Variables
# -----------------------------
variable "vm_ip" {
  description = "IP address of the VM"
  type        = string
}

variable "ssh_user" {
  description = "SSH username for the VM"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key"
  type        = string
}

# -----------------------------
# Resource: Deploy Web App
# -----------------------------
resource "null_resource" "deploy_app" {
  triggers = {
    vm_ip = var.vm_ip
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = var.vm_ip
      user        = var.ssh_user
      private_key = file(var.ssh_private_key_path)
      timeout     = "5m"
    }

    inline = [
      # Update system and install dependencies
      "sudo apt-get update -y",
      "sudo apt-get install -y python3-pip python3-venv nodejs npm git",

      # Clone repo (skip if already exists)
      "git clone https://github.com/Rushi6402/Assignment-devops.git /home/${var.ssh_user}/app || true",

      # Setup Django backend
      "cd /home/${var.ssh_user}/app/backend",
      "python3 -m venv venv",
      "source venv/bin/activate && pip install --upgrade pip",
      "source venv/bin/activate && pip install -r requirements.txt",

      # Start Django backend in background
      "nohup bash -c 'source venv/bin/activate && python manage.py runserver 0.0.0.0:8000' >/home/${var.ssh_user}/django.log 2>&1 &",

      # Setup React frontend
      "cd /home/${var.ssh_user}/app/frontend",
      "npm install",

      # Start React frontend in background
      "nohup npm run dev -- --host >/home/${var.ssh_user}/vite.log 2>&1 &"
    ]
  }
}

# -----------------------------
# Outputs
# -----------------------------
output "django_url" {
  description = "Django backend URL"
  value       = "http://${var.vm_ip}:8000"
}

output "frontend_url" {
  description = "React frontend URL"
  value       = "http://${var.vm_ip}:5173"
}

