#!/usr/bin/env bash
set -ex

./configure --prefix=$PREFIX
make
make install
make check
