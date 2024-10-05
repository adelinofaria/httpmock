//
//  HTTPMock+NonIsolated.swift
//  HTTPMock
//
//  Created by Adelino Faria on 05/10/2024.
//  Copyright © 2024 Adelino Faria. All rights reserved.
//

import Foundation

extension HTTPMock {

    nonisolated func entry(for task: URLSessionTask) -> HTTPMockEntry? {
        self.mockEntries.withLock { $0.first { $0.matches(task: task) } }
    }
}
