// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import SwiftUI
import UIKit

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    
    private static let cachePath: String = {
        let cachePaths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        if let cachePath = cachePaths.first, let identifier = Bundle.main.bundleIdentifier {
            return cachePath.appending("/" + identifier)
        }

        return ""
    }()
    
    private let cache: NSCache<NSURL, UIImage> = {
        return NSCache<NSURL, UIImage>().then {
            $0.countLimit = 100 // 100 items
            $0.totalCostLimit = 1024 * 1024 * 100 // 100 MB
            $0.evictsObjectsWithDiscardedContent = false
        }
    }()
    
    
    public static let sharedUrlCache: URLCache = {
        let diskCapacity = 150 * 1024 * 1024 // 150 MB
        return URLCache(memoryCapacity: 0, diskCapacity: diskCapacity, diskPath: cachePath)
    }()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
