// XapoTest
//
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
//


import Foundation


Generator.fire()

enum Generator {
    static let fileManager = FileManager.default

    // Project base directory
    static let rootPathURL = URL(fileURLWithPath: fileManager.currentDirectoryPath)
    // Directory where the generated file should go
    static let outputDir = rootPathURL.appendingPathComponent("/XapoTest/Resources/Autogeneration/Colors")
    static let outputFileName = "Colors.swift"

    static let header = """
    // ••••••••••••••••••
    // • GENERATED FILE FROM ASSETS •
    // ••••••••••••••••••
    //
    // Template Created by Anton Nechayuk ©
    // with 🧡 for Xapo in 2021
    //



    import UIKit
    import SwiftUI



    """

    static let bootom = """
    
    
    // MARK: - Implementation Details
    fileprivate extension UIColor {
        convenience init(name: String) {
            self.init(named: name, in: bundle, compatibleWith: nil)!
        }
    }

    fileprivate extension Color {
        init(name: String) {
            self.init(name, bundle: bundle)
        }
    }

    private let bundle = BundleToken.bundle
    private final class BundleToken {
      static let bundle: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: BundleToken.self)
        #endif
      }()
    }
    """

}


//MARK: - Actions
extension Generator {
    
    static func fire() {
        do {
            /// Creates the destination directory if it does not exist
            if !fileManager.fileExists(atPath: outputDir.path) {
                try fileManager.createDirectory(at: outputDir, withIntermediateDirectories: true, attributes: nil)
            }
            
            /// Writes the generated file
            var fileContent = header
            fileContent += getExtensionContent(type: "Color")
            fileContent += "\n\n"
            fileContent += getExtensionContent(type: "UIColor")
            fileContent += bootom
            try fileContent.write(to: outputDir.appendingPathComponent(outputFileName), atomically: true, encoding: .utf8)
            
        }
        catch {
            print(error)
            exit(1)
        }
    }
    
    static func getExtensionContent(type: String) -> String {
        
        var content = ""
            content += "internal extension \(type) {"
        let definition = "\tstatic let "
        let remarkSign = "    // • "
        let declaration = "\n    /// "
        
        let xcAssets = fileManager.findAssetsCatalogs(form: rootPathURL)
        
        for catalog in xcAssets {
            
            
            /// Find all the color sets of the catalog
            let colorSets = fileManager.findColorSets(form: catalog)
            if colorSets.count > 0 {
                content += "\n\(remarkSign)\(catalog.lastPathComponent)\n"
            }
            for colorSet in colorSets {
                
                let jsonPath = colorSet.appendingPathComponent("Contents.json").path
                guard fileManager.fileExists(atPath: jsonPath) else { continue }
                
                
                let originalName = colorSet.deletingPathExtension().lastPathComponent
                let name = originalName.camelCased(separators: ["_", "-"])
                
                //getting comment
                if let setContent = try? ColorSetContent(jsonPath: jsonPath),
                   !setContent.colors.isEmpty {

                    let splitter = setContent.colors.count > 1 ? " | " : ""
                    for color in setContent.colors {
                        if let components = color.color.components {
                            if let appearances = color.appearances, !appearances.isEmpty {
                                var multipleDeclaration = "\(declaration)"
                                for appear in appearances {
                                    let idiom = color.idiom == "universal" ? "" : color.idiom.capitalized
                                    multipleDeclaration += "\(idiom) \(appear.value.capitalized) - \(components.hexRGBA)\(splitter)"
                                }
                                
                                content += "\(multipleDeclaration)"
                            } else {
                                content += "\(declaration)\(components.hexRGBA)\(splitter)"
                            }
                        }
                    }
                }
                content += "\n" + definition + name + " = \(type)(name: \"\(originalName)\")\n"
            }
        }
        
        content += "}"
        return content
    }
}


//MARK: - Model
/// Structure matching the `Contents.json`
struct ColorSetContent : Decodable {
    let colors : [IdiomColor]
    struct IdiomColor: Decodable {
        let appearances : [Appearance]?
        let color: Color
        var idiom: String = "universal" // iPhone,iPad ...
        struct Color : Decodable {
            var components : Components?
            var colorSpace: String = "srgb" // display-p3 ... special key solve later
            
            enum CodingKeys: String, CodingKey{
                case components
                case colorSpace = "color-space"
            }

            init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                components = try values.decode(Components.self, forKey: .components)
                colorSpace = try values.decode(String.self, forKey: .colorSpace)
            }
            
            struct Components : Decodable {
                let red: String
                let green: String
                let blue: String
                let alpha: String
                
