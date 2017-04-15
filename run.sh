#!/bin/bash
# Master script.

cd "$(dirname "$0")"
source ~/.virtualenvs/ciap/bin/activate
exec uwsgi --ini uwsgi.cfg
