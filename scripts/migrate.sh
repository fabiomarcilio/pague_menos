#!/bin/bash
docker-compose up -d
docker-compose exec app python manage.py migrate