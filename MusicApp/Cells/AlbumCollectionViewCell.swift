//
//  AlbumCollectionViewCell.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/21/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var albumImageView: CircularImageView!
    @IBOutlet weak var labelAlbumName: UILabel!
    
    var content:ApiManager!
    
    var album:AlbumModel!
    
    func setDetails(album:AlbumModel)  {
        
        self.album = album
        labelAlbumName.text = album.name
        if album.imageStr != nil {
            
            self.getImageFromUrl(str: album.imageStr!)
            
        } else {
            let dataDecoded : Data = Data(base64Encoded: self.album.imageToBaseStr!, options: .ignoreUnknownCharacters)!
            let decodedimage:UIImage = UIImage(data: dataDecoded)!
            self.albumImageView.image = decodedimage
            
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
