#!/bin/bash
echo "=== Étape 1 : Lancement d’un conteneur nginx ==="

# Arrêter et supprimer les anciens conteneurs s’il y en a
docker stop $(docker ps -aq) 2>/dev/null
docker rm $(docker ps -aq) 2>/dev/null

# Lancer un conteneur nginx sur le port 8080
docker run -d --name web-tp3 -p 8080:80 nginx

echo "=== Conteneur nginx lancé sur http://localhost:8080 ==="
