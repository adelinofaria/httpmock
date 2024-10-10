//
//  ExpressionTreeNode.swift
//  HTTPMock
//
//  Created by Adelino Faria on 10/10/2024.
//  Copyright © 2024 Adelino Faria. All rights reserved.
//

import Foundation

enum ExpressionTreeNode<Value: Sendable> {
    case value(Value)
    case `operator`(ExpressionTreeOperator<Value>, value: Value)
    case nested(ExpressionTreeOperator<Value>, nodes: [ExpressionTreeNode<Value>])

    func matches(predicate: (Value) -> Bool) -> Bool {

        switch self {
        case .value(let value):
            predicate(value)
        case .operator(_, value: let value):
            predicate(value)
        case .nested(_, nodes: let nodes):
            nodes.allSatisfy { $0.matches(predicate: predicate) }
        }
    }
}
