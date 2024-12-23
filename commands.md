# Commands


# Venv

source backend/venv/bin/activate


## Production Build Scripts

chmod +x deployment/prepare_production.sh

./deployment/prepare_production.sh


## Running Gunicorn (Flask API)

gunicorn --chdir backend --bind 0.0.0.0:5001 wsgi:application


## Running React App

serve -s backend/static -l 3000


### Running Nginx

nginx -t

ps aux | grep nginx

tail -f /opt/homebrew/var/log/nginx/error.log

brew services start nginx


# Testing Nginx

curl -I http://localhost:8080/

curl http://localhost:8080/

curl -I http://localhost:8080/api/todos/

curl http://localhost:8080/api/todos/



## Testing API Endpoints

curl http://localhost:5001/api/

curl http://localhost:5001/api/helloworld/

curl http://localhost:5001/api/todos/


## Port Processes

lsof -i :3000
lsof -i :5001

kill -9 <PID>


## Nginx Config file

code /opt/homebrew/etc/nginx/nginx.conf


## Terraform

terraform -chdir=terraform init -upgrade
terraform -chdir=terraform plan
terraform -chdir=terraform apply

terraform -chdir=terraform destroy


## Logs

aws elasticbeanstalk request-environment-info --environment-name my-custom-env --info-type tail

aws elasticbeanstalk retrieve-environment-info --environment-name my-custom-env --info-type tail
