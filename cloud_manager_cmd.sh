#!/usr/bin/env bash

function usage {
cat << END

usage: $0 [options]

This script is a Docker entry point to use with the image maxc0c0s/cloud-manager.

OPTIONS:
   -c                   Start command line /bin/bash
   -s                   Start cloud_manager application
   -t                   Start cloud_manager Django unittests
END
}

OPTSTRING=":cst"

while getopts $OPTSTRING opt; do
	case $opt in
		c)
			/bin/bash
			;;
		s)
			/technical_tests_env/bin/pip install -r /technical_tests/requirements.txt
			/technical_tests_env/bin/python /technical_tests/manage.py migrate
			/technical_tests_env/bin/python /technical_tests/manage.py runserver 0.0.0.0:8000
			;;
		t)
			/technical_tests_env/bin/pip install -r /technical_tests/requirements.txt
			/technical_tests_env/bin/python /technical_tests/manage.py migrate
			cd /technical_tests
			/technical_tests_env/bin/python manage.py test
			;;
		\?)
			usage
			;;
	esac
done
