// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation

extension Dictionary {
    /**
     Add dictionary to self in-place.

     - parameter dictionary: The dictionary to add to self
     */
    public mutating func formUnion(_ dictionary: Dictionary) {
        dictionary.forEach { updateValue($0.1, forKey: $0.0) }
    }

    /**
     Return a dictionary containing the union of two dictionaries

     - parameter dictionary: The dictionary to add
     - returns: The combination of self and dictionary
     */
    public func union(_ dictionary: Dictionary) -> Dictionary {
        var completeDictionary = self
        completeDictionary.formUnion(dictionary)
        return completeDictionary
    }
}

/**
 Combine the contents of dictionaries into a single dictionary. Equivalent to `lhs.union(rhs)`.

 - parameter lhs: The first dictionary.
 - parameter rhs: The second dictionary.
 - returns: The combination of the two input dictionaries
 */
public func + <Key, Value>(lhs: Dictionary<Key, Value>, rhs: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
    return lhs.union(rhs)
}

/**
 Add the contents of one dictionary to another dictionary. Equivalent to `lhs.unionInPlace(rhs)`.

 - parameter lhs: The dictionary in which to add key-values.
 - parameter rhs: The dictionary from which to add key-values.
 */
public func += <Key, Value>(lhs: inout Dictionary<Key, Value>, rhs: Dictionary<Key, Value>) {
    lhs.formUnion(rhs)
}

public extension Dictionary {
    func mapKeys<T>(_ transform: (Key) -> T) -> Dictionary<T, Value> {
        var result = Dictionary<T, Value>()
        result.reserveCapacity(count)
        forEach { key, value in
            result[transform(key)] = value
        }
        return result
    }
    
    func compactMapKeys<T>(_ transform: (Key) -> T?) -> Dictionary<T, Value> {
        var result = Dictionary<T, Value>()
        result.reserveCapacity(count)
        for (key, value) in self {
            guard let k = transform(key) else { continue }
            result[k] = value
        }
        return result
    }

    func merging(_ other: [Key: Value]) -> [Key: Value] {
        return merging(other, uniquingKeysWith: { _, r in r })
    }
}
