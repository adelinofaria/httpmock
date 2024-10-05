//
//  HTTPMockEntry.swift
//  HTTPMock
//
//  Created by Adelino Faria on 03/10/2024.
//  Copyright © 2024 Adelino Faria. All rights reserved.
//

import Foundation

public struct HTTPMockEntry: Sendable {

    let patterns: [HTTPFacet]
    let response: URLResponse
    let data: Data

//    private init(patterns: [HTTPFacet]) {
//        self.patterns = patterns
//
//        self.response = HTTPURLResponse(url: URL(fileReferenceLiteralResourceName: ""),
//                                        statusCode: 200,
//                                        httpVersion: nil,
//                                        headerFields: nil)
//    }

    public init?(urlRequest: URLRequest,
                 statusCode: Int = 200,
                 httpVersion: String? = nil,
                 headerFields: [String: String]? = nil,
                 data: Data = Data()) {

        guard let url = urlRequest.url else {
            return nil
        }

        self.patterns = []

        let response = HTTPURLResponse(url: url,
                                       statusCode: statusCode,
                                       httpVersion: httpVersion,
                                       headerFields: headerFields)

        if let response = response {
            self.response = response
        } else {
            self.response = .init(url: url,
                                  mimeType: nil,
                                  expectedContentLength: data.count,
                                  textEncodingName: nil)
        }

        self.data = data
    }
}

extension HTTPMockEntry {

    func matches(task: URLSessionTask) -> Bool {
        false
    }
}

extension HTTPMockEntry {

}

indirect enum FacetOperator {
    case value(HTTPFacet)
    case and(lhs: FacetOperator, rhs: FacetOperator)
    case or(lhs: FacetOperator, rhs: FacetOperator)
    case not(FacetOperator)
}

struct HTTPFacetOperator {

}
