"""
Starts a Tornado static file server in a given directory.
"""
import os
import sys

import tornado.ioloop
import tornado.web


class Handler(tornado.web.StaticFileHandler):
    def parse_url_path(self, url_path):
        if not url_path or url_path.endswith('/'):
            url_path = url_path + 'index.html'
        return url_path


def mkapp(prefix='', local_path='.'):
    if prefix:
        path = '/' + prefix + '/(.*)'
    else:
        path = '/(.*)'

    application = tornado.web.Application([
        (path, Handler, {'path': local_path}),
    ], debug=True)

    return application


def start_server(prefix='', port=8000, path='.'):
    app = mkapp(prefix, path)
    app.listen(port)
    tornado.ioloop.IOLoop.instance().start()


if __name__ == '__main__':
    letter = "d" if os.path.exists("d:") else "c:"
    path = letter + ":\\jenkins\\documentation"
    print("Serving from", path)
    start_server("", 8886, path=path)
