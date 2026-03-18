import Foundation
import Models
import Networking
import VulnDemoLib

let config = AppConfig(appName: "VulnDemo", version: "1.0.0", enableHTTP2: true)
print("Starting \(config.appName) v\(config.version)")

// JWT
let jwtHelper = JWTHelper()
let tokenInfo = TokenInfo(
    subject: "user@example.com",
    issuer: config.appName,
    expiresAt: Date().addingTimeInterval(3600)
)
print("Token info: \(tokenInfo.subject)")

// HTTP/2
let networkConfig = NetworkConfig(host: "localhost", port: 8443, useHTTP2: config.enableHTTP2)
let httpHelper = HTTPHelper(config: networkConfig)
print(httpHelper.describeConnection())

// Template
let templateHelper = TemplateHelper()
print("Template engine ready")

// Archive
let archiveHelper = ArchiveHelper()
print("Archive helper ready")

print("\(config.appName) initialized successfully")
