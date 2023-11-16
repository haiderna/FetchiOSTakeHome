//
//  MockDessertNetworkCall.swift
//  FetchiOSTakeHome
//
//  Created by Najia Haider on 11/15/23.
//

import Foundation

class NetworkDessertMock: NetworkManagerProtocol {
    
    func request<N>(_ endpoint: Endpoint, type: N.Type) async throws -> N where N : Decodable, N : Encodable {
        return Meals() as! N
    }
}
