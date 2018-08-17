#!/bin/bash
# Master script.

cd "$(dirname "$0")"
PYTHON_VENV=$(pipenv --venv)
SOCKET=$(grep UWSGI_PORT .env | sed 's/.*=\s*//')
exec uwsgi --home $PYTHON_VENV --socket :$SOCKET --ini uwsgi.ini
