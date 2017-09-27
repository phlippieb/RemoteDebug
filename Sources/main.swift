// 1. cd ~/RemoteDebugger
// 2. swift build
// 3. .build/debug/myFirstProject
// 4. update loggingApi url

import Kitura
import HeliumLogger
import LoggerAPI

// Initialize HeliumLogger
let logger = HeliumLogger()
logger.colored = true
Log.logger = logger

// Create a new router
let router = Router()

// Handle HTTP GET requests to /
router.get("/") {
    request, response, next in
    response.send("Logging started...")
    next()
}

router.get("/log/:log") { request, response, _ in
    let name = request.parameters["log"] ?? ""
    Log.warning("\n logged: \(name)")
}

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8080, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
