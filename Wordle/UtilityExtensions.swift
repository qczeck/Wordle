//
//  UtilityExtensions.swift
//  Wordle
//
//  Created by Maciej Kuczek on 20/02/2022.
//

import Foundation

extension FileManager {
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension Array where Element: Equatable {
    mutating func appendWithoutDuplicating(_ element: Element) {
        if !self.contains(element) {
            self.append(element)
        }
    }
}
