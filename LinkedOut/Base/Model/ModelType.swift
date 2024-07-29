//
//  ModelType.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import Then

protocol ModelType: Codable, Then {
  associatedtype Event

  static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
}

extension ModelType {
  static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
    return .iso8601
  }

  static var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = self.dateDecodingStrategy
    return decoder
  }
}

/*
extension Decodable {
    static func decodeFromFile(named fileName: String, in bundle: Bundle = .main) throws -> Self {
        // Just like in an app, we can use our playground’s
        // bundle to retrieve a URL for a local resource file.
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
 //TODO MissingFileError() 어떻게 사용해야 하나?
            throw MissingFileError()
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()

        return try decoder.decode(self, from: data)
    }
}
*/

