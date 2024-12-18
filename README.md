Flask App
---
<!-- 
# Uncommenet this to show the badges line at the top
[![Contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=plastic)](CONTRIBUTING.md)
[![License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/mit)
![completion](https://img.shields.io/badge/completion%20state-75%25-blue.svg?style=plastic) -->

> Created as an exercise, to become pyton app template [2024-12-18]

## Using this repo

### Prerequisites
- Created and tested on Ubuntu24 installed on WSL2
- Tools installed
    - [python](https://python.org) v3.12 
    - [Pip Package Manager](https://pypi.python.org/pypi) v24.0
    - git2.43.0
    - make4.3
- Clone the repo and enter its folder

### Working with `make`
- The project is managed by `make`. 
- To see all the available make targets, invoke `make` or `make help`.
- If there is no virtual environment in the folder you'll be requested to create one by running `make new_env`. We expect the virtual environment to be named `.venv`; if you work with another environment, either rename it's folder or modify `Makefile` to set `VENV_DIR_NAME`. 
- Activate the virtual environment by invoking `source .venv/bin/activate`.

### To run the server

- Example sequence of commands:
```
$ make
$ make new_env
$ source .venv/bin/activate
$ make install
$ make run_server
```
- If everything is ok, you will be presented with the server url, e.g., `http://127.0.0.1:5000` as a link
- Click on the provided url link or copy the url into the browser's address bar

You shoud see the server now!!! 


### To interract with the server
TBD

## Roadmap
<!-- 
Using the following instead of bullets:

<br>&#9744;    # to mark todo item
<br>&#9745;    # to mark completed item
<br>&#9746;    # to mark not working item

Source: https://www.w3schools.com/charsets/ref_utf_symbols.asp
-->
<br>&#9745; Setup the repository
<br>&#9745; Setup development structure with make
<br>&#9745; Create bare minimum app, test that `make` can do the setup and start the server
<br>&#9744; Create minimal functioning app working with dummy data
<br>&#9744; Add user registration
<br>&#9744; Add user accounts and access control
<br>&#9744; Dashboard
<br>&#9744; Articles
<br>&#9744; 
<br>&#9744; 
<br>&#9744; 
<br>&#9744; 
<br>&#9744; 
<br>&#9744; 

# License
TBD