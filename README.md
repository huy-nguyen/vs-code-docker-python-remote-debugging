This is a fairly minimal setup that demonstrates remote debugging for Python from one container to another with VS Code using a combination of the official [VS Code Python extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python) and the [Remote Container development extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).
This is useful because sometimes I don't want to run the editor on my host machine directly but still want to be able to debug a Python script running in another Docker container.
For example, my Mac machine may have Python 3 built-in but I want to debug a script that runs Python 2.

This setup has been tested with:

- VS Code: version 1.40.2
- Python extension: version 2019.11.50794
- Remote Container extension: 0.86.0
- Docker Desktop for Mac 2.1.0.5

There are two containers in this setup that each have a volume pointing to the repo's directory:

- `editor` runs the VS Code editor.
  This is a bare bone Python image because I don't need that much functionality from this container.
  The only changes on top of the base image are
  - Addition of the non-root user `jovyan` for the editor to run under as a best practice.
  - Installation of the `ptvsd` package, which is installed on both the "local" and "remote" environments for remote debugging to work, and the `pep8` package, which is required for autoformatting in VS Code.
    The latter package is non-essential.
- `script` runs the script `test_script.py` that is to be debugged.
  The base image of this container (`jupyter/base-notebook:python-3.7.3`) is more complex than the `editor`'s image for demonstration purpose because in reality, the environment in which the script being debugged runs is quite complex as well.
  This container also has `ptvsd` installed in order for remote debugging to work.

To use this setup:

- Run `docker-compose up -d` in the root project directory.
- In VS Code, hit F1, choose "Remote Container: Open Folder in Container" and open the root project directory.
- Hit F5 to start debugging.
  VS Code should stop in the body of the `add` function.

Note that once `test_script.py` has finished executing, the `script` container will terminate so if you want to try debugging again, you'll have to run `docker-compose up -d` again.
