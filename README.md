# Elastic Beanstalk Flask React

``` markdown

elastic-beanstalk-flask-react/
├── backend/
│   ├── app/
│   │   └── __init__.py
│   │   └── config.py
│   │   └── routes/
│   ├── run.py
│   ├── wsgi.py
│   ├── Procfile
│   └── requirements.txt
├── frontend/
│   ├── src/
│   │   └── api/
│   │   └── App.tsx
│   ├── vite.config.ts
│   ├── vitest.config.ts
│   └── package.json
├── nginx-flask-react.conf
├── prepare_production.sh
├── production_build/
│   └── production_build.zip
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   ├── iam.tf
│   ├── s3.tf
│   ├── elastic_beanstalk.tf
│   └── outputs.tf
└── .gitignore


````