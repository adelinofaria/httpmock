//
//  HTTPMock.swift
//  HTTPMock
//
//  Created by Adelino Faria on 03/10/2024.
//  Copyright © 2024 Adelino Faria. All rights reserved.
//

import Foundation
import Synchronization

public actor HTTPMock {

    static let shared: HTTPMock = {
        let instance = HTTPMock()

        MockURLProtocol.delegate = instance

        return instance
    }()

    let mockEntries: Mutex<[HTTPMockEntry]> = .init([])

    private init() {

    }

    func append(entry: HTTPMockEntry) async {

        self.mockEntries.withLock { $0.append(entry) }
    }
}
