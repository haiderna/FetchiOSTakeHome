//
//  NetworkManager.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/5/23.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<N: Codable>(_ session: URLSession,
                             _ endpoint: Endpoint,
                             type: N.Type ) async throws -> N
}


final class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<N>(_ session: URLSession, _ endpoint: Endpoint, type: N.Type) async throws -> N where N : Decodable, N : Encodable {
        
        guard let url = endpoint.url else {
            throw NetworkError.invalidUrl
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        
        let (data, response) = try await session.data(for: req)
        
        guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkError.invalidResponseStatusCode(statusCode: statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let res = try decoder.decode(N.self, from: data)
            return res
        } catch {
            throw NetworkError.failedToDecode(decodingError: error)
        }
        
    }
}

extension NetworkManager {
    enum NetworkError: LocalizedError {
        case invalidUrl
        case customError(error: Error)
        case invalidResponseStatusCode(statusCode: Int)
        case failedToDecode(decodingError: Error)
        case noMealData
        
        var errorDescription: String? {
            switch self {
            case .invalidUrl:
                return "Can't Validate URL"
            case .customError(error: let error):
                return "\(error.localizedDescription)"
            case .invalidResponseStatusCode(statusCode: let statusCode):
                return "Wrong Status Code Returned"
            case .failedToDecode(decodingError: let decodingError):
                return "Failed to Decode Data"
            case .noMealData:
                return "API Doesn't Contain Data for this Meal"
            }
        }
    }
}
