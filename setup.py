#!/usr/bin/env python3
from distutils.core import setup, Extension

setup(name="Horn",
      version="0.0.2",
      description="A collection of Flask Macros for Hy",
      author="Matthias Pall Gissurarson",
      url="https://github.com/Hylands/horn",
      license='MIT',
      packages=["horn"],
      package_data={"horn":["flask.hy", "macros.hy"]},
      install_requires=["hy"],
    )
