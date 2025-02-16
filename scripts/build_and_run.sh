# Build the Docker image
docker build -t protobuf-cpp-server .

# Run the container and expose port 50051
docker run -p 50051:50051 protobuf-cpp-server
