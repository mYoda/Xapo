// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation

public extension Collection {
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    var lastIndex: Int {
        return count - 1
    }
}


public extension Collection {
    func enumeratedArray() -> Array<(offset: Int, element: Self.Element)> {
        return Array(self.enumerated())
    }
}


extension Collection where Self.Index == Self.Indices.Iterator.Element {
    /**
     Returns an optional element. If the `index` does not exist in the collection, the subscript returns nil.

     - parameter safe: The index of the element to return, if it exists.

     - returns: An optional element from the collection at the specified index.
     */
    public subscript(safe i: Index) -> Self.Iterator.Element? {
        return at(i)
    }

    /**
     Returns an optional element. If the `index` does not exist in the collection, the function returns nil.

     - parameter index: The index of the element to return, if it exists.

     - returns: An optional element from the collection at the specified index.
     */
    public func at(_ i: Index) -> Self.Iterator.Element? {
        return indices.contains(i) ? self[i] : nil
    }
}


extension MutableCollection where Index == Int {
    /**
     Returns a random element from the collection.
     - returns: A random element from the collection.
     */
    public func random() -> Iterator.Element {
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
}


public extension Collection {
    
    func all(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        return try !self.contains(where: { try !predicate($0) })
    }
}

public extension Collection where Element: Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}
