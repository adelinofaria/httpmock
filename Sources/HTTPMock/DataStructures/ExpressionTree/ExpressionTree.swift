//
//  ExpressionTree.swift
//  HTTPMock
//
//  Created by Adelino Faria on 10/10/2024.
//  Copyright © 2024 Adelino Faria. All rights reserved.
//

import Foundation

struct ExpressionTree<Value: Sendable> {

    // MARK: Properties

    let nodes: [ExpressionTreeNode<Value>]

    // MARK: Initializers

    internal init(nodes: [ExpressionTreeNode<Value>]) {

        self.nodes = nodes
    }

    func appending(node: ExpressionTreeNode<Value>) -> Self {

        .init(nodes: self.nodes + [node])
    }

    func matches(predicate: (Value) -> Bool) -> Bool {

        self.nodes.allSatisfy { $0.matches(predicate: predicate) }
    }

    // MARK: Operators

    static func & (lhs: Self, rhs: Self) -> Self {

        lhs.appending(node: .nested(.and, nodes: rhs.nodes))
    }

    static func | (lhs: Self, rhs: Self) -> Self {

        lhs.appending(node: .nested(.or, nodes: rhs.nodes))
    }
}

// MARK: CustomDebugStringConvertible

extension ExpressionTree: CustomDebugStringConvertible where Value: CustomDebugStringConvertible {
    var debugDescription: String {

        self.nodes.map { $0.debugDescription }.joined(separator: " ")
    }
}

extension ExpressionTreeNode: CustomDebugStringConvertible where Value: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .value(let value):
            value.debugDescription
        case .operator(let op, value: let value):
            ".\(op.debugDescription)(\(value.debugDescription))"
        case .nested(let op, nodes: let nodes):
            ".nested(.\(op.debugDescription), \(nodes.debugDescription))"
        }
    }
}

extension ExpressionTreeOperator: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .not:
            "not"
        case .and:
            "and"
        case .or:
            "or"
        }
    }
}

extension HTTPFacet: CustomDebugStringConvertible {
    public var debugDescription: String {
        "value"
    }
}
