import grpc
import example_pb2
import example_pb2_grpc

def run():
    with grpc.insecure_channel('localhost:50051') as channel:
        stub = example_pb2_grpc.ExampleServiceStub(channel)
        response = stub.ProcessRequest(example_pb2.Request(message="World"))
        print("Response received: " + response.reply)

if __name__ == '__main__':
    run()
