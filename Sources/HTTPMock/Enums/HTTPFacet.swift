//
//  HTTPFacet.swift
//  HTTPMock
//
//  Created by Adelino Faria on 03/10/2024.
//  Copyright © 2024 Adelino Faria. All rights reserved.
//

import Foundation

public enum HTTPFacet: Sendable {
    case method(HTTPFacetMethod)
    case scheme(String)
    case host(String)
    case port(Int)
    case path(String)
    case queryString([String: String])
    case fragment(String)
    case httpHeaders([String: String])
//    case body (future)

    case urlRequest(URLRequest)
    case absoluteURL(URL)

    // MARK: Functions

    func matches(_ task: URLSessionTask) -> Bool {

        switch self {
        case .method(let method):
            task.currentRequest?.httpMethod == method.rawValue
        case .scheme(let scheme):
            task.currentRequest?.url?.scheme == scheme
        case .host(let host):
            task.currentRequest?.url?.host() == host
        case .port(let port):
            task.currentRequest?.url?.port == port
        case .path(let path):
            task.currentRequest?.url?.path() == path
        case .queryString(_):
            // FIXME: needs to compare against particular key/value
//            task.currentRequest?.url?.query() == queryString
            false
        case .fragment(let fragment):
            task.currentRequest?.url?.fragment() == fragment
        case .httpHeaders(_):
            // FIXME: needs to compare against particular key/value
            false
        case .urlRequest(let urlRequest):
            task.currentRequest == urlRequest
        case .absoluteURL(let url):
            task.currentRequest?.url == url
        }
    }

    // MARK: Operators

    static func & (lhs: Self, rhs: Self) -> ExpressionTree<Self> {
        .init(nodes: [.value(lhs), .operator(.and, value: rhs)])
    }

    static func | (lhs: Self, rhs: Self) -> ExpressionTree<Self> {
        .init(nodes: [.value(lhs), .operator(.or, value: rhs)])
    }

    static func & (lhs: ExpressionTree<Self>, rhs: Self) -> ExpressionTree<Self> {
        lhs.appending(node: .operator(.and, value: rhs))
    }

    static func | (lhs: ExpressionTree<Self>, rhs: Self) -> ExpressionTree<Self> {
        lhs.appending(node: .operator(.or, value: rhs))
    }

    static func & (lhs: Self, rhs: ExpressionTree<Self>) -> ExpressionTree<Self> {
        .init(nodes: [.value(lhs), .nested(.and, nodes: rhs.nodes)])
    }

    static func | (lhs: Self, rhs: ExpressionTree<Self>) -> ExpressionTree<Self> {
        .init(nodes: [.value(lhs), .nested(.or, nodes: rhs.nodes)])
    }
}
