Flask App
---
> to learn how this stuff works

> to get experience with python project structuring options

This simple web app is created following [Python Flask from Scratch](https://www.youtube.com/playlist?list=PLillGF-RfqbbbPz6GSEM9hLQObuQjNoj_) tutorial series by [TraversyMedia](https://www.youtube.com/@TraversyMedia).

## Prerequisits
- python3.12 with pip
- git
- make

## Building the app from zero

### 0-EmptyProject

#### Environment
- Ubuntu24 on WSL (reuse the existing image)
- python3.12 with pip
- git
- make
```
$ pip --version
pip 24.0 from /usr/lib/python3/dist-packages/pip (python 3.12)

$ make --version
GNU Make 4.3
Built for x86_64-pc-linux-gnu
Copyright (C) 1988-2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

$ git --version
git version 2.43.0
```

#### Repository

- Create project folder and nitialize local git rep[ository]
```
$ mkdir Projects/py/flask_app
$ cd Projects/py/flask_app
git init
hint: Using 'master' as the name for the initial branch. This default branch name
hint: is subject to change. To configure the initial branch name to use in all
hint: of your new repositories, which will suppress this warning, call:
hint:
hint:   git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint:
hint:   git branch -m <name>
Initialized empty Git repository in /home/me/Projects/py/flask_app/.git/
```

- Configure the local repository
```
$ git config -l --show-origin --show-scope
local   file:.git/config        core.repositoryformatversion=0
local   file:.git/config        core.filemode=true
local   file:.git/config        core.bare=false
local   file:.git/config        core.logallrefupdates=true

# set name/email locally
git config --local user.name "Kathy Barabash"
git config --local user.email kathybarabash@gmail.com

# if no global settings, add
git config --global core.editor vim
git config --global alias.st status 
git config --global alias.co checkout 
git config --global alias.br branch 
git config --global alias.up rebase 
git config --global alias.ci commit
```

- Create an empty public github repository `git@github.com:KathyBarabash/flask_app.git` and configure the local repository to be connected to the remote
```
git remote add origin git@github.com:KathyBarabash/flask_app.git
git branch -M main
```
#### The Fist Commit
- Create
    - README.md (this file)
    - .gitignore (emppty)
    - LICENSE (empty) 
- Add as fist commit
```
$ git add .gitignore LICENSE README.md

$ git commit -m "initial commit"
[main (root-commit) 792f22d] initial commit
 3 files changed, 51 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 LICENSE
 create mode 100644 README.md

$ git log --oneline --decorate
792f22d (HEAD -> main) initial commit

$ git push -u origin main
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

To resolve, had to change the remote url per what is configired in my `~/.ssh/config` : 
```
remote.origin.url=git@gh-i:KathyBarabash/flask_app.git

# in ~/.ssh/config

# Public github as kathy@il.ibm.com and kathybarabash@gmail.com
# to test: ssh -T git@gh-i
Host gh-i
	HostName github.com
	User git
	IdentityFile ~/.ssh/kathy4ibm_ed25519.prv
	HostkeyAlgorithms +ssh-rsa
	PubkeyAcceptedAlgorithms +ssh-rsa
	UserKnownHostsFile ~/.ssh/known_hosts
	ForwardAgent yes
	IdentitiesOnly yes
```

### 1_TheApp

#### Minimal functioning server
- Created Makefile with generic targets
- Created pyproject.toml
- Created app structure in `src/app/` with the main module `app.py`

- Test 
```
$ make help

$ make new_env
$ source .venv/bin/activate

$ make install
$ pip list
Package      Version Editable project location
------------ ------- ------------------------------
blinker      1.9.0
click        8.1.7
Flask        3.1.0
flask_app    0.1.0   /home/me/Projects/py/flask_app
itsdangerous 2.2.0
Jinja2       3.1.4
MarkupSafe   3.0.2
pip          24.3.1
Werkzeug     3.1.3

$ make run_server
Installing production dependencies
Obtaining file:///home/me/Projects/py/flask_app
  Installing build dependencies ... done
  Checking if build backend supports build_editable ... done
  Getting requirements to build editable ... done
  Preparing editable metadata (pyproject.toml) ... done
Requirement already satisfied: flask in ./.venv/lib/python3.12/site-packages (from flask_app==0.1.0) (3.1.0)
Requirement already satisfied: Werkzeug>=3.1 in ./.venv/lib/python3.12/site-packages (from flask->flask_app==0.1.0) (3.1.3)
Requirement already satisfied: Jinja2>=3.1.2 in ./.venv/lib/python3.12/site-packages (from flask->flask_app==0.1.0) (3.1.4)
Requirement already satisfied: itsdangerous>=2.2 in ./.venv/lib/python3.12/site-packages (from flask->flask_app==0.1.0) (2.2.0)
Requirement already satisfied: click>=8.1.3 in ./.venv/lib/python3.12/site-packages (from flask->flask_app==0.1.0) (8.1.7)
Requirement already satisfied: blinker>=1.9 in ./.venv/lib/python3.12/site-packages (from flask->flask_app==0.1.0) (1.9.0)
Requirement already satisfied: MarkupSafe>=2.0 in ./.venv/lib/python3.12/site-packages (from Jinja2>=3.1.2->flask->flask_app==0.1.0) (3.0.2)
Building wheels for collected packages: flask_app
  Building editable for flask_app (pyproject.toml) ... done
  Created wheel for flask_app: filename=flask_app-0.1.0-0.editable-py3-none-any.whl size=2397 sha256=38dab3c0b00b6fd2c599d5417893b5ecda61de0334da658ea95acd0e5cff7868
  Stored in directory: /tmp/pip-ephem-wheel-cache-x1r0z6sc/wheels/e0/13/6f/abbcc57da365d0008b2ac734a4948ca3a8727923bbb84a91ba
Successfully built flask_app
Installing collected packages: flask_app
  Attempting uninstall: flask_app
    Found existing installation: flask_app 0.1.0
    Uninstalling flask_app-0.1.0:
      Successfully uninstalled flask_app-0.1.0
Successfully installed flask_app-0.1.0
Starting the server in src/app/app.py
 * Serving Flask app 'app'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on http://127.0.0.1:5000
Press CTRL+C to quit
```
Now open the browser and see PRIVET :-)
```
$ git commit -m "minimal functioning app server"
$ git push 
```

#### Check on win
2024-12-19
Run into all kind of problems.
Suspected toml but it turned out to be make.
Found great source and ammended make to suite both ubuntu and gitbash on windows.

#### Navigation, routes to serve dummy data
- debug=True to auto reload on save
- render_template for home.html
- added layout.html with `block body` and `endblock` - these must be the names
- added styles and navbar to layout 
  - did not work so well probably because different versions of bootstrap template, will have to figure this out
- add routes for about, articles, articles/<string:id>

Pushed and tested on win.

#### Database
- Install mysql. 
- First installed following instructions but failed to login: 
```
$ sudo apt install mysql-server libmysqlclient-dev
$ mysql -u me -p
Enter password:
ERROR 1045 (28000): Access denied for user 'me'@'localhost' (using password: YES)
```
- Followed some strange [instructions](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-22-04) and run security configuration script only to understand that first invokation should be `sudo mysql`
```
$ sudo mysql_secure_installation

Securing the MySQL server deployment.

Connecting to MySQL using a blank password.

VALIDATE PASSWORD COMPONENT can be used to test passwords
and improve security. It checks the strength of password
and allows the users to set only those passwords which are
secure enough. Would you like to setup VALIDATE PASSWORD component?

Press y|Y for Yes, any other key for No:

Skipping password set for root as authentication with auth_socket is used by default.
If you would like to use password authentication instead, this can be done with the "ALTER_USER" command.
See https://dev.mysql.com/doc/refman/8.0/en/alter-user.html#alter-user-password-management for more information.

By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.

Remove anonymous users? (Press y|Y for Yes, any other key for No) :

 ... skipping.


Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.

Disallow root login remotely? (Press y|Y for Yes, any other key for No) : y
Success.

By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.


Remove test database and access to it? (Press y|Y for Yes, any other key for No) :

 ... skipping.
Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.

Reload privilege tables now? (Press y|Y for Yes, any other key for No) :

 ... skipping.
All done!
(.venv)
```
- Found better [instructions](https://documentation.ubuntu.com/server/how-to/databases/install-mysql/?_ga=2.61211564.1046401491.1734642754-1999842672.1734642754&_gl=1*etru14*_gcl_au*MTA1NDkwOTk0MC4xNzM0NjQyNzU4) :

```
$ sudo apt install mysql-server

$ sudo service mysql status
[sudo] password for me:
● mysql.service - MySQL Community Server
     Loaded: loaded (/usr/lib/systemd/system/mysql.service; enabled; preset: enabled)
     Active: active (running) since Thu 2024-12-19 22:41:57 IST; 12h ago
    Process: 52411 ExecStartPre=/usr/share/mysql/mysql-systemd-start pre (code=exited, status=0/>
   Main PID: 52419 (mysqld)
     Status: "Server is operational"
      Tasks: 39 (limit: 4696)
     Memory: 368.4M ()
     CGroup: /system.slice/mysql.service
             └─52419 /usr/sbin/mysqld

Dec 19 22:41:56 u24 systemd[1]: Starting mysql.service - MySQL Community Server...
Dec 19 22:41:57 u24 systemd[1]: Started mysql.service - MySQL Community Server.

$ sudo ss -tap | grep mysql
LISTEN 0      151         127.0.0.1:mysql       0.0.0.0:*     users:(("mysqld",pid=52419,fd=23))

LISTEN 0      70          127.0.0.1:33060       0.0.0.0:*     users:(("mysqld",pid=52419,fd=21))

$ sudo journalctl -u mysql
Dec 19 22:41:56 u24 systemd[1]: Starting mysql.service - MySQL Community Server...
Dec 19 22:41:57 u24 systemd[1]: Started mysql.service - MySQL Community Server.
```

2024-12-20
- inspect config file: `/etc/mysql/mysql.conf.d/mysqld.cnf`
- inspect error log file: `/var/log/mysql/error.log`
- learn about the builtin backup utility `mysqldump`:
```
# to backup
$ mysqldump [database name] > dump.sql
$ mysqldump -u root [database name] > dump.sql

to restore
$ mysql -u root [database name] < dump.sql
```

bask to digital ocean:
```
$sudo mysql
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root4sql';
Query OK, 0 rows affected (0.01 sec)

mysql> ALTER USER 'me'@'localhost' IDENTIFIED WITH mysql_native_password BY 'kathy4sql';
ERROR 1396 (HY000): Operation ALTER USER failed for 'me'@'localhost'

$ mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 25
Server version: 8.0.40-0ubuntu0.24.04.1 (Ubuntu)

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> exit

# to get back to passwordless option, enter and:
>mysql ALTER USER 'root'@'localhost' IDENTIFIED WITH auth_socket;
```

```
sudo mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 32
Server version: 8.0.40-0ubuntu0.24.04.1 (Ubuntu)

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)

mysql> create database flaskapp;
Query OK, 1 row affected (0.03 sec)

mysql> use flaskapp;
Database changed
mysql> CREATE TABLE users(id INT(11) AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), email VARCHAR(100), username VARCHAR(30), password VARCHAR(100), register_date TIMESTAMP CURRENT_TIMESTAMP);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'CURRENT_TIMESTAMP)' at line 1
mysql> CREATE TABLE users(id INT(11) AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), email VARCHAR(100), username VARCHAR(30), password VARCHAR(100), register_date TIMESTAMP DEFAULT CURRENT_TIMES
TAMP);
Query OK, 0 rows affected, 1 warning (0.10 sec)
mysql> show tables;
+--------------------+
| Tables_in_flaskapp |
+--------------------+
| users              |
+--------------------+
1 row in set (0.00 sec)

