# DESCRIPTION : Crée un serveur simple sur localhost:9999 avec un GET /hello qui retourne "HELLO WORLD!"
# TAGS : util, dev

# Create and configure the HttpListener
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:9999/")
$listener.Start()
Write-Host "Server listening on http://localhost:9999/..."

while ($true) {
    # Await for an incoming request
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response

    # Add CORS headers to allow all origins
    $response.Headers.Add("Access-Control-Allow-Origin", "*")
    $response.Headers.Add("Access-Control-Allow-Headers", "*") # Allow all headers
    $response.Headers.Add("Access-Control-Allow-Methods", "GET, OPTIONS") # Allow GET and OPTIONS methods

    # Handle the request
    if ($request.HttpMethod -eq "OPTIONS") {
        # Handle preflight request
        $response.StatusCode = 204 # No Content
        $response.OutputStream.Close()
        continue
    }

    if ($request.HttpMethod -eq "GET" -and $request.Url.AbsolutePath -eq "/hello") {
        # Log the current time and the call to /hello in green
        $currentTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Write-Host "[$currentTime] Received GET request for /hello" -ForegroundColor Green

        # Prepare the response
        $responseString = "HELLO WORLD!"
        $buffer = [System.Text.Encoding]::UTF8.GetBytes($responseString)
        $response.ContentLength64 = $buffer.Length
        $response.OutputStream.Write($buffer, 0, $buffer.Length)
    } else {
        # Return 404 if the route is not found
        $response.StatusCode = 404
        $response.StatusDescription = "Not Found"
    }
    
    # Close the response
    $response.OutputStream.Close()
}

# To stop the server, use Ctrl+C in the terminal
