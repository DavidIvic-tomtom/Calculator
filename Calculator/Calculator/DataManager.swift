//
//  DataManager.swift
//  Calculator
//
//  Created by David on 13.3.25..
//

import Foundation

// Update this class to be more efficent.
// We shouldn't save data on each vector update.

class DataManager {
    static let shared = DataManager()
    private let dataKey = "privateKey"
    
    func saveData(inputData: [ToDoItem]) {
        if let encoded = try? JSONEncoder().encode(inputData) {
            UserDefaults.standard.set(encoded, forKey: dataKey)
        }
    }
    
    func loadData() -> [ToDoItem]? {
        if let savedData = UserDefaults.standard.data(forKey: dataKey) {
            if let decoded = try? JSONDecoder().decode([ToDoItem].self, from: savedData) {
                return decoded
            }
        }
        return nil
    }
}
