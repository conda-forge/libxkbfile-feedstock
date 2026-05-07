#!/usr/bin/env bash
set -ex

meson setup builddir ${MESON_ARGS} \
    -Ddefault_library=shared

meson compile -C builddir -j ${CPU_COUNT}
meson install -C builddir
