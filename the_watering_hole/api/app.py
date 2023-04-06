from flask import Flask

def create_app(testing = False):
    app = Flask(__name__)
    config = 'config.DevConfig' if testing else 'config.ProdConfig'
    app.config.from_object(config)
    app.app_context().push()
    with app.app_context():
        import db
        db.init_app(app)
        db.get_db()

    from posts import posts_api
    from home import home_api
    app.register_blueprint(posts_api, url_prefix='/posts')
    app.register_blueprint(home_api, url_prefix='/')
        
    return app

if __name__ == '__main__':
    app = create_app(testing = True)
    app.run(host='0.0.0.0', port=5000)