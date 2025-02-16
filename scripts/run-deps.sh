mkdir thirdparty
cd thirdparty

# Clone the gRPC repository
git clone --recurse-submodules -b v1.46.3 https://github.com/grpc/grpc
cd grpc

# Build and install gRPC
mkdir -p cmake/build
cd cmake/build
cmake -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF ../..
make -j$(nproc)
sudo make install
sudo ldconfig
