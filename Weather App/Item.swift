//
//  Item.swift
//  Weather App
//
//  Created by Nuveda on 24/06/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
