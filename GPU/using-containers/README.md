# Using Containers

The preferred method for the development, training, and inference of machine learning models on the GPU server is using containers. Containers provide a lightweight and efficient way to package, distribute, and run applications consistently across various environments. In the realm of machine learning, where dependencies and configurations can be complex, containers offer a streamlined solution by encapsulating the entire software stack and its dependencies. 

The GPU server uses [podman](https://docs.podman.io/en/latest/index.html) as container management system. It closely mimicks [docker](https://www.docker.com/), though, there are some slight differences. The Podman configuration on this system allows users to build and their own containers.


<!-- 1. Build your own container with `Dockerfile`
2. Launch application in container
3. Cleaning up -->


## Getting Started
The following steps demonstrate how to start Jupyter Lab. You can familiarize yourself with containers, the `podman` command, and the GPU server.

**Do not leave your Jupyter notebooks idle!!!**

Terminate your notebooks and the Jupyter Lab container **immedeatly after your work**.
Open notebooks may allocate and block GPU memeory even when no computation is performed.

Use one of thise scripts to launch a container with Jupyter Lab:
- [PyTorch Jupter Lab](./scripts/pytorch-jupyter-lab.sh)
- [Tensorflow Jupyter Lab](./scripts/tensorflow-jupyter-lab.sh)

Follow the instructions on the terminal for creating the SSH tunnel between your local computer and the GPU server.

Please, terminate your Jupyter Lab container when your finished your work and delete the container image. (Select 'y' when prompted for it.)

<!-- Enable user
```
loginctl enable-linger USER_ID
podman system migrate
``` -->

## Containers
Find containers for your desired framework on the [Frameworks Support Matrix](https://docs.nvidia.com/deeplearning/frameworks/support-matrix/index.html)

| Framework | Container | Release Notes |
|--|--|--|
| PyTorch | [nvcr.io/nvidia/pytorch:24.01-py3](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/pytorch) | [PyTorch Release 24.01](https://docs.nvidia.com/deeplearning/frameworks/pytorch-release-notes/rel-24-01.html#rel-24-01)
| TensorFlow | [nvcr.io/nvidia/tensorflow:24.01-tf2-py3](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/tensorflow) | [TensorFlow Release 24.01](https://docs.nvidia.com/deeplearning/frameworks/tensorflow-release-notes/rel-24-01.html#rel-24-01)



```

podman run -rm \
	-p 39436:8888 \
	--device nvidia.com/gpu=0 \
	--security-opt=label=disable \
	-v $PWD:/myhome -v /data:/mydata \
	 nvcr.io/nvidia/pytorch:24.01-py3 jupyter-lab
```

###  Podman Parametes

| Parameter | Description |
|--------|-------------|
| `--rm` | Remove container after completion. Keep this option for proper cleanup. |  
| `-p 39436:8888` | Port-mapping: the port number of the right is the default for Jupyter (8888) which runs inside the container. The port number is  mapped to the number on the left. If you receive an error message about this port number not being availabe, pick a different number (8889, etc.) for the on on the left. The right 8888 always stays the same. |
| `--device nvidia.com/gpu=0` | This allows to container to use the first GPU on the system. |
| `--security-opt=label=disable` | Keep this the way it is.|
| `-v $PWD:/myhome -v /data:/mydata` | Pairs of directories that are mapped between host and container. The path on the left represents the directory on the host, and the path on right where this directory is mapped to. E.g. the current directory on the host, `$PWD`, is available inside the container under `/myhome`. Respectively, `/data` on the host can be accessed as `/mydata` in the container. You can use the `-v` option multiple times.|
| `nvcr.io/nvidia/pytorch:24.01-py3` | Name of container image, e.g. PyTorch. |
| `jupyter-lab` | Command to run in container. This example will start Jupyter Lab.  Make sure to terminate kernels before stepping away from the keyboard.|

## Build your own container
- Use a suitable container image that includes most of your required packages.
- Edit the `Dockerfile` ([doc](https://docs.docker.com/engine/reference/builder/))
- Build with `podman build` ([doc](https://manpages.ubuntu.com/manpages/jammy/en/man1/docker-build.1.html))
- Use `podman system prune -a` to clean-up

## Cleaning-up
Container images are stored on the very fast, but of limited capacity, staging file system `/staging`. When you have finished your work, use this command to free up valuable disk space.
```
podman system prune -a
```

Learn more about managing container related resource in [How To Remove Docker Images, Containers, and Volumes](https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes)
