### Build docker container
`docker build -t rendered .`

### Run docker container
`./run.sh` or `nvidia-docker run -it -v $HOME/blender_docker/:/workspace/ --rm rendered`

### Install python module for blender
`pip install -e cuda/`

### Test to make sure cupy is installed correctly
`python cuda/test_cuda.py`

### Try the same code within Blender
`blender -b -P cuda/test_cuda.py`