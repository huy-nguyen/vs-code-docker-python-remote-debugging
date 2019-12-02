FROM jupyter/base-notebook:python-3.7.3

# Need ptvsd on both the remote and local environments for remote debugging to
# work:
RUN conda install -y ptvsd

WORKDIR $HOME/work
