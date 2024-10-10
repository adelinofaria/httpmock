//
//  ExpressionTreeOperator.swift
//  HTTPMock
//
//  Created by Adelino Faria on 10/10/2024.
//  Copyright © 2024 Adelino Faria. All rights reserved.
//

import Foundation

enum ExpressionTreeOperator<Value: Sendable> {
    case not
    case and
    case or
}
