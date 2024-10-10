//
//  HTTPMockEntry.swift
//  HTTPMock
//
//  Created by Adelino Faria on 03/10/2024.
//  Copyright © 2024 Adelino Faria. All rights reserved.
//

import Foundation

public struct HTTPMockEntry: Sendable {

    let patternTree: ExpressionTree<HTTPFacet>
    let statusCode: Int
    let httpVersion: String?
    let headerFields: [String: String]?
    let data: Data

    init(_ patternTree: ExpressionTree<HTTPFacet>,
         statusCode: Int = 200,
         httpVersion: String? = nil,
         headerFields: [String: String]? = nil,
         data: Data = Data()) {

        self.patternTree = patternTree
        self.statusCode = statusCode
        self.httpVersion = httpVersion
        self.headerFields = headerFields
        self.data = data
    }

    public init(_ facet: HTTPFacet,
                statusCode: Int = 200,
                httpVersion: String? = nil,
                headerFields: [String: String]? = nil,
                data: Data = Data()) {

        self.init(.init(nodes: [.value(facet)]),
                  statusCode: statusCode,
                  httpVersion: httpVersion,
                  headerFields: headerFields,
                  data: data)
    }

    public init(urlRequest: URLRequest,
                statusCode: Int = 200,
                httpVersion: String? = nil,
                headerFields: [String: String]? = nil,
                data: Data = Data()) {

        self.init(.init(nodes: [.value(.urlRequest(urlRequest))]),
                  statusCode: statusCode,
                  httpVersion: httpVersion,
                  headerFields: headerFields,
                  data: data)
    }
}

extension HTTPMockEntry {

    func matches(task: URLSessionTask) -> Bool {

        self.patternTree.matches { $0.matches(task) }
    }

    func response(for url: URL) -> URLResponse {

        let response = HTTPURLResponse(url: url,
                                       statusCode: self.statusCode,
                                       httpVersion: self.httpVersion,
                                       headerFields: self.headerFields)

        if let response = response {
            return response
        } else {
            return .init(url: url,
                         mimeType: nil,
                         expectedContentLength: self.data.count,
                         textEncodingName: nil)
        }
    }
}
