#!/bin/bash
[ -n "`command -v docker`" ] && echo "docker" && exit 0
[ -n "`command -v podman`" ] && echo "podman" && exit 0
echo "Neither 'docker' nor 'podman' found." >> /dev/stderr
echo "echo" && exit -1
