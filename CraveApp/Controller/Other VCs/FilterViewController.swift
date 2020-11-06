//
//  FilterViewController.swift
//  CraveApp
//
//  Created by Alex Cole on 10/28/20.
//

import UIKit

class FilterViewController: UIViewController {
    
    //MARK: - UI Elements
    
    var tableView: UITableView = {
        let view = UITableView()
        view.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.identifier)
        return view
    }()
    
    //MARK: - Variables
    
    var categories = ["Entree", "Appetizer", "Drink", "Rice Plate", "Adobo", "Sisig", "Chicken", "Pork", "Beef", "Shrimp", "Crab"]
    
    var selectedCategories: [String: Bool] = [:]
    
    var appliedFilters = Set<Categories>()
    
    var completion: ((Set<Categories>) -> Void)!
    
    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Filter"
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(doneTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear All",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(clearTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Change state to checked for buttons who's category appears in appliedFilters
        //We have a dictionary called selectedCategories that maps row titles to a bool value
        //This function takes all Categories objects from appliedFilters set, maps them to row titles, and
        //  sets the value of the title in selectedCategories dict to true if the filter exists.
        
        for filter in appliedFilters {
            var item: String
            
            switch filter {
            case Categories.entree:
                item = "Entree"
            case Categories.appetizer:
                item = "Appetizer"
            case Categories.drink:
                item = "Drink"
            case Categories.chicken:
                item = "Chicken"
            case Categories.pork:
                item = "Pork"
            case Categories.beef:
                item = "Beef"
            case Categories.shrimp:
                item = "Shrimp"
            case Categories.crab:
                item = "Crab"
            case Categories.adobo:
                item = "Adobo"
            case Categories.sisig:
                item = "Sisig"
            case Categories.ricePlate:
                item = "Rice Plate"
            default:
                print("This should not have happened")
                item = "Entree"
            }
            
            selectedCategories[item] = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.frame
    }

    override func viewWillDisappear(_ animated: Bool) {
        // Calls completion function, passing back set of selected filters to MenuViewController
        
        completion(appliedFilters)
    }
    
    //MARK: - Nav Item Button Tap Handler
    
    @objc func doneTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func clearTapped() {
        selectedCategories.removeAll()
        appliedFilters.removeAll()
        tableView.reloadData()
    }
    
}

//MARK: - UITableViewDelegate & DataSource Extension

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier, for: indexPath) as! FilterTableViewCell
        
        cell.configure(with: model)
        
        if selectedCategories[model] == true {
            cell.checkBtn.isChecked = true
        } else {
            cell.checkBtn.isChecked = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterTableViewCell
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let text = cell.textLabel?.text else {
            return
        }
        
        // Maps row title to Categories object
        
        var item: Categories
        
        switch text {
        case "Entree": item = Categories.entree
        case "Appetizer": item = Categories.appetizer
        case "Drink": item = Categories.drink
        case "Chicken": item = Categories.chicken
        case "Pork": item = Categories.pork
        case "Beef": item = Categories.beef
        case "Shrimp": item = Categories.shrimp
        case "Crab": item = Categories.crab
        case "Adobo": item = Categories.adobo
        case "Sisig": item = Categories.sisig
        case "Rice Plate": item = Categories.ricePlate
        default:
            print("This should not have happened")
            item = Categories.entree
        }
        
        // Adds & removes categories from appliedFilters set depending on if they're currently selected
        
        if cell.checkBtn.isChecked {
            cell.checkBtn.checkBtn()
            appliedFilters.remove(item)
            selectedCategories[text] = false
        } else {
            cell.checkBtn.checkBtn()
            appliedFilters.insert(item)
            selectedCategories[text] = true
        }
        
        print(appliedFilters)
    }

}
