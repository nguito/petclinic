✅ Résumé des objectifs

Déployer Spring PetClinic (application Java Spring Boot) sur Kubernetes.
Utiliser Minikube comme cluster local.
Composants :

PetClinic : 2 réplicas, exposée via Service (port 8080).
MySQL : 1 instance avec PVC (persistance), port 3306.


Sécurité : Secrets pour credentials, pas de mot de passe en clair.
Observabilité : Metrics Server, logs accessibles.
Documentation complète (README, architecture, screenshots).


🛠 Plan d’action pour Windows 11 avec Minikube


Installer l’environnement

Installe Docker Desktop (avec Kubernetes désactivé).
Installe Minikube :
PowerShellchoco install minikube kubernetes-cliAfficher plus de lignes

Vérifie l’installation :
PowerShellminikube start --driver=dockerkubectl version --clientAfficher plus de lignes




Cloner le projet Spring PetClinic
Shellgit clone https://github.com/spring-projects/spring-petclinic.gitcd spring-petclinicAfficher plus de lignes


Créer l’image Docker

Ajoute un Dockerfile multi-stage (build + runtime).
Build et tester localement :
Shelldocker build -t petclinic:latest .docker run -p 8080:8080 petclinic:latestAfficher plus de lignes




Déployer sur Minikube

Crée un namespace :
Shellkubectl create namespace petclinicAfficher plus de lignes

Déploie MySQL avec PVC + Secret :

mysql-deployment.yaml
mysql-pvc.yaml
mysql-secret.yaml


Déploie PetClinic :

petclinic-deployment.yaml (2 replicas, ConfigMap, probes, resources).
petclinic-service.yaml (NodePort ou LoadBalancer).





Exposer l’application
Shellminikube service petclinic-service -n petclinic --urlAfficher plus de lignes


Monitoring
Shellminikube addons enable metrics-serverkubectl top pods -n petclinicAfficher plus de lignes


Validation

Vérifie les pods :
Shellkubectl get pods -n petclinicAfficher plus de lignes

Teste la persistance (supprime un pod MySQL et vérifie les données).
Prends des screenshots pour la doc.




📂 Structure recommandée du repo
.
├── manifests/
│   ├── mysql-deployment.yaml
│   ├── mysql-pvc.yaml
│   ├── mysql-secret.yaml
│   ├── petclinic-deployment.yaml
│   ├── petclinic-service.yaml
├── Dockerfile
├── README.md
└── docs/
    ├── architecture.md
    └── screenshots/