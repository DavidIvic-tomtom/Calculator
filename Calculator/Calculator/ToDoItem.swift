//
//  ToDoItem.swift
//  Calculator
//
//  Created by David on 10.3.25..
//

import Foundation

struct ToDoItem : Codable {
    let title: String
    let description: String?
    let untilDate: Date?
}
