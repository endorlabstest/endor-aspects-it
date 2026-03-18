import XCTest
@testable import VulnDemoLib
import Models
import Networking

final class VulnDemoTests: XCTestCase {
    func testJWTHelperInit() {
        let helper = JWTHelper()
        XCTAssertNotNil(helper)
    }

    func testHTTPHelperDescribeConnection() {
        let config = NetworkConfig(host: "localhost", port: 8443, useHTTP2: true)
        let helper = HTTPHelper(config: config)
        let desc = helper.describeConnection()
        XCTAssertTrue(desc.contains("HTTP/2"))
        XCTAssertTrue(desc.contains("localhost"))
    }

    func testTemplateHelperInit() {
        let helper = TemplateHelper()
        XCTAssertNotNil(helper)
    }

    func testTemplateHelperCreateContext() {
        let helper = TemplateHelper()
        let context = helper.createContext(name: "greeting", value: "hello")
        XCTAssertEqual(context.count, 1)
    }

    func testArchiveHelperInit() {
        let helper = ArchiveHelper()
        XCTAssertNotNil(helper)
    }

    func testArchiveHelperExtractNonexistent() {
        let helper = ArchiveHelper()
        let result = helper.extractArchive(zipPath: "/nonexistent.zip", destination: "/tmp")
        XCTAssertFalse(result)
    }

    func testAppConfig() {
        let config = AppConfig(appName: "Test", version: "1.0", enableHTTP2: true)
        XCTAssertEqual(config.appName, "Test")
        XCTAssertEqual(config.version, "1.0")
        XCTAssertTrue(config.enableHTTP2)
    }

    func testTokenInfo() {
        let date = Date()
        let info = TokenInfo(subject: "user", issuer: "app", expiresAt: date)
        XCTAssertEqual(info.subject, "user")
        XCTAssertEqual(info.issuer, "app")
    }

    func testArchiveEntry() {
        let entry = ArchiveEntry(path: "test.txt", size: 100, isDirectory: false)
        XCTAssertEqual(entry.path, "test.txt")
        XCTAssertEqual(entry.size, 100)
        XCTAssertFalse(entry.isDirectory)
    }
}
