build="./build_vita"

cmake -B "${build}" -DVITA=ON
ninja -C "${build}"