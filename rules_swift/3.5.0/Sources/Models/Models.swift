import Foundation

public struct AppConfig {
    public let appName: String
    public let version: String
    public let enableHTTP2: Bool

    public init(appName: String, version: String, enableHTTP2: Bool = false) {
        self.appName = appName
        self.version = version
        self.enableHTTP2 = enableHTTP2
    }
}

public struct TokenInfo {
    public let subject: String
    public let issuer: String
    public let expiresAt: Date

    public init(subject: String, issuer: String, expiresAt: Date) {
        self.subject = subject
        self.issuer = issuer
        self.expiresAt = expiresAt
    }
}

public struct ArchiveEntry {
    public let path: String
    public let size: UInt64
    public let isDirectory: Bool

    public init(path: String, size: UInt64, isDirectory: Bool) {
        self.path = path
        self.size = size
        self.isDirectory = isDirectory
    }
}
