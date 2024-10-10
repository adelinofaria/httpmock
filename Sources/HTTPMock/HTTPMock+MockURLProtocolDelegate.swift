//
//  HTTPMock+MockURLProtocolDelegate.swift
//  HTTPMock
//
//  Created by Adelino Faria on 05/10/2024.
//  Copyright © 2024 Adelino Faria. All rights reserved.
//

import Foundation

extension HTTPMock: MockURLProtocolDelegate {

    nonisolated func canInit(task: URLSessionTask) -> Bool {

        let entry = self.entry(for: task)

        return entry != nil
    }
    
    nonisolated func processRequest(with task: URLSessionTask) throws -> (Data, URLResponse) {

        guard let url = task.currentRequest?.url else {
            throw HTTPMockError.noURLFound
        }

        guard let entry = self.entry(for: task) else {
            throw HTTPMockError.notFound
        }

        return (entry.data, entry.response(for: url))
    }
}
