# Create a docker file using an image of CUDA and pytorch, install python and jupyter
FROM nvcr.io/nvidia/pytorch:24.01-py3
RUN mkdir /myapp
WORKDIR /myapp
RUN CD /myapp
COPY ./requirements.txt .
RUN pip3 intall -r ./requirements.txt 
COPY src .
ENTRYPOINT [ "/bin/bash" ]
CMD [ "pwd", ";", "ls -lR" ]
