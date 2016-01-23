#!/bin/sh

echo 'y' | /srv/discourse/launcher cleanup . --skip-prereqs > /dev/null
