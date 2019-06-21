//
//  ViewController.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/20/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {

    @IBOutlet weak var favouriteCollection: UICollectionView!
    
    var albums = [AlbumModel]()
    
    @IBOutlet weak var albumsCollection: UICollectionView!
    
    var dataSource:FavouriteDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchFromDb()
    }
    
    
    func fetchFromDb() {
        albums = DbManager.shared.fetchAllAlbums()
        dataSource = FavouriteDataSource(vc: self, items: albums, currentCollection: albumsCollection)
    }

    @IBAction func search(_ sender: UIBarButtonItem) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let vc = main.instantiateViewController(withIdentifier: "SearchViewController")
        self.show(vc, sender: self)
    }
    
}

