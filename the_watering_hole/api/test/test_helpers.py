from api import db

def upload_url(user : int = 1, 
            lat : float = 1, 
            long : float = 1, 
            tags = []):
    '''Create a url for the uploadPost endpoint'''

    req = "/uploadPost?"
    req += "user=" + str(user) 
    req += "&latitude=" + str(lat)
    req += "&longitude=" + str(long)
    req += "".join(["&tags=" + tag for tag in tags])
    return req
    
def get_url(pageNum : int = 1,
            lat : float = None,
            long : float = None,
            radius : float = None,
            tags = [],):
    '''Create a url for the getPosts endpoint'''

    req = "/getPosts?"
    req += "pageNum=" + str(pageNum)
    if lat is not None:
        req += "&latitude=" + str(lat)
    if long is not None:
        req += "&longitude=" + str(long)
    if radius is not None:
        req += "&radius=" + str(radius)
    req += "".join(["&tags=" + tag for tag in tags])
    return req

def reset_db():
    '''Empty the database'''
    cur = db.connection.cursor()
    # TODO it would be better to have this as a stored procedure in the test DB
    cur.execute("DELETE * FROM Posts")
    cur.execute("DELETE * FROM Tags")
    cur.fetchall()
    cur.close()
    db.connection.commit()
