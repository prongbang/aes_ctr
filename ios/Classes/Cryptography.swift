//
//  Cryptography.swift
//  aes_ctr
//
//  Created by Endtry on 9/10/2563 BE.
//

import Foundation

protocol Cryptography {
    func encrypt(counter: NSNumber, secretKey: FlutterStandardTypedData, plaintext: String) -> String
    func decrypt(counter: NSNumber, secretKey: FlutterStandardTypedData, cipher: String) -> String
}
