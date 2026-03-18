import Foundation
import NIOHTTP2
import Models
import Networking

public struct HTTPHelper {
    private let config: NetworkConfig

    public init(config: NetworkConfig) {
        self.config = config
    }

    public func makeRequestHeaders(method: String, path: String) -> [(String, String)] {
        let builder = RequestBuilder(config: config)
        return builder.buildHTTP2Headers(method: method, path: path)
    }

    public func defaultSettings() -> HTTP2Settings {
        let builder = RequestBuilder(config: config)
        return builder.http2Settings()
    }

    public func describeConnection() -> String {
        let proto = config.useHTTP2 ? "HTTP/2" : "HTTP/1.1"
        return "Connection to \(config.host):\(config.port) via \(proto)"
    }
}
