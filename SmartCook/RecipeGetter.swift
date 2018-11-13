//
//  RecipeGetter.swift
//  SmartCook
//
//  Created by Aditi on 01/11/18.
//  Copyright © 2018 Aditi. All rights reserved.
//

import Foundation

protocol RecipeGetterDelegate {
    func didGetRecipe(recipes: [Recipe])
    func didNotGetRecipe(error: NSError)
}

class RecipeGetter {
    private let EdamamBaseURL = "https://api.edamam.com/search"
    private let EdamamAPIKey = "42f931ca62b8f4615337f297ff13518f"
    private let EdamamAPPId = "8a6c3dd9"
    private var delegate: RecipeGetterDelegate
    init(delegate: RecipeGetterDelegate) {
        self.delegate = delegate
    }
    func getRecipe(ingredient: String) {
        
        // This is a pretty simple networking task, so the shared session will do.
        let session = URLSession.shared
        let ingr = ingredient.replacingOccurrences(of: " ", with: "%20")
        let RecipeRequestURL = URL(string: "\(EdamamBaseURL)?&q=\(ingr)&app_id=\(EdamamAPPId)&app_key=\(EdamamAPIKey)")!
        
        // The data task retrieves the data.
        let dataTask = session.dataTask(with: RecipeRequestURL){
            (data, response, error) in
            if let error = error {
                // Case 1: Error
                // We got some kind of error while trying to get data from the server.
                self.delegate.didNotGetRecipe(error: error as NSError)
            }
            else {
                // Case 2: Success
                // We got a response from the server!
                let dataString = String(data: data!, encoding: String.Encoding.utf8)
                print("Human-readable data:\n\(dataString!)")
                do {
                    // Try to convert that data into a Swift dictionary
                    let json = try JSONSerialization.jsonObject(
                        with: data!,
                        options: []) as! [String:Any]
                    let hits = json["hits"] as! [[String:Any]]
                    var recipeList = [Recipe]()
                    for hit in hits {
                        let recipe = hit["recipe"] as! [String:Any]
                        recipeList.append(Recipe(label: recipe["label"] as! String, url: recipe["url"] as! String, image: recipe["image"] as! String))
                    }
                    self.delegate.didGetRecipe(recipes: recipeList)
                    
                }catch let jsonError as NSError {
                    // An error occurred while trying to convert the data into a Swift dictionary.
                    self.delegate.didNotGetRecipe(error: jsonError)
                }
            }
        }
        // The data task is set up...launch it!
        dataTask.resume()
    }
}
