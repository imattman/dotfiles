// A basic Go HTTP file server with some additional logic for logging requests
package main

import (
	"context"
	"flag"
	"log"
	"net/http"
	"os"
	"os/signal"
	"sync"
	"syscall"
	"time"
)

func main() {
	var (
		addr string
	)
	flag.StringVar(&addr, "addr", ":8000", "server address and port")
	flag.Parse()

	logger := log.New(os.Stdout, "", log.LstdFlags)

	docroot := "."
	if len(flag.Args()) > 0 {
		docroot = flag.Arg(0)
	}

	server := &http.Server{
		Addr:         addr,
		Handler:      logRequests(logger, http.FileServer(http.Dir(docroot))),
		ErrorLog:     logger,
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 5 * time.Second,
		IdleTimeout:  10 * time.Second,
	}

	quit := make(chan os.Signal, 1)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)

	var serverWg sync.WaitGroup
	serverWg.Add(1)

	go func() {
		// signal handler triggers graceful shutdown
		<-quit
		signal.Stop(quit)

		log.Println("Server is shutting down...")
		ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer cancel()

		server.SetKeepAlivesEnabled(false)
		if err := server.Shutdown(ctx); err != nil {
			logger.Fatalf("Could not shut down server gracefully: %v\n", err)
		}

		serverWg.Done()
	}()

	logger.Printf("Starting server on %s \n", addr)
	if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		logger.Printf("Server shutdown with error: %v\n", err)
	}

	// let shutdown complete
	serverWg.Wait()
}

func logRequests(logger *log.Logger, hdlr http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		hdlr.ServeHTTP(w, r)
		logger.Println(r.Method, r.URL.Path, r.RemoteAddr)
	})
}
