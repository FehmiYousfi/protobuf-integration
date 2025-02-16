# Generate protobuf and gRPC files
protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS example.proto)
protobuf_generate_grpc_cpp(GRPC_SRCS GRPC_HDRS example.proto)

# Add the executable
add_executable(server main.cpp ${PROTO_SRCS} ${PROTO_HDRS} ${GRPC_SRCS} ${GRPC_HDRS})

# Link libraries
target_link_libraries(server
    PRIVATE
    protobuf::libprotobuf
    gRPC::grpc++
    gRPC::grpc
)
