//
//  HTTPFacet.swift
//  HTTPMock
//
//  Created by Adelino Faria on 03/10/2024.
//  Copyright © 2024 Adelino Faria. All rights reserved.
//

import Foundation

public enum HTTPFacet: Sendable {
    case method
    case schema
    case host
    case port
    case path
    case queryString
    case fragment
    case httpHeaders
//    case body (future)

    case urlRequest
    case absoluteURL
}
