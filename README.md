# Elastic Beanstalk Flask React

``` markdown

elastic-beanstalk-flask-react/
├── backend/
│   ├── app/
│   │   ├── __init__.py
│   │   ├── config.py
│   │   ├── models.py
│   │   └── routes/
│   │       ├── main.py
│   │       ├── helloworld.py
│   │       └── todos.py
│   ├── wsgi.py
│   ├── requirements.txt
│   └── Procfile
├── frontend/
│   ├── package.json
│   ├── src/
│   ├── public/
│   └── dist/
├── prepare_production.sh
├── .platform/
│   └── nginx/
│       └── conf.d/
│           └── myapp.conf
└── production_build/
    ├── frontend_build/
    │   ├── index.html
    │   └── assets/
    └── flask_app.zip

````