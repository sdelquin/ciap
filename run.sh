#!/bin/bash

source ~/.virtualenvs/ciap/bin/activate
cd "$(dirname "$0")"
exec gunicorn -c gunicorn.conf.py ciap:app
