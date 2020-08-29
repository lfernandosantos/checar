//
//  SearchViewController.swift
//  canivete
//
//  Created by Luiz Fernando dos Santos on 26/08/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    var models: [String] = ["Fiat", "Chevrolet", "Woskvagem", "BMW", "Renault","Fiat", "Chevrolet", "Woskvagem", "BMW", "Renault","Fiat", "Chevrolet", "Woskvagem", "BMW", "Renault","Fiat", "Chevrolet", "Woskvagem", "BMW", "Renault", "Fiat", "Chevrolet", "Woskvagem", "BMW", "Renault"]
    var filteredModels: [String] = []
    var searchController: UISearchController?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController?.searchResultsUpdater = self
        self.searchController?.searchBar.placeholder = "Buscar carros"
        navigationItem.searchController = self.searchController
        
        definesPresentationContext = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
    }
    
    func filterModelForSearchText(_ searchText: String) {
        self.filteredModels = self.models.filter { $0.lowercased().contains(searchText.lowercased()) }
        self.tableView.reloadData()
    }

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.filteredModels[indexPath.row]
        return cell
    }
    
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        self.filterModelForSearchText(searchText)
        

        
    }
    
    
}
