import Foundation
import Models

#if canImport(SSZipArchive)
import SSZipArchive
#endif

public struct ArchiveHelper {
    public init() {}

    public func extractArchive(zipPath: String, destination: String) -> Bool {
        #if canImport(SSZipArchive)
        return SSZipArchive.unzipFile(atPath: zipPath, toDestination: destination)
        #else
        return false
        #endif
    }

    public func createArchive(files: [String], destination: String) -> Bool {
        #if canImport(SSZipArchive)
        return SSZipArchive.createZipFile(atPath: destination, withFilesAtPaths: files)
        #else
        return false
        #endif
    }

    public func isPasswordProtected(zipPath: String) -> Bool {
        #if canImport(SSZipArchive)
        return SSZipArchive.isFilePasswordProtected(atPath: zipPath)
        #else
        return false
        #endif
    }
}
