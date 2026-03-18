import Foundation
import NIOHTTP2

public struct NetworkConfig {
    public let host: String
    public let port: Int
    public let useHTTP2: Bool

    public init(host: String, port: Int, useHTTP2: Bool = true) {
        self.host = host
        self.port = port
        self.useHTTP2 = useHTTP2
    }
}

public struct RequestBuilder {
    public let config: NetworkConfig

    public init(config: NetworkConfig) {
        self.config = config
    }

    public func buildHTTP2Headers(method: String, path: String) -> [(String, String)] {
        return [
            (":method", method),
            (":path", path),
            (":scheme", "https"),
            (":authority", "\(config.host):\(config.port)"),
        ]
    }

    public func http2Settings() -> HTTP2Settings {
        return HTTP2Settings([
            HTTP2Setting(parameter: .maxConcurrentStreams, value: 100),
            HTTP2Setting(parameter: .maxHeaderListSize, value: 65536),
        ])
    }
}
