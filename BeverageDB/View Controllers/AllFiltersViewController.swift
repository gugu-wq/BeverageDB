//
//  AllFiltersViewController.swift
//  BeverageDB
//
//  Created by Gugu Ndaba on 2021/08/04.
//

import UIKit

class AllFiltersViewController: UITableViewController {
    @IBOutlet var allFiltersTableView: UITableView!
    
    var filterOptions = [BeverageInfo]()            
    var filtersUrl: String?
    var filteredOption: String?
    var filterIngredient: String?
    var filterGlass: String?
    var filterCategory: String?
    var filterAlcoholic: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("filtersUrl")
        self.getCategoriesJSON {
            print("filtersUrl: \(self.filtersUrl!)")
            print("filteredOption: \(self.filteredOption!)")
            
            self.allFiltersTableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filterOptions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allFiltersCell", for: indexPath) as! AllFiltersCell
        
        switch filteredOption {
        case "Categories":
            filterCategory = filterOptions[indexPath.row].strCategory!
            cell.allFiltersLabel?.text = filterOptions[indexPath.row].strCategory!
            
        case "Glasses":
            filterGlass = filterOptions[indexPath.row].strGlass!
            cell.allFiltersLabel?.text = filterOptions[indexPath.row].strGlass!
            
        case "Alcoholic":
            filterAlcoholic = filterOptions[indexPath.row].strAlcoholic!
            cell.allFiltersLabel?.text = filterOptions[indexPath.row].strAlcoholic!
            
        case "Ingredients":
            filterIngredient = filterOptions[indexPath.row].strIngredient1!
            cell.allFiltersLabel?.text = filterOptions[indexPath.row].strIngredient1!
        default:
            print("No filter selectd")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails3", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FilteredBevViewController {
            
            switch filteredOption {
            case "Categories":
                destination.filterCategory = filterOptions[(allFiltersTableView.indexPathForSelectedRow?.row)!].strCategory
                destination.filteredOption = filteredOption
                
            case "Glasses":
                destination.filterGlass = filterOptions[(allFiltersTableView.indexPathForSelectedRow?.row)!].strGlass
                destination.filteredOption = filteredOption
                
            case "Alcoholic":
                destination.filterAlcoholic = filterOptions[(allFiltersTableView.indexPathForSelectedRow?.row)!].strAlcoholic
                destination.filteredOption = filteredOption
                
            case "Ingredients":
                destination.filterIngredient = filterOptions[(allFiltersTableView.indexPathForSelectedRow?.row)!].strIngredient1
                destination.filteredOption = filteredOption
                
            default:
                print("No filter selected")
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getCategoriesJSON(completed: @escaping () -> ()) {
        let url = URL(string: (filtersUrl)!)!
        let urlSession = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        let task = urlSession.dataTask(with: urlRequest) {
            data, urlResponse, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let unwrappedData = data else {
                print("No data")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                self.filterOptions = try jsonDecoder.decode(AllBeverages.self, from: unwrappedData).drinks
                DispatchQueue.main.async {
                    completed()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
