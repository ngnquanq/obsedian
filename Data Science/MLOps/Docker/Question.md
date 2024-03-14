# What is the differences between virtual environment in python and docker?

A virtualenv only encapsulates Python dependencies. A Docker container encapsulates an _entire OS_.

With a Python virtualenv, you can easily switch between Python versions and dependencies, but you're stuck with your host OS.

With a Docker image, you can swap out the entire OS - install and run Python on Ubuntu, Debian, Alpine, even Windows Server Core.