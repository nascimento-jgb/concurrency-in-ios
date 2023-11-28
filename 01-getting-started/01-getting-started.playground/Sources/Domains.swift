import Foundation

public struct Domains: Decodable {
    public let data: [Domain]
}

public struct Domain: Decodable {
    public let attributes: Attributes
}

public struct Attributes: Decodable {
    public let name: String
    public let description: String
    public let level: String
}
