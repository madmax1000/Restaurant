//
//  menu.swift
//  Restaurant
//
//  Created by M.D. Bijkerk on 09-05-18.
//  Copyright © 2018 M.D. Bijkerk. All rights reserved.
//

import Foundation

// create a MenuItem struct
struct MenuItem: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case category
        case imageURL = "image_url"
    }
}

// create a MenuItems struct
struct MenuItems: Codable {
    let items: [MenuItem]
}



