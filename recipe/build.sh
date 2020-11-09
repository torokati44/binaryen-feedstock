#!/bin/bash

export CMAKE_CONFIG="Release"

EXTRA_CMAKE_ARGS=""
if [[ `uname` == 'Darwin' ]];
then
    EXTRA_CMAKE_ARGS="-DCMAKE_MACOSX_RPATH:BOOL=ON"
fi
export EXTRA_CMAKE_ARGS

mkdir -p "build_${CMAKE_CONFIG}"
pushd "build_${CMAKE_CONFIG}"

cmake -G "Ninja" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_INSTALL_LIBDIR=lib \
    ${CMAKE_ARGS} \
    ${EXTRA_CMAKE_ARGS} \
    "${SRC_DIR}"

ninja
ninja install
popd

# Needs Emscripten and other stuff to work.
#pushd "${SRC_DIR}"
#$PYTHON ./check.py
#popd
