#!/usr/bin/env python3
from distutils.core import setup, Extension

setup(name="macros",
      version="0.0.1",
      description="A collection of Macros for Hy",
      author="Matthias Pall Gissurarson",
      url="https://github.com/Hylands/macros",
      license='MIT',
      packages=["macros"],
      package_data={"macros":["flask.hy", "flow.hy"]},
      install_requires=["hy"],
    )
