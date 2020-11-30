#!/bin/bash
set -e
 
docker-compose down --volumes
docker rmi mde_apache mde_php
