import http.server
import json
import signal
import sys

class MyHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        response = json.dumps({'message': 'Hello, World!'})
        self.wfile.write(response.encode())

def handle_sigint(signal, frame):
    print("\nShutting down the server...")
    sys.exit(0)

if __name__ == "__main__":
    # Set up signal handler for CTRL+C
    signal.signal(signal.SIGINT, handle_sigint)

    server_address = ('', 8080)
    httpd = http.server.HTTPServer(server_address, MyHandler)
    
    print("Server running on port 8080. Press CTRL+C to stop.")
    
    httpd.serve_forever()

