//
//  AlbumsDataSource.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/21/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit

class AlbumCollectionDataSource:NSObject,UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    
    var items = [AlbumModel]()
    var collection:UICollectionView!
    var mainVc:UIViewController!
    
    init(vc:UIViewController,items:[AlbumModel],currentCollection:UICollectionView) {
        super.init()
        
        self.mainVc = vc
        self.items = items
        collection = currentCollection
        collection.register(UINib(nibName: "AlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AlbumCollectionViewCell")
        
        collection.dataSource = self
        
        collection.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell",for: indexPath) as! AlbumCollectionViewCell
        cell.setDetails(album: items[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let vc = main.instantiateViewController(withIdentifier: "AlbumDetailsViewController") as! AlbumDetailsViewController
        vc.item = items[indexPath.row]
        mainVc.show(vc, sender: mainVc)
    }
    
     func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 1
        let width = collectionView.frame.size.width / 2.3 - padding
        let height = collectionView.frame.size.height / 2.3 - padding
        return CGSize(width: width, height: height)
        
        
    }
    
    
}
