#-----------------------------------------------------------------------------------#
# preamble https://tech.davis-hansson.com/p/make/
#-----------------------------------------------------------------------------------#
# stick to the selected shell to avoid surprises
# this can be set to python or whatever
SHELL := bash
# this is to cause script to stop after error
# good to always have with bash, not sure what this does for other `shells`
.SHELLFLAGS := -eu -o pipefail -c  

# the default is to invoke separate shell per line
# avoid this by having the below string anywhere in the file
.ONESHELL:

# make sure that everything that was created by the failing rule is deleted
.DELETE_ON_ERROR:

# get warned on referring to undefined variables
MAKEFLAGS += --warn-undefined-variables

# disable the built in magic to act behind the scene
MAKEFLAGS += --no-builtin-rules

# never again pull your hair out because some editor swapped a tab for four spaces 
# and made Make do insane things, use `>` instead of indentation
ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

#-----------------------------------------------------------------------------------#
# variables 
#-----------------------------------------------------------------------------------#
pyenv_dir := .venv
ifeq ($(OS),Windows_NT) 
    detected_OS := Windows
	pyenv_bin := Scripts
else
    detected_OS := $(shell sh -c 'uname 2>/dev/null || echo Unknown')
	pyenv_bin := bin
endif
pyenv_path_name := $(pyenv_dir)/$(pyenv_bin)
pyenv_path=$(shell python -c "if __import__('pathlib').Path('$(pyenv_path_name)').exists(): print('$(pyenv_path_name)')")
ifeq ($(pyenv_path_name),$(pyenv_path))
	pyenv_exists := yes
else	
	pyenv_exists := no
endif
#-----------------------------------------------------------------------------------#
# targets https://tech.davis-hansson.com/p/make/
#-----------------------------------------------------------------------------------#
# Briefly, then, each Make rule follows a convention like

# <output-file>: <input file1> <input file 2> <input file n>
# > <script to create output-file from input files>
# Make calls the output the “target”, the inputs the “prerequisites” and the script the “recipe”. 
# The entire thing is called a “rule”.
#
# Note the use of $$ instead of $ for bash variables and subshells; 
# Make uses $ for it’s own templating variables, $$ escapes it so bash sees a single $.
#
# out/image-id: $(shell find src -type f)
# > image_id="example.com/my-app:$$(pwgen -1)"
# > docker build --tag="$${image_id}
# > echo "$${image_id}" > out/image-id
#
# out/.packed.sentinel: $(shell find src -type f)
# > node run webpack ..
# > touch out/.packed.sentinel
#
# $(@D) refers to the directory the target should go in
# $@  refers to the target
#
# out/.packed.sentinel: $(shell find src -type f)
# > mkdir -p $(@D) # expands to `mkdir -p out`
# > node run webpack ..
# > touch $@  # expands to `touch out/.packed.sentinel`
#-----------------------------------------------------------------------------------#

# first target is the default invoked by `make`
.DEFAULT_GOAL := help
help:				## Show make targets
> @echo "Running on $(detected_OS)"
> @echo "Usage: make <target>"
> @echo ""
> @echo "Targets:"
> @echo "--------"
> @fgrep "##" Makefile | fgrep -v fgrep
> @echo ""
ifeq ($(pyenv_exists),yes)
> @echo "Remember to activate the environment: 'source $(pyenv_path)/activate'"
else
> @echo "Create virtual environment to proceed: 'make new_env'"
endif
.PHONY: help

show_env:			## Show the current virtual environment
ifeq ($(pyenv_exists),yes)
> @echo && echo "Virtual environment python version:"
> @$(pyenv_path)/python -V
> @echo && echo "Virtual environment python site info:"
> @$(pyenv_path)/python -m site
> @echo && echo "Virtual environment python packages:"
> @$(pyenv_path)/pip list
> @echo "Remember to activate the environment: 'source $(pyenv_path)/activate'"
else
> @echo && echo  "No virtual environment"
> @echo "!!! Please run 'make new_env' to create it !!!"
endif
.PHONY: show_env

new_env:			## Create a new virtual environment
ifeq ($(pyenv_exists),yes)
> @echo && echo "Removing the existing virtual environment"
> @rm -rf $(pyenv_dir)
endif
> @echo && echo "Creating new virtual environment"
> @python -m venv $(pyenv_dir)
> @echo && echo "Updating pip"
> @./$(pyenv_path_name)/python -m pip install -U pip
> @echo && echo "Created new virtual environment"
> @echo "!!! Please run 'source $(pyenv_path_name)/activate' to enable the environment !!!"
.PHONY: new_env

#-------------------------------------------------------------------------------#
# Installing the dependencies                                                   #
#-------------------------------------------------------------------------------#
.PHONY: install, install_test, install_dev
#-------------------------------------------------------------------------------#
install:			## Install production dependencies
ifeq ($(pyenv_exists),yes)
> @echo "Installing production dependencies"
> @$(pyenv_path)/pip install -e .
else
> @echo && echo  "No virtual environment"
> @echo "!!! Please run 'make new_env' to create it !!!"
endif
#-------------------------------------------------------------------------------#
install_test: install		## Install test dependencies
ifeq ($(pyenv_exists),yes)
> @echo "Installing test dependencies"
> @$(pyenv_path)/pip install -e ".[test]"
else
> @echo && echo  "No virtual environment"
> @echo "!!! Please run 'make new_env' to create it !!!"
endif
#-------------------------------------------------------------------------------#
install_dev: install_test	## Install dev dependencies
ifeq ($(pyenv_exists),yes)
> @echo "Installing dev dependencies"
> @$(pyenv_path)/pip install -e ".[dev]"
else
> @echo && echo  "No virtual environment"
> @echo "!!! Please run 'make new_env' to create it !!!"
endif

#-------------------------------------------------------------------------------#
# Running                                                                       #
#-------------------------------------------------------------------------------#
.PHONY: run_server
# run_server: install
run_server: 			## Run the application server
ifeq ($(pyenv_exists),yes)
> @echo "Starting the server in src/app/app.py"
> @$(pyenv_path)/python src/app/app.py
else
> @echo && echo  "No virtual environment"
> @echo "!!! Please run 'make new_env' to create it !!!"
endif