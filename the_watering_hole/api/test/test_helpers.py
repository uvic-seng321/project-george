def upload_url(user : int = 1, 
            lat : float = 1, 
            long : float = 1, 
            tags = []):
    '''Create a url for the uploadPost endpoint'''

    req = "/posts/uploadPost?"
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

    req = "/posts/getPosts?"
    req += "pageNum=" + str(pageNum)
    if lat is not None:
        req += "&latitude=" + str(lat)
    if long is not None:
        req += "&longitude=" + str(long)
    if radius is not None:
        req += "&radius=" + str(radius)
    req += "".join(["&tags=" + tag for tag in tags])
    return req
