## Create

eb init --region ap-southeast-2

eb create my-flask-react-env \
  --platform "Python 3.9" \
  --region ap-southeast-2 \
  --single

eb deploy my-flask-react-env \
  --region ap-southeast-2 \
  --label "my-flask-react-v1.0.0"

eb deploy my-flask-react-env --region ap-southeast-2


eb status my-flask-react-env --region ap-southeast-2

eb health my-flask-react-env --region ap-southeast-2

eb open my-flask-react-env --region ap-southeast-2

eb logs my-flask-react-env --region ap-southeast-2


## Destroy

eb terminate my-flask-react-env --region ap-southeast-2

aws elasticbeanstalk delete-application \
  --application-name my-flask-react-app \
  --region ap-southeast-2 \
  --terminate-env-by-force
