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

        filteredModels = models
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.delegate = self
        searchController?.searchBar.placeholder = "Buscar carros"
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    func hideKeyboard() {
        searchController?.searchBar.resignFirstResponder()
        searchController?.searchBar.endEditing(true)
    }
    
    func filterModelForSearchText(_ searchText: String) {
        filteredModels = models.filter { $0.lowercased().contains(searchText.lowercased()) }
        if filteredModels.count == 0 {
            filteredModels = models
        }
        tableView.reloadData()
    }

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = filteredModels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        hideKeyboard()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filterModelForSearchText(searchText)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideKeyboard()
    }
}
