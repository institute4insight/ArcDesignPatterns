# Create a docker file using an image of CUDA and pytorch, install python and jupyter
FROM nvcr.io/nvidia/pytorch:22.01-py3
COPY src .
ENTRYPOINT [ "/bin/bash" ]
CMD [ "pwd", ";", "ls -lR" ]