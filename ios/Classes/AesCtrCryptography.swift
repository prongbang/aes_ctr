//
//  AesCtrCryptography.swift
//  aes_ctr
//
//  Created by Endtry on 9/10/2563 BE.
//

import Foundation
import CryptoSwift

/**
 * https://flutter.dev/docs/development/packages-and-plugins/developing-packages
 */
class AesCtrCryptography: Cryptography {
    
    func encrypt(counter: NSNumber, secretKey: FlutterStandardTypedData, plaintext: String) -> String {
        do {
            let key = [UInt8](secretKey.data)
            var iv = [UInt8](repeating: 0x0, count: 16)
            iv[15] = counter.uint8Value
            let aes = try AES(key: key, blockMode: CTR(iv: iv), padding: .noPadding)
            let encrypted = try aes.encrypt(plaintext.bytes)
            let cipherText = encrypted.toHexString()
            return cipherText
        } catch {
            return "Encrypt error"
        }
    }
    
    func decrypt(counter: NSNumber, secretKey: FlutterStandardTypedData, cipher: String) -> String {
        do {
            let key = [UInt8](secretKey.data)
            var iv = [UInt8](repeating: 0x0, count: 16)
            iv[15] = counter.uint8Value
            let hexArray = Array<UInt8>.init(hex: cipher)
            let aes = try AES(key: key, blockMode: CTR(iv: iv), padding: .noPadding)
            let decrypted = try aes.decrypt(hexArray)
            if let decryptedTxt = String(bytes: Data(decrypted).bytes, encoding: .utf8) {
                return decryptedTxt
            }
            return ""
        } catch {
            return "Decrypt error"
        }
    }
    
    static func getInstance() -> Cryptography {
        return AesCtrCryptography()
    }
    
}
