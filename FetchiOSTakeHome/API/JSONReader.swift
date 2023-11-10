//
//  File.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/8/23.
//

import Foundation

struct JSONReader {
    static func decode<N: Decodable>(file: String, type: N.Type) throws -> N {
        guard !file.isEmpty,
                let path = Bundle.main.path(forResource: file, ofType: "json"),
                let data = FileManager.default.contents(atPath: path) else {
            throw ReaderError.readerFailure
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(N.self, from: data)
    }
}

extension JSONReader {
    enum ReaderError: Error {
        case readerFailure
    }
}

extension JSONReader.ReaderError {
    var errorDescription: String? {
        return "Failed to read local file."
    }
}
