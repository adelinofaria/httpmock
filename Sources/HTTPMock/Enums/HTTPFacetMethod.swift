//
//  HTTPFacetMethod.swift
//  HTTPMock
//
//  Created by Adelino Faria on 10/10/2024.
//  Copyright © 2024 Adelino Faria. All rights reserved.
//

import Foundation

public enum HTTPFacetMethod: String, Sendable {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
