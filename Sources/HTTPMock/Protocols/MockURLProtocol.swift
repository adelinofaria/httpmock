//
//  MockURLProtocol.swift
//  HTTPMock
//
//  Created by Adelino Faria on 03/10/2024.
//  Copyright © 2024 Adelino Faria. All rights reserved.
//

import Foundation

enum MockURLProtocolError: Error {
    case unknown
    case delegateNotSet
    case noURLSessionTask
}

protocol MockURLProtocolDelegate {
    func canInit(task: URLSessionTask) -> Bool
    func processRequest(with task: URLSessionTask) throws -> (Data, URLResponse)
}

final class MockURLProtocol: URLProtocol {

    nonisolated(unsafe) static var delegate: MockURLProtocolDelegate?

    override class func canInit(with task: URLSessionTask) -> Bool {

        let canInit = self.delegate?.canInit(task: task) ?? false

        return canInit
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {

        return request
    }

    override func startLoading() {

        if let delegate = Self.delegate {

            if let task = self.task {

                do {

                    let (data, response) = try delegate.processRequest(with: task)

                    self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                    self.client?.urlProtocol(self, didLoad: data)
                    self.client?.urlProtocolDidFinishLoading(self)

                } catch {

                    self.client?.urlProtocol(self, didFailWithError: error)
                }

            } else {

                self.client?.urlProtocol(self, didFailWithError: MockURLProtocolError.noURLSessionTask)
            }

        } else {

            self.client?.urlProtocol(self, didFailWithError: MockURLProtocolError.delegateNotSet)
        }
    }
    override func stopLoading() {

    }
}
