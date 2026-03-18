import Foundation
import Models
import SSZipArchive

public struct ArchiveHelper {
    public init() {}

    public func extractArchive(zipPath: String, destination: String) -> Bool {
        return SSZipArchive.unzipFile(atPath: zipPath, toDestination: destination)
    }

    public func createArchive(files: [String], destination: String) -> Bool {
        return SSZipArchive.createZipFile(atPath: destination, withFilesAtPaths: files)
    }

    public func isPasswordProtected(zipPath: String) -> Bool {
        return SSZipArchive.isFilePasswordProtected(atPath: zipPath)
    }
}
