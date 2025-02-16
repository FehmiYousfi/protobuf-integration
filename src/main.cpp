// main.cpp
#include <iostream>
#include <grpcpp/grpcpp.h>
#include "example.pb.h"

using grpc::Server;
using grpc::ServerBuilder;
using grpc::ServerContext;
using grpc::Status;
using example::Request;
using example::Response;
using example::ExampleService;

class ExampleServiceImpl final : public ExampleService::Service {
  Status ProcessRequest(ServerContext* context, const Request* request, Response* response) override {
    std::string message = request->message();
    std::cout << "Received message: " << message << std::endl;
    response->set_reply("Hello, " + message);
    return Status::OK;
  }
};

void RunServer() {
  std::string server_address("0.0.0.0:50051");
  ExampleServiceImpl service;

  ServerBuilder builder;
  builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
  builder.RegisterService(&service);

  std::unique_ptr<Server> server(builder.BuildAndStart());
  std::cout << "Server listening on " << server_address << std::endl;
  server->Wait();
}

int main() {
  RunServer();
  return 0;
}
