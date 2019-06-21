//
//  AlbumDetailsViewController.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/21/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class AlbumDetailsViewController: UIViewController {

    @IBOutlet weak var labelPlaycounts: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var albumImageView: CircularImageView!
    
    var item:AlbumModel!
    
    var favouriteBtn:UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if Constants.FAVOURITE_ALBUMS.contains(item.name!) {
            favouriteBtn = UIBarButtonItem(title: "unFavourite", style: .plain, target: self, action: #selector(removeToDB))
        } else {
            favouriteBtn = UIBarButtonItem(title: "Favourite", style: .plain, target: self, action: #selector(saveToDB))
        }
        
        
        self.navigationItem.rightBarButtonItem = favouriteBtn
        labelName.text = item.name
        labelPlaycounts.text = String(item.playcount!)
        
        if item.imageStr != nil {
            self.getImageFromUrl(str: item.imageStr!)
        } else {
            let dataDecoded : Data = Data(base64Encoded: self.item.imageToBaseStr!, options: .ignoreUnknownCharacters)!
            let decodedimage:UIImage = UIImage(data: dataDecoded)!
            self.albumImageView.image = decodedimage
            
        }
        
    }
    
    
    @objc
    func removeToDB() {
        if DbManager.shared.delete(item: item) {
            Toast.showAlert(viewController: self, text: "Deleted")
            Constants.FAVOURITE_ALBUMS.removeAll { (str) -> Bool in
                str == item.name
            }
            favouriteBtn = UIBarButtonItem(title: "Favourite", style: .plain, target: self, action: #selector(saveToDB))
            self.navigationItem.rightBarButtonItem = favouriteBtn

        } else {
            Toast.showAlert(viewController: self, text: "Something Went Wroung")
        }
    }
    
    @objc
    func saveToDB() {
        
        let imageData = albumImageView.image!.pngData()
        item.imageToBaseStr = imageData!.base64EncodedString(options: .lineLength76Characters)

        if DbManager.shared.save(item: item) {
            Toast.showAlert(viewController: self, text: "Saved")
            Constants.FAVOURITE_ALBUMS.append(item.name!)
            
            favouriteBtn = UIBarButtonItem(title: "unFavourite", style: .plain, target: self, action: #selector(removeToDB))
            self.navigationItem.rightBarButtonItem = favouriteBtn

        } else {
            Toast.showAlert(viewController: self, text: "Something Went Wroung")
        }
        
    }
    
    func getImageFromUrl(str:String) {
        
        Alamofire.request(str).responseImage { response in
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                self.albumImageView.image = image
            }
            
        }
    }
    
}
