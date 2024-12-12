# backend/app/__init__.py

from flask import Flask
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_restx import Api
from .config import Config, DevelopmentConfig, TestingConfig, ProductionConfig
import os

db = SQLAlchemy()
migrate = Migrate()

def create_app(config_class=None):
    """Application factory for creating Flask app instances."""
    app = Flask(__name__)

    # Determine the configuration to use based on FLASK_ENV
    env = os.getenv('FLASK_ENV', 'development').lower()
    if env == 'production':
        config_class = ProductionConfig
    elif env == 'testing':
        config_class = TestingConfig
    else:
        config_class = DevelopmentConfig

    app.config.from_object(config_class)

    # Validate configuration if available
    if hasattr(config_class, "validate"):
        config_class.validate()

    print("DEBUG (create_app): SQLALCHEMY_DATABASE_URI in config:", app.config.get("SQLALCHEMY_DATABASE_URI"))

    # Enable Cross-Origin Resource Sharing (CORS)
    CORS(app, resources={r"/api/*": {"origins": "*"}})  # Adjust origins as needed for security

    # Initialize database and migrations
    db.init_app(app)
    migrate.init_app(app, db)

    # Initialize Flask-RESTx API
    api = Api(
        app,
        version='1.0',
        title='Todo Management API',
        description='API documentation for Todo Management System',
        doc='/api/docs',  # Swagger UI available at /api/docs
        strict_slashes=False  # Disable strict slash enforcement globally
    )

    # Import and register namespaces
    from .routes.main import main_bp
    from .routes.helloworld import helloworld_bp
    from .routes.todos import todos_bp

    # Register namespaces with specific paths
    api.add_namespace(main_bp, path='/api')  # Main route
    api.add_namespace(helloworld_bp, path='/api/helloworld')  # Hello World route
    api.add_namespace(todos_bp, path='/api/todos')  # Todos routes

    return app
