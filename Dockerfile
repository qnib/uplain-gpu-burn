FROM ubuntu as build

RUN apt-get update \
 && apt-get install -y nvidia-cuda-toolkit
RUN apt-get install -y wget \
 && mkdir -p /usr/local/src/gpu_burn \
 && wget -qO- http://wili.cc/blog/entries/gpu-burn/gpu_burn-0.9.tar.gz |tar xfz - -C /usr/local/src/gpu_burn \
 && cd /usr/local/src/gpu_burn \
 && make

FROM ubuntu
COPY --from=build /usr/local/src/gpu_burn /usr/local/bin/
COPY run.sh /run.sh
CMD ["/run.sh"]
