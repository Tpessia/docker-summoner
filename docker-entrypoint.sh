#!/bin/sh
dockerd &
exec "$@"