mysql> describe users;
+---------------+--------------+------+-----+-------------------+-------------------+
| Field         | Type         | Null | Key | Default           | Extra             |
+---------------+--------------+------+-----+-------------------+-------------------+
| id            | int          | NO   | PRI | NULL              | auto_increment    |
| name          | varchar(100) | YES  |     | NULL              |                   |
| email         | varchar(100) | YES  |     | NULL              |                   |
| username      | varchar(30)  | YES  |     | NULL              |                   |
| password      | varchar(100) | YES  |     | NULL              |                   |
| register_date | timestamp    | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
+---------------+--------------+------+-----+-------------------+-------------------+
6 rows in set (0.00 sec)
```

- install python packages
```
# instructed
$ pip install flask-mysqldb # failed:-(

# had to search and [turns out](https://github.com/alexferl/flask-mysqldb?tab=readme-ov-file) there are lots of dependencies

$ sudo apt-get install python3-dev default-libmysqlclient-dev build-essential pkg-config
$ pip install mysqlclient
$ pip install flask-mysqldb
```

pip install Flask-WTF
pip install passlib


```
$ sudo mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 38
Server version: 8.0.40-0ubuntu0.24.04.1 (Ubuntu)

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE USER 'flask'@'localhost' IDENTIFIED BY 'flaskapp';
Query OK, 0 rows affected (0.05 sec)

