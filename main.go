package main

import (
	"context"
	"log"
	"net"

	"github.com/vanhocvp/basic-grpc-demo/server/protos/calculator"
	"google.golang.org/grpc"
)

type server struct {
	calculator.UnimplementedCalculatorServer
}

func loggingInterceptor(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (interface{}, error) {
	log.Printf("Received request: %v", req)
	resp, err := handler(ctx, req)
	log.Printf("Sent response: %v", resp)
	return resp, err
}

func (s *server) Add(ctx context.Context, request *calculator.AddRequest) (*calculator.AddResponse, error) {
	return &calculator.AddResponse{Result: request.A + request.B}, nil
}

func main() {
	lis, err := net.Listen("tcp", ":50051")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer(grpc.UnaryInterceptor(loggingInterceptor))
	calculator.RegisterCalculatorServer(s, &server{})
	log.Print("Server gRPC started...")
	err = s.Serve(lis)
	if err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
