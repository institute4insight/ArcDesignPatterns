#!/bin/bash

FREE_PORT=`ruby -e 'require "socket"; puts Addrinfo.tcp("", 0).bind {|s| s.local_address.ip_port }'`

cat <<"EOF"
  ____       _____              _       _          _     
 |  _ \ _   |_   _|__  _ __ ___| |__   | |    __ _| |__  
 | |_) | | | || |/ _ \| '__/ __| '_ \  | |   / _` | '_ \ 
 |  __/| |_| || | (_) | | | (__| | | | | |__| (_| | |_) |
 |_|    \__, ||_|\___/|_|  \___|_| |_| |_____\__,_|_.__/ 
        |___/                                            

EOF
cat <<EOF
JupyterLab is running on port ${FREE_PORT}

+------------------------------------------------------------------+
| Create an SSH tunnel on your local computer with                 |
|    $ ssh -fNL 8888:localhost:${FREE_PORT} ${USER}@10.230.100.240 |
+------------------------------------------------------------------+

You can access Jupyter Lab by visiting:
    http://localhost:8888

Look in the Jupter output below for your access token!

EOF

loginctl enable-linger $UID
podman system migrate

podman run \
	-p ${FREE_PORT}:8888 \
	--device nvidia.com/gpu=0 \
	--security-opt=label=disable \
	-v $PWD:/myhome -v /data:/mydata \
	 nvcr.io/nvidia/pytorch:24.01-py3 jupyter-lab

cat <<EOF

Consider cleaning up your container images:
EOF

podman system prune -a
echo "Done"
