//
//  BevDetailsViewController.swift
//  BeverageDB
//
//  Created by Gugu Ndaba on 2021/08/04.
//

import UIKit
import Foundation

class BevDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alcContentLabel: UILabel!
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var instructLbl: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    var beverageId: String?
    var beverageDetails = [BeverageInfo]()
    var simpleArray: BeverageInfo?
    var ingredients: [String] = []
    var quantity: [String] = []
    var instructions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Received Id: \(beverageId!)")
        
        getBeverageDetailsJSON {
            self.simpleArray = self.beverageDetails[0]
            self.update()
            self.ingredientsTableView.reloadData()
        }
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientsTableView.dequeueReusableCell(withIdentifier: "ingredientsCell") as! IngredientsCell
        
        cell.ingredientsLabel?.text = ingredients[indexPath.row]
        cell.quantityLabel?.text = quantity[indexPath.row]
        
        return cell
    }
    
    func removeWhiteSpaces(str: String) -> String {
        var newString = str
        for i in 0 ..< str.count{
            let index = str.index(str.startIndex, offsetBy: i)
            print(str[index])
            if str[index] != " " {
                return newString
            }
            else {
                newString.remove(at: newString.startIndex)
            }
        }
        return newString
    }
    
    func update() {
        self.idLabel.text = self.simpleArray?.idDrink
        self.nameLabel.text = self.simpleArray?.strDrink
        self.alcContentLabel.text = self.simpleArray?.strAlcoholic
        self.detailsImageView.downloadImage(from: self.simpleArray?.strDrinkThumb ?? "")
        detailsImageView.layer.cornerRadius = detailsImageView.frame.size.width / 2
        self.instructionsLabel.text = self.simpleArray?.strInstructions
        
        let reflection = Mirror(reflecting: simpleArray!)
        
        let theInstructions = self.simpleArray!.strInstructions
        
        let separateStringArray = theInstructions!.split(separator: ".").map({ (substring) in
            return String(substring)
        })
        
        instructions = separateStringArray
        
        for i in 0 ..< instructions.count {
            instructions[i] = removeWhiteSpaces(str: instructions[i])
        }
        
        instructionsLabel.text = ""
        
        for i in 0 ..< instructions.count {
            instructionsLabel.text?.append("\(i+1): \(instructions[i]) \n\n")
        }
        
        for child in reflection.children {
            let theValue = child.value as? String
            if child.label!.contains("Ingredient") && theValue != nil {
                ingredients.append("\((theValue)!)")
            }
        }
        
        for child in reflection.children {
            let theValue = child.value as? String
            if (child.label!.contains("Measure")) && theValue != nil {
                quantity.append(theValue ?? "")
            }
        }
        
        self.ingredientsTableView.reloadData()
    }
    
    func getBeverageDetailsJSON(completed: @escaping () -> ()) {
        let queryURL = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(beverageId!)"
        
        let url = URL(string: queryURL)!
            let urlSession = URLSession.shared
            let urlRequest = URLRequest(url: url)

            let task = urlSession.dataTask(with: urlRequest)
            {
                data, urlResponse, error in
                
                if let error = error
                {
                    
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let unwrappedData = data else
                {
                    print("No data")
                    return
                }
                
                
                let jsonDecoder = JSONDecoder()

            do
            {
                self.beverageDetails = try jsonDecoder.decode(AllBeverages.self, from: unwrappedData).drinks
                    DispatchQueue.main.async
                    {
                        completed()
                    }
                } catch {
                    print(error)
                }
            }.resume()
    }
}
