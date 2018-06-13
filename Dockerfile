FROM flacjacket/opencv-tx2:3.4.1

LABEL maintainer="Piyamate Wisanuvej <baug55@gmail.com>"

COPY --from=flacjacket/wheels-tx2:20180602 /wheelhouse/numpy-1.14.3-cp35-cp35m-linux_aarch64.whl /
COPY --from=flacjacket/wheels-tx2:20180602 /wheelhouse/wheel-0.31.1-py2.py3-none-any.whl /
COPY --from=flacjacket/pytorch-tx2:0.4.0-20180604 /torch-0.4.0-cp35-cp35m-linux_aarch64.whl /

RUN  apt-get update \
  && export build_deps=' \
       build-essential \
       ca-certificates \
       python3-dev \
     ' \
  && apt-get install -y --no-install-recommends python3-pip zlib1g-dev libjpeg-dev python3-six $build_deps \
  && pip3 install /numpy-1.14.3-cp35-cp35m-linux_aarch64.whl \
  && pip3 install /torch-0.4.0-cp35-cp35m-linux_aarch64.whl \
  && pip3 install --no-cache-dir setuptools wheel \
  && pip3 install tqdm torch-vision pillow \
  && apt-mark manual libgomp1 \
  && apt-get remove --autoremove -y $build_deps \
  && rm -rf /var/cache/apt /var/lib/apt/lists/* /*.whl
