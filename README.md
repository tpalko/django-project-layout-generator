django-project-layout-generator
===============================

A shell script which uses django-admin.py to create an initial project folder, and then performs several scripted layout and configuration modifications to standardize it.

## What Problem?

Django is a fantastic web application framework, however Django application structures aren't very intuitive or logical for real software development. Most projects don't need to separate "projects" from "apps", and if you only need one "app", django-admin disallows giving it the same name as the "project":

	CommandError: 'widget_app' conflicts with the name of an existing Python module and cannot be used as an app name. Please try another name.

So now we're stuck coming up with a second name. Django splits the "app" folder from the "project" folder, placing configuration and routing in the "project" folder, and the modeling and templating components in the "app" folder. 

	./manage.py
	./webapp
	./webapp/__init__.py
	./webapp/admin.py
	./webapp/migrations
	./webapp/migrations/__init__.py
	./webapp/models.py
	./webapp/tests.py
	./webapp/views.py
	./widget
	./widget/__init__.py
	./widget/settings.py
	./widget/urls.py
	./widget/wsgi.py

## Usage

Run the shell script **django_config.sh** to learn its parameters:
	
	$ ./django_config.sh
	Usage:
	./django_config.sh [app name] [path]
	
Run the shell script **django_config.sh** with appropriate parameters:

	$ ./django_config.sh widget_app ~/dev/code/widget_app

Wait approximately 0.6 seconds.

Observe your new Django application, with a sensible file structure:

	./webapp
	./webapp/config
	./webapp/config/__init__.py
	./webapp/config/settings
	./webapp/config/settings/__init__.py
	./webapp/config/settings/settings.py
	./webapp/config/settings/settings_dev.py
	./webapp/config/urls.py
	./webapp/config/wsgi.py
	./webapp/widget_app
	./webapp/widget_app/__init__.py
	./webapp/widget_app/admin.py
	./webapp/widget_app/migrations
	./webapp/widget_app/migrations/__init__.py
	./webapp/widget_app/models.py
	./webapp/widget_app/static
	./webapp/widget_app/templates
	./webapp/widget_app/tests.py
	./webapp/widget_app/views.py
	./webapp/manage.py