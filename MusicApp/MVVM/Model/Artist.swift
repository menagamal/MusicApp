//
//  Artist.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/20/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import ObjectMapper

class Artist : Mappable , ApiManagerDelegate {
    
    var name:String?
    var url:String?
    var listeners:String?
    
    private var content:ApiManager!
    
    private var viewModel:SearchViewModel!
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        name            <- map["name"]
        url             <- map["url"]
        listeners       <- map["listeners"]
    }
    
    init(viewModel:SearchViewModel) {
        content = ApiManager(delegate: self)
        self.viewModel = viewModel
    }
    
    func searchArtist(str:String)  {
        content.searchArtists(str: str)
    }
    
    func onPreExecute(action: ApiManager.ActionType) {
        viewModel.update(action: .wait)
    }
    
    func onPostExecute(status: BaseUrlSession.Status, action: ApiManager.ActionType, response: Any!) {
        viewModel.update(action: .idel)
        if status.success { 
            switch action {
            case .searchArtists:
                let artists = response as! [Artist]
                viewModel.update(action: .searchArtists(artists:artists))
                break
            default:
                break
            }
        } else {
            viewModel.update(action: .onError(str: status.message))
        }
    }
    
    
}
