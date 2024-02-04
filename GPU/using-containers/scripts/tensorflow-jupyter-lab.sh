#!/bin/bash

FREE_PORT=`ruby -e 'require "socket"; puts Addrinfo.tcp("", 0).bind {|s| s.local_address.ip_port }'`

cat <<"EOF"
  _____                          __ _                 _          _     
 |_   _|__ _ __  ___  ___  _ __ / _| | _____      __ | |    __ _| |__  
   | |/ _ \ '_ \/ __|/ _ \| '__| |_| |/ _ \ \ /\ / / | |   / _` | '_ \ 
   | |  __/ | | \__ \ (_) | |  |  _| | (_) \ V  V /  | |__| (_| | |_) |
   |_|\___|_| |_|___/\___/|_|  |_| |_|\___/ \_/\_/   |_____\__,_|_.__/ 
                                                                    
EOF
cat <<EOF
JupyterLab is running on port ${FREE_PORT}

Create an SSH tunnel on your local computer with
    $ ssh -fNL 8888:localhost:${FREE_PORT} ${USER}@10.230.100.240

You can access JupyterLab by visiting:
    http://localhost:8888

Look in the Jupter output below for your access token!

EOF

podman run \
	-p ${FREE_PORT}:8888 \
	--device nvidia.com/gpu=all \
	--security-opt=label=disable \
	-v $PWD:/myhome -v /data:/mydata \
	nvcr.io/nvidia/tensorflow:24.01-tf2-py3 jupyter-lab

cat <<EOF

Consider cleaning up your container images:
EOF

podman system prune -a
echo "Done"
