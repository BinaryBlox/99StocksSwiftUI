//
//  APIClient.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation
import Combine

public protocol APIClient {
	associatedtype APIConfigType: APIConfiguration
	static func request<RequestType: Decodable>(_ config: APIConfigType) -> AnyPublisher<RequestType, Error>
}

public extension APIClient {
	static func request<RequestType: Decodable>(_ config: APIConfigType) -> AnyPublisher<RequestType, Error> {
		return URLSession.shared.combine.send(request: try! config.asURLRequest().get())
			.decode(type: RequestType.self, decoder: JSONDecoder())
			.eraseToAnyPublisher()
	}
}

