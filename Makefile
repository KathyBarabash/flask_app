#-------------------------------------------------------------------------------#                                                                     #
# PHONY targets - do not create artifacts (files) while regular targets do      #
#-------------------------------------------------------------------------------#
.PHONY: help, new_env, show_env
.PHONY: install, install_test, install_dev
.PHONY: run_server

#-------------------------------------------------------------------------------#                                                                     #
# Will be invoked if make is called without parameters                          #
#-------------------------------------------------------------------------------#
.DEFAULT_GOAL := help

#-------------------------------------------------------------------------------#
# .ONESHELL causes this to run in a single process                                   #
#-------------------------------------------------------------------------------#
.ONESHELL:
VENV_DIR_NAME=".venv"
VENV_PREFIX=$(shell python -c "if __import__('pathlib').Path('$(VENV_DIR_NAME)/bin/').exists(): print('$(VENV_DIR_NAME)/bin/')")
# TBD - see whether we want to work with poetry at some stage
# USING_POETRY=$(shell grep "tool.poetry" pyproject.toml && echo "yes")

#-------------------------------------------------------------------------------#
# Documentation                                                                 #
# relies on 'double pound' comment for all the targets :-)                      #
#-------------------------------------------------------------------------------#
help:				## Show make targets
	@echo "Usage: make <target>"
	@echo ""
	@if [ "$(VENV_PREFIX)" ]
	then 
		@echo "Virtual environment prefix: $(VENV_PREFIX)"
	else
		@echo "No virtual environment prefix"
		@echo "!!! Please run 'make new_env' to create it !!!"
	fi
	@echo ""
	@echo "Targets:"
	@fgrep "##" Makefile | fgrep -v fgrep

#-------------------------------------------------------------------------------#
# Python virtual environment                                                    #
#-------------------------------------------------------------------------------#
new_env:			## Create a virtual environment.
	@if [ "$(USING_POETRY)" ]; then poetry install && exit; fi
	@echo && echo "Removing the existing virtual environment"
	@rm -rf $(VENV_DIR_NAME)
	@echo && echo "Creating new virtual environment"
	@python3 -m venv $(VENV_DIR_NAME)
	@echo && echo "Updating pip"
	@./$(VENV_DIR_NAME)/bin/python -m pip install -U pip
	# @echo && echo "Installing test dependencies"
	@echo && echo "Created new virtual environment"
	@echo "!!! Please run 'source $(VENV_DIR_NAME)/bin/activate' to enable the environment !!!"
#-------------------------------------------------------------------------------#
show_env:			## Show the current virtual environment
	@if [ "$(USING_POETRY)" ]
	then 
		@echo "Running `poetry env info`" 
		poetry env info && exit
	fi
	@if [ "$(VENV_PREFIX)" ]
	then 
		# @echo "Virtual environment prefix: $(VENV_PREFIX)"
		@echo && echo "Virtual environment python version:"
		@$(VENV_PREFIX)python -V
		@echo && echo "Virtual environment python site info:"
		@$(VENV_PREFIX)python -m site
		@echo && echo "Virtual environment python packages:"
		@$(VENV_PREFIX)pip list
		@echo && echo "!!! Please run 'source $(VENV_DIR_NAME)/bin/activate' to enable the environment !!!"
	else
		@echo && echo  "No virtual environment"
		@echo "!!! Please run 'make new_env' to create it !!!"
	fi

#-------------------------------------------------------------------------------#
# Installing the dependencies                                                   #
#-------------------------------------------------------------------------------#
install:			## Install for production
	@echo "Installing production dependencies"
	@$(VENV_PREFIX)pip install -e .
#-------------------------------------------------------------------------------#
install_test: install		## Install for test 
	@echo "Installing test dependencies"
	@$(VENV_PREFIX)pip install -e ".[test]"
#-------------------------------------------------------------------------------#
install_dev: install_test	## Install for dev
	@echo "Installing dev dependencies"
	@$(VENV_PREFIX)pip install -e ".[dev]"


#-------------------------------------------------------------------------------#
# Running                                                                       #
#-------------------------------------------------------------------------------#
run_server: install	## Run the application server
	@echo "Starting the server in src/app/app.py"
	@$(VENV_PREFIX)python src/app/app.py