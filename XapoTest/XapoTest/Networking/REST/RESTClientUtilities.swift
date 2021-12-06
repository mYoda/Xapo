// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation


typealias RequestParameters = [String: Any]


let syncRESTDispatchQueue = DispatchQueue(label: "REST Sync Queue", qos: .userInitiated)


extension JSONDecoder {
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        decoder.dateDecodingStrategy = .deferredToDate
        return decoder
    }
    
    static var snakeCased: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}

extension JSONEncoder {
    static var `default`: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.keyEncodingStrategy = .useDefaultKeys
        encoder.dateEncodingStrategy = .deferredToDate
        return encoder
    }
    
    static var snakeCased: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
}


enum DateError: String, Error {
    case invalidDateFormat
}


extension KeyedDecodingContainerProtocol {
    func decode<T>(key: Self.Key) throws -> T where T : Decodable {
        return try decode(T.self, forKey: key)
    }
    
    func decodeOptionalURL(key: Self.Key) throws -> URL? {
        guard let string = try decode(String?.self, forKey: key) else { return nil }
        
        if string.isEmpty { return nil }
        guard let url = URL(string: string) else {
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: self,
                debugDescription: "Not a URL")
        }
        return url
    }
}
