//
//  Array+Extensions.swift
//  learnIt
//
//  Created by TRT-IOS-1 on 17/12/19.
//  Copyright © 2019 TechGadol. All rights reserved.
//

import Foundation

extension Double{
    func getConvertedValueFromPercentage() -> Double{
        return (1*self) / 100
    }
}
extension Array {
    public subscript(safe index: Array.Index) -> Element? {
        get {
            if (index > count) || (index < 0) { return nil }
            return self[index]
        }
    }
}
extension Sequence  {
    func sum<T: AdditiveArithmetic>(_ predicate: (Element) -> T) -> T {
        reduce(.zero) { $0 + predicate($1) }
    }
    
}
extension Sequence where Element: AdditiveArithmetic {
    /// Returns the total sum of all elements in the sequence
    func sum() -> Element { reduce(.zero, +) }
}
extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : Element(sum()) / Element(count) }
}
extension Collection {
    func average<T: BinaryInteger>(_ predicate: (Element) -> T) -> T {
        sum(predicate) / T(count)
    }
    func average<T: BinaryInteger, F: BinaryFloatingPoint>(_ predicate: (Element) -> T) -> F {
        F(sum(predicate)) / F(count)
    }
    func average<T: BinaryFloatingPoint>(_ predicate: (Element) -> T) -> T {
        sum(predicate) / T(count)
    }
    func average(_ predicate: (Element) -> Decimal) -> Decimal {
        sum(predicate) / Decimal(count)
    }
}
