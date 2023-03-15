from dotenv import load_dotenv
import os
load_dotenv()

class Config:
   HOST = os.getenv("HOST")
   USER = os.getenv("USER")
   PASSWORD = os.getenv("PASSWORD")

class ProdConfig(Config):
    FLASK_ENV = 'production'
    DEBUG = False
    TESTING = False
    DATABASE = os.getenv('PROD_DATABASE')

class DevConfig(Config):
    FLASK_ENV = 'development'
    DEBUG = True
    TESTING = True
    DATABASE = os.getenv('DEV_DATABASE')