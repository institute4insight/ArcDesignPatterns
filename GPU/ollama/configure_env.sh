#!/bin/bash
#    ____                _                            _____ _ _      
#   / ___|_ __ ___  __ _| |_ ___     ___ _ ____   __ |  ___(_) | ___ 
#  | |   | '__/ _ \/ _` | __/ _ \   / _ \ '_ \ \ / / | |_  | | |/ _ \
#  | |___| | |  __/ (_| | ||  __/  |  __/ | | \ V /  |  _| | | |  __/
#   \____|_|  \___|\__,_|\__\___| (_)___|_| |_|\_/   |_|   |_|_|\___|

FREE_PORT=$(./get_free_port.rb)
cat << EOF > .env
export OLLAMA_PORT=$FREE_PORT
export OLLAMA_HOST=0.0.0.0
export OLLAMA_BASE=$WORKDIR/ollama
EOF

echo "$FREE_PORT" > .ollama_service_port