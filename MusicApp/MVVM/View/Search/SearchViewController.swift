//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/20/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController , SearchView , UISearchBarDelegate{
    
    var searchViewModel: SearchViewModel!
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    var dataSource:SearchTableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel = SearchViewModel(view: self, vc: self)
        searchBarOutlet.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            let newString = searchText.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
            searchViewModel.searchArtist(str: newString)
        }
    }
    
    func update(action: SearchViewModel.Action) {
        switch action {
        case .idel:
            break
        case .onError(let str):
            Toast.showAlert(viewController: self, text: str)
            break
        case .wait:
            break
        case .searchArtists(let artists):
            dataSource = SearchTableDataSource(vc: self, items: artists, currentTable: searchTableView)
            break
        }
    }
    
    

}
