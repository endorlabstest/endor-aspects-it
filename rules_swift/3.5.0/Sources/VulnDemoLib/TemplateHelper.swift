import Foundation
import LeafKit

public struct TemplateHelper {
    public init() {}

    public func createContext(name: String, value: String) -> [String: LeafData] {
        return [
            name: .string(value),
        ]
    }

    public func createListContext(name: String, values: [String]) -> [String: LeafData] {
        return [
            name: .array(values.map { .string($0) }),
        ]
    }
}
