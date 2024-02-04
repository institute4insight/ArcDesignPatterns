# Using Containers

Example to for using containers with GPU

Run with podman

Containers
Find containers for your desired framework on the [Frameworks Support Matrix](https://docs.nvidia.com/deeplearning/frameworks/support-matrix/index.html)

| Framework | Container | Release Notes |
|--|--|--|
| PyTorch | [nvcr.io/nvidia/pytorch:24.01-py3](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/pytorch) | [PyTorch Release 24.01(TensorFlow Release 24.01)
| TensorFlow | [nvcr.io/nvidia/tensorflow:24.01-tf2-py3](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/tensorflow) | [TensorFlow Release 24.01](https://docs.nvidia.com/deeplearning/frameworks/tensorflow-release-notes/rel-24-01.html#rel-24-01)



```
podman run \
	-p 8888:8888 \
	--device nvidia.com/gpu=all \
	--security-opt=label=disable \
	-v $PWD:/myhome -v /data:/mydata \
	 nvcr.io/nvidia/pytorch:24.01-py3 jupyter-lab
```

Break down of the parametes:
| Option | Description |
|--------|-------------|
| `-p 8888:8888` | Port-mapping: the port number of the right is the default for Jupyter (8888) which runs inside the container. The port number is  mapped to the number on the left. If you receive an error message about this port number not being availabe, pick a different number (8889, etc.) for the on on the left. The right 8888 always stays the same. |
| `--device nvidia.com/gpu=all` | This allows to container to use all GPUs on the system. |
| `--security-opt=label=disable` | Keep this the way it is.|
| `-v $PWD:/myhome -v /data:/mydata` | Pairs of directories that are mapped between host and container. The path on the left represents the directory on the host, and the path on right where this directory is mapped to. E.g. the current directory on the host, `$PWD`, is available inside the container under `/myhome`. Respectively, `/data` on the host can be accessed as `/mydata` in the container. |

         nvcr.io/nvidia/pytorch:24.01-py3 jupyter-lab



