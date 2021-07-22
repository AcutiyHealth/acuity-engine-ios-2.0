//
//  KeyChainUtility.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 13/07/21.
//

import Foundation

func setKeyChain(key: String, value: String){
    guard let encoded = try? JSONEncoder().encode(value) else { return }
    let keychain = KeychainSwift()
    keychain.set(encoded, forKey: key)
}

func removeFromKeyChain(key: String) {
    let keychain = KeychainSwift()
    keychain.delete(key)
}
