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

        await self.shared.append(entry: .init(facet,
                                              statusCode: statusCode,
                                              httpVersion: httpVersion,
                                              headerFields: headerFields,
                                              data: data))
    }

    public static func mock(_ entry: HTTPMockEntry) async {

        await self.shared.append(entry: entry)
    }
}
