#!/usr/bin/env bash
set -ex

# Get an updated config.sub and config.guess
chmod +w ./config.guess ./config.sub
cp $BUILD_PREFIX/share/gnuconfig/config.* ./

autoreconf -ivf

configure_args=(
    --build=${BUILD}
    --prefix=${PREFIX}
    --disable-static
    --disable-dependency-tracking
    --disable-selective-werror
    --disable-silent-rules
)

if [[ "${CONDA_BUILD_CROSS_COMPILATION}" == "1" ]]; then
    configure_args+=(--enable-malloc0returnsnull)
fi

./configure "${configure_args[@]}"
make -j${CPU_COUNT}
make install

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    make check
fi
