#!/bin/bash

source ~/.virtualenvs/ciap/bin/activate
cd "$(dirname "$0")"
exec uwsgi --ini uwsgi.ini
