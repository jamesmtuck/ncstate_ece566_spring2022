set -e
clang-11 --version
cd /ece566 && make -C LectureCode all
cd /ece566/projects/p0 && rm -rf build && mkdir build && cd build && cmake -DLLVM_DIR=/usr/local/lib/cmake/llvm .. && cmake --build .
# This line failing, for some reason.
#cd /ece566 && rm -rf p0-test && mkdir p0-test && cd p0-test && ../wolfbench/configure && make all 


