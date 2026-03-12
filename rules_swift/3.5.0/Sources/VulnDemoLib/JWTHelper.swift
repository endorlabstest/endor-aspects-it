import Foundation
import JSONWebAlgorithms
import JSONWebKey
import JSONWebSignature
import JSONWebToken
import Models

public struct JWTHelper {
    public init() {}

    public func createToken(info: TokenInfo) throws -> String {
        let claims = DefaultJWTClaimsImpl(
            iss: info.issuer,
            sub: info.subject,
            exp: info.expiresAt
        )
        let key = JWK(keyType: .octetSequence, key: Data(repeating: 0x01, count: 32))
        let jws = try JWT.signed(payload: claims, protectedHeader: DefaultJWSHeaderImpl(algorithm: .HS256), key: key)
        return jws.jwtString
    }

    public func verifyToken(_ token: String) throws -> String {
        return token.components(separatedBy: ".").first ?? ""
    }
}
