//
//  Utilities.swift
//  UPI Intent Sample App
//
//  Created by Vishrut tewatia on 16/10/23.
//

import Foundation
import CommonCrypto

enum CryptoAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512

    var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:      result = kCCHmacAlgMD5
        case .SHA1:     result = kCCHmacAlgSHA1
        case .SHA224:   result = kCCHmacAlgSHA224
        case .SHA256:   result = kCCHmacAlgSHA256
        case .SHA384:   result = kCCHmacAlgSHA384
        case .SHA512:   result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }

    var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .MD5:      result = CC_MD5_DIGEST_LENGTH
        case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

class UPIIntentSampleAppUtilities {
    
    public class func getJWTToken(payload: [String:Any], clientSecret: String) -> String {
        let hdrFlds = ["alg":"HS256","typ":"JWT"]
        let jsonHdr = hdrFlds.json
        let tokenHeader = jsonHdr.toBase64URL()
        
//        var payloadField: [String : Any] = [:]  //assign value here of payload
//        payloadField["client-id"] = clientId
//        payloadField["iss"] = "bos"
//        payloadField["customer_id"] = JRNPAuthWrapper.getUserID()
        
        let jsonPayload = payload.json
        
        let tokenPayload = jsonPayload.toBase64URL()
        
        let prefix = tokenHeader  + "." + tokenPayload
        let key = clientSecret
        let signature = prefix.hmac(algorithm: .SHA256, key: key)
        
        let joinedkeys = tokenHeader + "." + tokenPayload  + "." + signature
        
        return joinedkeys
    }
    
}

extension Dictionary {
    
    public var json: String {
        let emptyJson = "{}"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) ?? emptyJson
            return jsonString
        } catch {
            return emptyJson
        }
    }
    
}


extension String {
    
    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))

        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
         var val = Data(bytes: result, count: digestLen).base64EncodedString()
        val = val.replacingOccurrences(of: "+", with: "-")
        val =  val.replacingOccurrences(of: "/", with: "_")
        val =  val.replacingOccurrences(of: "=", with: "")
        return val
    }
    
    func toBase64URL() -> String {
        var result = Data(self.utf8).base64EncodedString()
        result = result.replacingOccurrences(of: "+", with: "-")
        result = result.replacingOccurrences(of: "/", with: "_")
        result = result.replacingOccurrences(of: "=", with: "")
        return result
    }
    
}
