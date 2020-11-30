#!/bin/bash

source .env

curl $APACHE_IP
curl $APACHE_IP/bad.php