mysql> GRANT ALL PRIVILEGES ON flaskapp.* TO 'flask'@'localhost' ;
Query OK, 0 rows affected (0.03 sec)
```

- change code to use the database as the newly create `flask` user
- add code to handle user register, login, and logout
- commit and push
- test on windows -> missing packages -> tried to ammend and went into a rabbit hole trying to fix the mess

#### Articles

mysql> CREATE TABLE articles (id INT(11) AUTO_INCREMENT PRIMARY KEY, title VARCHAR(255), author VARCHAR(100), body TEXT, create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
Query OK, 0 rows affected, 1 warning (0.11 sec)

mysql> show tables;
+--------------------+
| Tables_in_flaskapp |
+--------------------+
| articles           |
| users              |
+--------------------+
2 rows in set (0.00 sec)

mysql> describe articles;
+-------------+--------------+------+-----+-------------------+-------------------+
| Field       | Type         | Null | Key | Default           | Extra             |
+-------------+--------------+------+-----+-------------------+-------------------+
| id          | int          | NO   | PRI | NULL              | auto_increment    |
| title       | varchar(255) | YES  |     | NULL              |                   |
| author      | varchar(100) | YES  |     | NULL              |                   |
| body        | text         | YES  |     | NULL              |                   |
| create_date | timestamp    | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
+-------------+--------------+------+-----+-------------------+-------------------+
5 rows in set (0.00 sec)

mysql> select * from articles;
Empty set (0.01 sec)


---




$ pip list
Package           Version Editable project location
----------------- ------- ------------------------------
annotated-types   0.7.0
anyio             4.7.0
fastapi           0.115.6
flask_app         0.1.0   /home/me/Projects/py/flask_app
idna              3.10
pip               24.3.1
pydantic          2.10.3
pydantic_core     2.27.1
sniffio           1.3.1
starlette         0.41.3
typing_extensions 4.12.2

App is based on serie of tutorials: [Python Flask from Scratch](https://www.youtube.com/watch?v=zRwy8gtgJ1A&list=PLillGF-RfqbbbPz6GSEM9hLQObuQjNoj_)

### user registration
![Flask blog screenshot](images/flask_blog_screenshot_4.jpg)
### login and access control
![Flask blog screenshot](images/flask_blog_screenshot_3.jpg)
### dashboard with list of articles with possibility to `edit` or `delete` each article
![Flask blog screenshot](images/flask_blog_screenshot_1.jpg)

# Requirements
install mysql and tools:
NOTE: mariadb was used as replacement for mysql

For Arch linux:
```bash
$ pacman -S mariadb libmariadbclient
```

```bash
$ pip install flask-mysqldb

