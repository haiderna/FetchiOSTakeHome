//
//  NetworkMocks.swift
//  FetchiOSTakeHomeTests
//
//  Created by Najia Haider on 11/8/23.
//

import Foundation
@testable import FetchiOSTakeHome

enum FileOptions {
    case dessertList
    case dessertDetail
}

class NetworkSuccessMock: NetworkManagerProtocol {
    var file: FileOptions
    
    init(file: FileOptions) {
        self.file = file
    }
    
    func request<N>(_ session: URLSession, _ endpoint: FetchiOSTakeHome.Endpoint, type: N.Type) async throws -> N where N : Decodable, N : Encodable {
        switch file {
        case .dessertList:
            return try JSONReader.decode(file: "SampleList", type: Meals.self) as! N
        case .dessertDetail:
            return try JSONReader.decode(file: "SampleDessertDetail", type: MealDetail.self) as! N
        }
        
    }
}

class NetworkFailureMock: NetworkManagerProtocol {
    
    func request<N>(_ session: URLSession, _ endpoint: Endpoint, type: N.Type) async throws -> N where N : Decodable, N : Encodable {
        throw NetworkManager.NetworkError.invalidUrl
    }
}
