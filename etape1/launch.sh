#!/bin/bash
echo "=== Étape 1 : Lancement des containers Nginx et PHP-FPM ==="

# Arrêter et supprimer d'éventuels containers précédents
docker rm -f http script 2>/dev/null

# Créer un réseau Docker dédié
docker network create tp1_network 2>/dev/null || echo "Le réseau tp1_network existe déjà"

# Lancer le container PHP-FPM (SCRIPT)
docker run -d \
--name script \
--network tp1_network \
-v $(pwd):/app \
php:8.2-fpm

# Lancer le container Nginx (HTTP)
docker run -d \
--name http \
--network tp1_network \
-p 8080:80 \
-v $(pwd):/app \
-v $(pwd)/nginx/default.conf:/etc/nginx/conf.d/default.conf \
nginx:latest

echo "=== Containers lancés ==="
echo "Page PHP info accessible sur : http://localhost:8080/"
