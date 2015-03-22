#!/bin/bash

if [ $# -lt 2 ]
then
	echo "Usage:"
	echo "$0 [app name] [path]"
	exit 1
fi

# /project root
#	/webapp
#		/config
#			/settings
#				settings.py
#				settings_dev.py
#			wsgi.py			
#			urls.py
#		/yourapp
#			/migrations
#			/static
#			/templates
#			models.py
#			views.py
#		manage.py

if [ ! -d $2 ]
then
	mkdir -p $2
fi

cd $2

django-admin.py startproject webapp

# rename folder webapp/webapp to webapp/config
mv webapp/webapp webapp/config

mkdir webapp/config/settings
mv webapp/config/settings.py webapp/config/settings/
echo "from settings import *" >>  webapp/config/settings/settings_dev.py

# in webapp/manage.py, replace webapp.settings with config.settings.settings_dev

if [ "$(uname -a | awk '{ print $1 }')" == "Linux" ]
then
	sed -i "s/webapp.settings/config.settings.settings_dev/" webapp/manage.py
else # Darwin
	sed -i "" -e "s/webapp.settings/config.settings.settings_dev/" webapp/manage.py
fi

# in webapp/config/settings/settings.py:

# replace ROOT_URLCONF from yourapp.urls to config.urls
# ROOT_URLCONF = 'webapp.urls'
if [ "$(uname -a | awk '{ print $1 }')" == "Linux" ]
then
	sed -i "s/webapp.urls/config.urls/" webapp/config/settings/settings.py
else # Darwin
	sed -i "" -e "s/webapp.urls/config.urls/" webapp/config/settings/settings.py	
fi

# replace WSGI_APPLICATION from www.wsgi.application to config.wsgi.application
# WSGI_APPLICATION = 'webapp.wsgi.application'
if [ "$(uname -a | awk '{ print $1 }')" == "Linux" ]
then
	sed -i "s/webapp.wsgi.application/config.wsgi.application/" webapp/config/settings/settings.py
else # Darwin
	sed -i "" -e "s/webapp.wsgi.application/config.wsgi.application/" webapp/config/settings/settings.py
fi

cd webapp

touch config/settings/__init__.py

python manage.py startapp $1

mkdir $1/templates
mkdir $1/static

# add 

echo "from django.shortcuts import render_to_response, redirect" >> $1/views.py
echo "from django.template import RequestContext" >> $1/views.py
echo "from django.contrib import messages" >> $1/views.py
echo "from django.forms import ModelForm" >> $1/views.py
echo "from $1.models import *" >> $1/views.py
echo "from datetime import datetime, date" >> $1/views.py

# add to webapp/config/settings/settings.py

echo "import os, sys" >> config/settings/settings.py
echo "ROOTPATH = \"%s/../../\" %(os.path.dirname(os.path.realpath(__file__)))" >> config/settings/settings.py


