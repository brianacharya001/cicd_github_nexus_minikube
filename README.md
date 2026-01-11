Here is a comprehensive `README.md` file designed for your project. It explains the architecture, how to set up the self-hosted runner, and how to trigger the deployment.

---

# Spring Boot Minikube CI/CD with Helm

This project demonstrates a complete automated pipeline to build, test, and deploy a **Spring Boot** application to a local **Minikube** cluster using **GitHub Actions (Self-Hosted Runner)** and **Helm**.

## 🚀 Architecture Overview

* **Framework:** Spring Boot 3.x (Java 17)
* **Build Tool:** Maven
* **Containerization:** Docker (Internal Minikube Registry)
* **Orchestration:** Kubernetes (Minikube)
* **Deployment:** Helm Charts
* **CI/CD:** GitHub Actions running on a **Self-Hosted Runner**

---

## 📂 Project Structure

```text
├── .github/workflows/deploy.yml  # Manual CI/CD Pipeline
├── charts/spring-app/            # Helm chart for Kubernetes deployment
│   ├── Chart.yaml                # Metadata about the chart
│   ├── values.yaml               # Configurable variables (Image, Ports)
│   └── templates/                # K8s Deployment & Service templates
├── src/                          # Java Source code & Tests
├── Dockerfile                    # Multi-stage build for the application
├── pom.xml                       # Maven dependencies
└── README.md                     # Project documentation

```

---

## 🛠 Prerequisites

Before running the pipeline, ensure the following are installed on your **Self-Hosted Runner machine**:

1. **Minikube:** Running via `minikube start`.
2. **Helm:** Installed via `curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash`.
3. **Java 17:** Installed and `JAVA_HOME` set.
4. **GitHub Runner Agent:** Configured and "Active" in your GitHub Repository Settings.

---

## 🔧 Setup & Local Testing

### 1. Run Locally

To test the application without Kubernetes:

```bash
./mvnw spring-boot:run

```

Access the health check at: `http://localhost:8080/health`

### 2. Manual Build & Docker Test

To simulate what the GitHub Action does:

```bash
# Point Docker to Minikube
eval $(minikube docker-env)

# Build JAR and Image
./mvnw package
docker build -t my-spring-app:latest .

```

---

## 🤖 CI/CD Pipeline (GitHub Actions)

The workflow is configured as `workflow_dispatch`, meaning it is triggered **manually** to prevent unnecessary local deployments.

### Workflow Steps:

1. **Checkout:** Pulls latest code.
2. **Build:** Compiles Java and runs **Unit/Smoke Tests**.
3. **Dockerize:** Builds the image directly inside the Minikube environment.
4. **Helm Deploy:** Deploys or upgrades the release using the local chart in `./charts/spring-app`.
5. **Expose:** Outputs the Minikube URL to access the app.

### How to Trigger:

1. Navigate to your repository on **GitHub**.
2. Click the **Actions** tab.
3. Select **Deploy Spring Boot (Self-Hosted Minikube)**.
4. Click **Run workflow**.

---

## 📝 Configuration Note

To ensure Kubernetes uses your locally built image instead of trying to pull it from Docker Hub, the `charts/spring-app/values.yaml` is set to:

```yaml
image:
  pullPolicy: IfNotPresent

```

---

## 🧪 Testing the Deployment

Once the Action finishes, run:

```bash
minikube service spring-boot-release --url

```

Append `/health` to the URL to verify the Spring Boot response.


