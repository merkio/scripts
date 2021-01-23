#!/usr/bin/env bash
docker run -p 8080:8080 -p 50000:50000 -v /home/ishaman/jenkins_data:/opt/www/jenkins jenkins/jenkins:lts
