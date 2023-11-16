//
//  NetworkMealDetailMock.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/15/23.
//

import Foundation

class NetworkMealDetailMock: NetworkManagerProtocol {
    
    func request<N>(_ endpoint: Endpoint, type: N.Type) async throws -> N where N : Decodable, N : Encodable {
        return MealDetail() as! N
    }
}
