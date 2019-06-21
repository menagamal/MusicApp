//
//  AlbumsViewController.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/21/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController ,AlbumView{
    
    var albumViewModel: AlbumsViewModel!
    
    var dataSource:AlbumCollectionDataSource!
    
    @IBOutlet weak var albumsCollection: UICollectionView!
    
    var artist:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumViewModel = AlbumsViewModel(view: self, vc: self)
        let newString = artist.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        albumViewModel.getAllAlbums(str: newString)
        // Do any additional setup after loading the view.
    }
    
    func update(action: AlbumsViewModel.Action) {
        switch action {
        case .idel:
            break
        case .onError(let str):
            Toast.showAlert(viewController: self, text: str)
            break
        case .wait:
            break
        case .getAllAlbums(let albums):
            dataSource = AlbumCollectionDataSource(vc: self, items: albums, currentCollection: albumsCollection)
            break
        }
    }
    
    
    
}
