//
//  MenuViewController.swift
//  CraveApp
//
//  Created by Alex Cole on 10/28/20.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.5,
                                 height: UIScreen.main.bounds.height / 4)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        return view
    }()
    
    //MARK: - Variables
    
    var items = [MenuItem]()
    
    var filteredItems = [MenuItem]()
    
    var searchResults = [MenuItem]()
    
    var searchActive = false
    
    var appliedFilters = Set<Categories>()
    
    //MARK: - View Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Menu"
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
        
        getMenuItems()
        
        let searchController = UISearchController()
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    override func viewWillLayoutSubviews() {
        collectionView.frame = view.frame
    }
    
    //MARK: - Helper Functions
    
    func getMenuItems() {
        FirestoreManager.shared.getAllMenuItems(completion: { [weak self] result in
            switch result {
            case .success(let menuItems):
                self?.items = menuItems
                self?.filteredItems = menuItems
                self?.collectionView.reloadData()
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }
    
    @objc func filterTapped() {
        let vc = FilterViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.appliedFilters = appliedFilters
        
        //This completion needs to call the sorting function on items list with appliedFilters as parameter
        vc.completion = { [weak self] set in
            print(set)
            self?.appliedFilters = set
            print(self?.appliedFilters ?? "")
            
            self?.filterResults()
        }
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true)
    }
    
    // Returns all items that satisfy ALL filters. If there are multiple filters applied,
    // Items must have each of those categories or they won't show
    func filterResults() {
        filteredItems = items.filter { item in
            return appliedFilters.allSatisfy({ (element: Categories) in
                return item.categories.contains(element.rawValue)
            })
        }
        
        collectionView.reloadData()
    }
}

//MARK: - UICollectionView Protocols

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive {
            return searchResults.count
        } else {
            return filteredItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var model: MenuItem
        
        if searchActive {
            model = searchResults[indexPath.row]
        } else {
            model = filteredItems[indexPath.row]
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
        
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var item: MenuItem
        
        if searchActive {
            item = searchResults[indexPath.row]
        } else {
            item = filteredItems[indexPath.row]
        }
        
        let vc = MenuItemViewController()
        vc.item = item
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionView Layout Delegate

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,
                            left: 25,
                            bottom: 0,
                            right: 25)
    }
}

//MARK: - UISearchController Delegate

extension MenuViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }
        
        searchResults = filteredItems.filter { item in
            return item.name.localizedCaseInsensitiveContains(searchString)
        }
        
        if searchString == "" {
            searchResults = filteredItems
        }
        
        collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        
        if searchBar.text == "" {
            searchResults = filteredItems
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            searchActive = false
            collectionView.reloadData()
        } else {
            searchActive = true
        }
    }
}