                var hexRGBA: String {
                    let r = red.unitComponent
                    let g = green.unitComponent
                    let b = blue.unitComponent
                    let a = alpha.unitComponent
                    let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
                
                    return a < 1.0 ? String(format: "#%06x alpha:(%.2f)", rgb, a) : String(format: "#%06x ", rgb)
                }
            }
        }
        struct Appearance : Decodable {
            var appearance: String = "luminosity" // contrast ...
            var value: String = "any" // dark, light ...
        }
    }
    
    /// Loads the content of a color set content file
    ///
    /// - parameter jsonPath: The path to the json content file
    init(jsonPath : String) throws {
        let data = try Data(contentsOf: URL(fileURLWithPath: jsonPath))
        let decoder = JSONDecoder()
        self = try decoder.decode(ColorSetContent.self, from: data)
    }
    
    /// The default color components for a color set (the one without a specified appearcance)
    var defaultComponents : IdiomColor.Color.Components? {
        return colors.filter { $0.appearances == nil }.first?.color.components
    }
}

//MARK: - Helpers

extension FileManager {
    /// Enumerates all the sub directories of and url having a given extension.
    ///
    /// - parameter url: The root url
    /// - parameter ext: The extension of the searched subdirectories (without the '.')
    ///
    /// - returns: An array containing all the urls of the subdirectories
    func findSubDirectories(from url: URL, withExtension ext: String) -> [URL] {
        let directoryEnumerator = enumerator(at: url, includingPropertiesForKeys: [.isDirectoryKey])
        var result = [URL]()
        
        while let element = directoryEnumerator?.nextObject() as? URL {
            if (try? element.resourceValues(forKeys: [.isDirectoryKey]).allValues[.isDirectoryKey]) as? Bool == true {
                if element.pathExtension.lowercased() == ext {
                    directoryEnumerator?.skipDescendants()
                    result.append(element)
                }
            }
        }
        
        return result
    }
    
    /// Enumerates all the assets catalogs
    func findAssetsCatalogs(form url: URL) -> [URL] {
        return findSubDirectories(from: url, withExtension: "xcassets")
    }
    
    /// Enumerates all the color sets
    func findColorSets(form url: URL) -> [URL] {
        return findSubDirectories(from: url, withExtension: "colorset")
    }
    
    /// Enumerates all the image sets
    func findImageSets(form url: URL) -> [URL] {
        return findSubDirectories(from: url, withExtension: "imageset")
    }
}


extension String {
    /// The double value, reduced to 1 when the string is a hexadecimal value
    ///
    /// If the string is a double, returns the double value.
    /// If it contains a 'x', it assumes it's an hexadecimal value and returns the value divided by 255.
    /// Returns 0 otherwise.
    var unitComponent : Double {
        guard let double = Double(self)
        else { return 0.0 }
        
        if contains("x") {
            return double / 255.0
        } else if double > 1.0 {
            return double / 255.0
        }
        else {
            return double
        }
    }
}



extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
    var firstLowercased: String { prefix(1).lowercased() + dropFirst() }
}

extension String {
    
    func camelCased(separator: Character) -> String {
        return self.contains(separator) ? self.lowercased()
            .split(separator: separator)
            .enumerated()
            .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() }
            .joined()
            .firstLowercased
            : self.firstLowercased
    }
    
    func camelCased(separators: [Character]) -> String {
        var result = self
        for separ in separators {
            if self.contains(separ) {
                result = self.lowercased()
                    .split(separator: separ)
                    .enumerated()
                    .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() }
                    .joined()
            }
        }
        return result.firstLowercased
    }
    
    ///
    func substring(to index: Int) -> String {
        guard let end_Index = validEndIndex(original: index) else {
            return self
        }
        return String(self[startIndex..<end_Index])
    }
    
    ///
    func substring(from index: Int) -> String {
        guard let start_index = validStartIndex(original: index)  else {
            return self
        }
        return String(self[start_index..<endIndex])
    }
    ///
    func sliceString(_ range: CountableRange<Int>) -> String {
        guard
            let startIndex = validStartIndex(original: range.lowerBound),
            let endIndex   = validEndIndex(original: range.upperBound),
            startIndex <= endIndex
        else {
            return ""
        }
        return String(self[startIndex..<endIndex])
    }
    
    ///
    func sliceString(_ range: CountableClosedRange<Int>) -> String {
        guard
            let start_Index = validStartIndex(original: range.lowerBound),
            let end_Index   = validEndIndex(original: range.upperBound),
            startIndex <= endIndex
        else {
            return ""
        }
        if endIndex.utf16Offset(in: self) <= end_Index.utf16Offset(in: self) {
            return String(self[start_Index..<endIndex])
        }
        return String(self[start_Index...end_Index])
    }
    
    private func validIndex(original: Int) -> String.Index {
        switch original {
        case ...startIndex.utf16Offset(in: self) : return startIndex
        case endIndex.utf16Offset(in: self)...   : return endIndex
        default                          : return index(startIndex, offsetBy: original)
        }
    }
    
    private func validStartIndex(original: Int) -> String.Index? {
        guard original <= endIndex.utf16Offset(in: self) else { return nil }
        return validIndex(original: original)
    }
    
    private func validEndIndex(original: Int) -> String.Index? {
        guard original >= startIndex.utf16Offset(in: self) else { return nil }
        return validIndex(original: original)
    }
}

