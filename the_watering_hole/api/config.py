from dotenv import load_dotenv
import os
load_dotenv()

class Config:
   MYSQL_HOST = os.getenv("MYSQL_HOST")
   MYSQL_USER = os.getenv("MYSQL_USER")
   MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD")
   MYSQL_DB = os.getenv('MYSQL_DB')

class ProdConfig(Config):
    FLASK_ENV = 'production'
    DEBUG = False
    TESTING = False

class DevConfig(Config):
    FLASK_ENV = 'development'
    DEBUG = True
    TESTING = True