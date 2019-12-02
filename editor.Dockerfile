FROM python:3.8.0

# Use non-root user as a best practice:
RUN useradd -ms /bin/bash jovyan
USER jovyan

# Need this for formatting python files in VS Code:
RUN pip install -U autopep8 --user

WORKDIR $HOME/work
