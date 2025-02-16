cmake_minimum_required(VERSION 3.15)
project(ProtoGRPCExample)

# Set C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find Protobuf
find_package(Protobuf REQUIRED)
if (NOT Protobuf_FOUND)
  message(FATAL_ERROR "Protobuf not found. Please install Protobuf or set Protobuf_DIR.")
endif()

# (Optional) Include directories for Protobuf if needed
include_directories(${Protobuf_INCLUDE_DIRS})

# Find gRPC (using the CONFIG mode, which expects a gRPCConfig.cmake or grpc-config.cmake file)
find_package(gRPC CONFIG REQUIRED)
if (NOT gRPC_FOUND)
  # Provide a helpful message to the user
  message(FATAL_ERROR "gRPC not found. Please install gRPC and ensure that gRPCConfig.cmake or grpc-config.cmake is in your CMAKE_PREFIX_PATH.")
endif()

# Include gRPC directories
include_directories(${gRPC_INCLUDE_DIRS})

# Generate protobuf and gRPC source/header files from your proto file
protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS ${CMAKE_CURRENT_SOURCE_DIR}/example.proto)
protobuf_generate_grpc_cpp(GRPC_SRCS GRPC_HDRS ${CMAKE_CURRENT_SOURCE_DIR}/example.proto)

# Add the executable
add_executable(server main.cpp ${PROTO_SRCS} ${PROTO_HDRS} ${GRPC_SRCS} ${GRPC_HDRS})

# Link against the Protobuf and gRPC libraries
target_link_libraries(server
  PRIVATE
    protobuf::libprotobuf
    gRPC::grpc++
    gRPC::grpc
)
