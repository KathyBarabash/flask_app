from flask import Flask
#render_template
#flash, redirect, url_for, session, request, logging
#from data import Articles
# from flask_mysqldb import MySQL
# from wtforms import Form, StringField, TextAreaField, PasswordField, validators
# from passlib.hash import sha256_crypt
# from functools import wraps

app = Flask(__name__)

# # Config MySQL
# app.config['MYSQL_HOST'] = 'localhost'
# app.config['MYSQL_USER'] = 'root'
# app.config['MYSQL_PASSWORD'] = '123456'
# app.config['MYSQL_DB'] = 'myflaskapp'
# app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
# # init MYSQL
# mysql = MySQL(app)

# #Articles = Articles()

# Index
@app.route('/')
def index():
    return ('PRIVET')

if __name__ == '__main__':
    app.run()