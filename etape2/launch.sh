#!/bin/bash
echo "=== Étape 2 : Lancement des containers Nginx, PHP-FPM et MariaDB ==="

# Nettoyage d'anciens containers
docker rm -f http script data 2>/dev/null

# Création du réseau
docker network create tp2_network 2>/dev/null || echo "Le réseau existe déjà"

# Container MariaDB
docker run -d \
  --name data \
  --network tp2_network \
  -e MARIADB_RANDOM_ROOT_PASSWORD=yes \
  -v $(pwd)/sql:/docker-entrypoint-initdb.d \
  mariadb:latest

# Container PHP (avec mysqli)
docker build -t php-mysqli ./php

docker run -d \
  --name script \
  --network tp2_network \
  -v $(pwd)/src:/app \
  php-mysqli

# Container Nginx
docker run -d \
  --name http \
  --network tp2_network \
  -p 8080:80 \
  -v $(pwd)/src:/app \
  -v $(pwd)/nginx/default.conf:/etc/nginx/conf.d/default.conf \
  nginx:latest

echo "=== Containers lancés ==="
echo "Test disponible sur : http://localhost:8080/test.php"
