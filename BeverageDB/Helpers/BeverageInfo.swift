//
//  BeverageInfo.swift
//  BeverageDB
//
//  Created by Gugu Ndaba on 2021/08/04.
//

import Foundation
import UIKit

struct AllBeverages: Decodable {
    let drinks: [BeverageInfo]
}

struct BeverageInfo: Decodable {
    let idDrink: String?
    let strDrink: String?
    let strCategory: String?
    let strAlcoholic: String?
    let strGlass: String?
    let strInstructions: String?
    let strDrinkThumb: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
}

struct FilterItem: Identifiable{
    let id = UUID()
    let name: String
    let image: String
    let url: String
}

extension FilterItem {
    static func all() -> [FilterItem] {
        return
        ([FilterItem(
            name: "Categories",
            image:"CategoriesIMG",
            url:"https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list"),
         FilterItem(
             name: "Glasses",
            image:"GlassesIMG",
            url:"https://www.thecocktaildb.com/api/json/v1/1/list.php?g=list"),
         FilterItem(
             name: "Ingredients",
            image:"IngredientsIMG",
            url:"https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"),
         FilterItem(
             name: "Alcoholic",
            image:"AlcoholicIMG",
            url:"https://www.thecocktaildb.com/api/json/v1/1/list.php?a=list")
    ]
        )
    }
}

extension UIImageView {
    func getUIImage(from url: URL, contentMode mode: ContentMode = .scaleToFill)
    {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloadImage(from link: String, contentMode mode: ContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        getUIImage(from: url, contentMode: mode)
    }
}
