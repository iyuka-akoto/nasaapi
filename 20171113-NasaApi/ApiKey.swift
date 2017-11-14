//
//  ApiKey.swift
//  20171113-NasaApi
//
//  Created by Iyuka on 2017/11/14.
//  Copyright © 2017年 Iyuka. All rights reserved.
//

import Foundation

// SecretApiKey.swiftのAPIKEYを扱う
// let APIKEY: Dictionary<String,String> = ["KeyName":"KeyValue", ...]

// API Keyを返す
func readApiKey(keyName: String) -> String? {
    if let keyValue = APIKEY[keyName] {
        print("keyName: \(keyName) = keyValue: \(keyValue)")
        return keyValue
    } else {
        return nil
    }
}

