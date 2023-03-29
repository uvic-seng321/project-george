from db import get_db

db = get_db()

def send_query(query, args):
    db.reconnect()
    cur = db.cursor()
    cur.execute(query, args)
    result = cur.fetchall()
    db.commit()
    db.close()
    return result

def send_upload_post(args):
    db.reconnect()
    cur = db.cursor()
    cur.callproc("george.uploadPost", args)
    result = cur.fetchall()
    db.commit()
    db.close()
    return result

def send_get_posts(args):
    db.reconnect()
    cur = db.cursor()
    cur.callproc("george.getPosts", args)
    result = [r.fetchall() for r in cur.stored_results()]
    db.commit()
    db.close()
    return result[0]