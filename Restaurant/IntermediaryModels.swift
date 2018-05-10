//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by M.D. Bijkerk on 09-05-18.
//  Copyright © 2018 M.D. Bijkerk. All rights reserved.
//

import Foundation

// create an intermadiary Categories struct
struct Categories: Codable {
    let categories: [String]
}

// create an intermediary PreperationTime
struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}




