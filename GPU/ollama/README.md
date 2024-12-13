# Dockerized Version of OLLAMA

Exaple code to launch a dockerized version of Ollama.

References: 
- https://hub.docker.com/r/ollama/ollama
- https://github.com/ollama/ollama 

## Usage
0. **Optional: Build Ollama container** with `./ollama-build`. This step is only reqruied when using a custom image. Edit the start script `./ollama-start` to change using the custom image.
1. **Start Ollama daemon** with `./ollama-start --gpus=N` where `N` indicates which GPUs to use: e.g. `0` to `3`, a combination `0`, `2,3`, `all`, or `none`. The option `--port=P` allows to specify a port number `P`. Without it the script selects an available port. The API port is stored in the file `~/.ollama_service_port`.
2. **Prompt queries** to a selected model with `./ollama-prompt MODEL` where `MODEL` indicates the LLM. See the [List of supported LLMs](https://github.com/ollama/ollama?tab=readme-ov-file#model-library), default is `llama3`. Alternatively, **start your application** that queries the Ollama API. 
3. **Terminate Ollama daemon** after use with `./ollama-stop`. 


## Notes
- Please be mindful of our limited resources: terminate the daemon after use so that the CPU and GPU resources are not consumed by idle programs. 
- Ollama stored model parameters in `/staging/users/${USER}/ollama/models` where `USER` is the environment variable holding the username. These parameters persists after shutting down the Ollama daemon. They don't need to be downloaded again when restarting the daemon. Downloading parameters may take some time. E.g. the "Llama 3.1 70B" takes about 8 minutes. 
- In the future we will consolidate model parameter files. Please, remove model parameters that are no longer needed. Use the command `./ollama-cmd` to run `ollama` CLI commands like `./ollama-cmd rm llama3.1:70b`.
   
