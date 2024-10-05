//
//  HTTPMock+Public.swift
//  HTTPMock
//
//  Created by Adelino Faria on 05/10/2024.
//  Copyright © 2024 Adelino Faria. All rights reserved.
//

import Foundation

extension HTTPMock {

    public static func mock(_ facet: HTTPFacet,
                            statusCode: Int = 200,
                            httpVersion: String? = nil,
                            headerFields: [String: String]? = nil,
                            data: Data = Data()) async {

        if let entry = HTTPMockEntry(urlRequest: .init(url: URL(fileURLWithPath: "")),
                                     statusCode: statusCode,
                                     httpVersion: httpVersion,
                                     headerFields: headerFields,
                                     data: data) {

            await self.shared.append(entry: entry)
        }
    }

    public static func mock(_ entry: HTTPMockEntry) async {

        await self.shared.append(entry: entry)
    }
}


/*
 HTTPMock.mock(urlRequest: URLRequest)
 HTTPMock.mock(_ filter: HTTPPattern...)

 HTTPMock.mock(.https, .get, .domain("domain.top"), .path("path"), .queryString("q=term"))
 NONO HTTPMock.mock(.https + .get + .domain("domain.top") + .path("path") + .queryString("q=term"))

 HTTPMock.mock(.https && .get && .domain("domain.top") && .path("path") && .queryString(name: "q", value: "term"))

 HTTPMock.mock(!.path("path"))

 HTTPMock.mock(.path("path") || !.path("path"))

 HTTPMock.mock(!.path(regex: "\d+"))
 */
