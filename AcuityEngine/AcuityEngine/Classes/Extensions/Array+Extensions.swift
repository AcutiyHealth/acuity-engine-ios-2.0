//
//  Array+Extensions.swift
//  learnIt
//
//  Created by TRT-IOS-1 on 17/12/19.
//  Copyright © 2019 TechGadol. All rights reserved.
//

import Foundation

extension Array {
    public subscript(safe index: Array.Index) -> Element? {
        get {
            if (index > count) || (index < 0) { return nil }
            return self[index]
        }
    }
}
