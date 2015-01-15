#!/usr/bin/env python3
from distutils.core import setup, Extension

setup(name="Horn",
      version="0.0.1",
      description="A collection of Flask Macros for Hy",
      author="Matthias Pall Gissurarson",
      author_email="mpg@mpg.is",
      packages=["horn"],
      package_data={"horn":["flask.hy"]},
      install_requires=["hy"],
    )