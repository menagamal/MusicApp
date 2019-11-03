//
//  Album.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/20/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class AlbumModel : Mappable , ApiManagerDelegate {
    
    var name:String?
    var url:String?
    var playcount:String?
    var imageStr:String?
    var image:UIImage?
    var imageToBaseStr:String?
    var Count:Int?
    
    private var content:ApiManager!
    
    private var viewModel:AlbumsViewModel!
    
    
    init() {
        
    }
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        var imagesDict = [[String:Any]]()
        name            <- map["name"]
        url             <- map["url"]
        Count       <- map["playcount"]
        playcount = String(Count!)
        imagesDict      <- map["image"]
        imageStr = imagesDict.last?["#text"] as? String ?? ""
        content = ApiManager(delegate: self)

    }
    
    
    init(viewModel:AlbumsViewModel) {
        content = ApiManager(delegate: self)
        self.viewModel = viewModel
    }
    
    
    func getArtistAlbums(str:String)  {
        content.getArtistAlbums(str: str)
    }
    
    
    func onPreExecute(action: ApiManager.ActionType) {
        viewModel.update(action: .wait)
    }
    
    func onPostExecute(status: BaseUrlSession.Status, action: ApiManager.ActionType, response: Any!) {
        viewModel.update(action: .idel)
        if status.success {
            switch action {
            case .getArtistAlbums:
                let albums = response as! [AlbumModel]
                viewModel.update(action: .getAllAlbums(albums: albums))
                break
            default:
                break
            }
        } else {
            viewModel.update(action: .onError(str: status.message))
        }
    }
    
}
