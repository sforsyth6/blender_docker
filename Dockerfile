FROM nvcr.io/nvidia/cuda:10.2-runtime

ENV PATH /opt/conda/bin:$PATH

RUN apt-get update && \
	apt-get install -y \
		wget \
		curl \
		libfreetype6 \
		libgl1-mesa-dev \
		libglu1-mesa \
		libxi6 \
		libxrender1 \
		xz-utils \
		vim &&\ 
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    conda create -n blender python=3.7 -y && \
    echo "conda activate blender" >> ~/.bashrc

SHELL ["conda", "run", "-n", "blender", "/bin/bash", "-c"]

RUN conda install -c conda-forge cupy -y

RUN pip install numpy numba scipy matplotlib ipython notebook
#    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1 && \
    
ENV BLENDER_VERSION 2.82
ENV BLENDER_URL https://mirror.clarkson.edu/blender/release/Blender$BLENDER_VERSION/blender-$BLENDER_VERSION-linux64.tar.xz

RUN mkdir /usr/local/blender && \
	curl -SL "$BLENDER_URL" -o blender.tar.xz && \
    unxz blender.tar.xz && \
	tar -xvf blender.tar -C /usr/local/blender --strip-components=1 && \
	rm blender.tar

ENV PATH $PATH:/usr/local/blender/

RUN mv /usr/local/blender/2.82/python/ /usr/local/blender/2.82/python_old && ln -s /opt/conda/envs/blender/ /usr/local/blender/2.82/python

WORKDIR /workspace/