# form validation, ...
$ pip install Flask-WTF

# password hashing
$ pip install passlib
```

# Handy mysql commands used during creation of app
Enter mysql:
```bash
$ mysql -u root -p
```

Show existing databases:
```sql
SHOW DATABASES
```

Create new database:
```sql
CREATE DATABASE myflaskapp;
```

Use our database:
```sql
USE myflaskapp
```

Create table with articles:
```sql
CREATE TABLE articles (id INT(11) AUTO_INCREMENT PRIMARY KEY, title VARCHAR(255), author VARCHAR(100), body TEXT, create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
```

List all tables to check if table was created:
```sql
SHOW TABLES;
```

List all articles:
```sql
SELECT * FROM articles
```

Create table with users
```sql
CREATE TABLE users(id INT(11) AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), email VARCHAR(100), username VARCHAR(30), password VARCHAR(100), register_date TIMESTAMP CURRENT_TIMESTAMP);
```

Get info on users table
```sql
DESCRIBE users
```

# Running application
```
$ python app.py
```

# Ideas for further development of the app:
* Clean up the app.py into separate modules
* Customize it with your own stylesheets and javascript
* Add another layer of access control to delete_article (The users can create a fake html form to send post requests to /delete_article and delete other peoples articles.)
* Prevent users from registering the same username as other users.
* If a new user is login, then that should see only their artices not all the articles
* Send email confirmation to activate account, be able to edit both the username and password.
* Only let logged user delete or edit their own posts or only let admin user do it. Also, instead of logging in with username use email as username and only allow unique emails to be added to the database, even let only unique usernames be stored in DB.﻿
* You can use 'itsdangerous' python library for confirmation token and 'Flask-Mail' library to send confirmation mail to the newly registered user. # Follow the following links for brief documentation :
    - https://pythonhosted.org/itsdangerous/
    - https://pythonhosted.org/Flask-Mail/﻿
* Replace bootstrap with Semantic UI

# License
MIT