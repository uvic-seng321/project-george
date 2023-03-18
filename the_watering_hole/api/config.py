from dotenv import load_dotenv
import os
load_dotenv()

class Config:
   MYSQL_HOST = os.getenv("MYSQL_HOST")
   MYSQL_USER = os.getenv("MYSQL_USER")
   MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD")

class ProdConfig(Config):
    FLASK_ENV = 'production'
    DEBUG = False
    TESTING = False
    MYSQL_DB = os.getenv('PROD_DATABASE')

class DevConfig(Config):
    FLASK_ENV = 'development'
    DEBUG = True
    TESTING = True
    MYSQL_DB = os.getenv('DEV_DATABASE')