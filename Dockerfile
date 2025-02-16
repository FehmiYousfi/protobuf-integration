# Use an official C++ runtime as a parent image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libprotobuf-dev \
    protobuf-compiler \
    libgrpc++-dev \
    libgrpc-dev \
    libssl-dev \
    pkg-config \
    git \
    curl \
    autoconf \
    libtool \
    && apt-get clean

# Clone the gRPC repository
RUN mkdir -p /tmp/grpc && cd /tmp/grpc \
    && git clone --recurse-submodules -b v1.46.3 https://github.com/grpc/grpc . \
    && mkdir -p cmake/build && cd cmake/build \
    && cmake -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF ../.. \
    && make -j$(nproc) \
    && make install \
    && ldconfig \
    && rm -rf /tmp/grpc

# Copy the project files
COPY . /app

# Set the working directory
WORKDIR /app

# Create a build directory and build the project
RUN mkdir build && cd build && cmake .. && make

# Expose the port
EXPOSE 50051

# Run the server
CMD ["./build/src/server"]
