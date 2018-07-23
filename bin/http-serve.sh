#!/usr/bin/env bash
set -e 

base_dir="$(cd $(dirname $0) && pwd)"
timestamp=$(date '+%Y%m%d-%H%M%S')

function start_go_server() {
  full_src="/tmp/go-server-${timestamp}.go"
  echo "Go server source: $full_src"
  echo "To re-run:"
  echo
  echo "  go run $full_src [docroot]"
  echo

  cat << END_GO_SERVER > "$full_src"
// A basic Go HTTP file server with some additional logic for logging requests
package main

import (
	"context"
	"flag"
	"log"
	"net/http"
	"os"
	"os/signal"
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

	done := make(chan bool)
	quit := make(chan os.Signal, 1)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)

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
		close(done)
	}()

	logger.Printf("Starting server on %s \n", addr)
	if err := server.ListenAndServe(); err != nil {
		logger.Fatal(err)
	}

	// let shutdown complete
	<-done
}

func logRequests(logger *log.Logger, hdlr http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		hdlr.ServeHTTP(w, r)
		logger.Println(r.Method, r.URL.Path, r.RemoteAddr)
	})
}
END_GO_SERVER

  go run "$full_src" "$@"
}


#if go version >/dev/null 2>&1 ; then
if [[ $(go version 2>/dev/null) ]] ; then
  start_go_server "$@"
elif [[ $(python3 -V 2>/dev/null) ]] ; then
  echo "Starting python3 http server"
  python3 -m http.server "$@"
else
  echo "Attempting to start python2 http server"
  python -m SimpleHTTPServer
fi

