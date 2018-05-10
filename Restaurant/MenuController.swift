//
//  MenuController.swift
//  Restaurant
//
//  Created by M.D. Bijkerk on 09-05-18.
//  Copyright © 2018 M.D. Bijkerk. All rights reserved.
//

import Foundation
import UIKit

    class MenuController {
        
        // create an instance that is shared amongst all controllers
        static let shared = MenuController()
        
        let baseURL = URL(string: "https://resto.mprog.nl/")!

    // GET method for fetching the categories from the JSON
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
        let jsonDecoder = JSONDecoder()
            if let data = data,
                let categories = try? jsonDecoder.decode(Categories.self, from: data) {
                completion(categories.categories)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }

    // GET method for fetching the items from the JSON
    func fetchMenuItems(categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
        
    // POST method to gather the consumer's menu choices
    func submitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
     
    // fetch the image
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
        

       
}




