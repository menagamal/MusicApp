//
//  ApiManager.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/20/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//
import Foundation
import UIKit
import CoreLocation
import ObjectMapper
public class ApiManager: BaseUrlSession {
    
    var delegate: ApiManagerDelegate!
    let baseUrl = Constants.BASE_URL
    
    public enum ActionType {
        case searchArtists,getArtistAlbums,None
    }
    
    override init() {
        super.init()
        
    }
    
    convenience init<T: ApiManagerDelegate>(delegate: T)  {
        self.init()
        
        self.delegate = delegate
    }
    
    func searchArtists(str:String) {
        let  params =  [String: Any]()
        
        let actionType = ActionType.searchArtists
        
        let url = URL(string: "\(baseUrl)artist.search&api_key=\(Constants.API_KEY)&format=json&artist=\(str)")!
        
        requestConnection(action: actionType, method: "get", url: url, body: params, shouldCache: false)
    }
    
    func getArtistAlbums(str:String) {
        let  params =  [String: Any]()
        
        let actionType = ActionType.getArtistAlbums
        
        let url = URL(string: "\(baseUrl)artist.gettopalbums&api_key=\(Constants.API_KEY)&format=json&artist=\(str)")!
        
        requestConnection(action: actionType, method: "get", url: url, body: params, shouldCache: false)
    }
    
    func getUDID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    override func onPreExecute(action: Any) {
        delegate.onPreExecute(action: action as! ApiManager.ActionType)
    }
    
    func onPreExecute(action: ActionType) {
        delegate.onPreExecute(action: action)
    }
    
    override func onSuccess(action: Any, response: URLResponse!, data: Data!) {
        
        let actionType: ActionType = action as! ApiManager.ActionType
        let res = String(data: data, encoding: .utf8)
        print(res ?? "")
        
        do {
            
            var jsonObject = [String: Any]()
            if let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                
                jsonObject = object
            }
            
            var success = true
            
            let code = jsonObject["error"] as? Int ?? -1
            
            if code == Constants.API_FAILED_KEY_CODE {
                success = false
            }
            
            if success {
                switch actionType {
                case .getArtistAlbums:
                    if let results = jsonObject["topalbums"] as? [String:Any]{
                        if let albumsJson = results["album"] as? [[String:Any]] {
                            var albums = [AlbumModel]()
                            for item in albumsJson {
                                let album = AlbumModel(JSON: item)
                                albums.append(album!)
                            }
                            delegate.onPostExecute(status: Status(200, true, ""), action: actionType, response: albums)

                        } else {
                            onFailure(action: actionType, error: NSError(domain: "Something went wrong", code: 404, userInfo: nil))
                        }
                    } else {
                        onFailure(action: actionType, error: NSError(domain: "Something went wrong", code: 404, userInfo: nil))
                    }
                    break
                case.searchArtists:
                    if let results = jsonObject["results"] as? [String:Any]{
                        if let artistmatches = results["artistmatches"] as? [String:Any] {
                            if let artistsJson = artistmatches["artist"] as? [[String:Any]] {
                                var artists = [Artist]()
                                for item in artistsJson {
                                    let artist = Artist(JSON: item)
                                    artists.append(artist!)
                                }
                                delegate.onPostExecute(status: Status(200, true, ""), action: actionType, response: artists)
                            } else {
                                onFailure(action: actionType, error: NSError(domain: "Something went wrong", code: 404, userInfo: nil))
                            }
                        } else {
                             onFailure(action: actionType, error: NSError(domain: "Something went wrong", code: 404, userInfo: nil))
                        }
                } else {
                    onFailure(action: actionType, error: NSError(domain: "Something went wrong", code: 404, userInfo: nil))
                }
                break
                default:
                break
            }
        } else {
            let codeMessage = jsonObject["message"] as? String ?? "Not Found"
            onFailure(action: actionType, error: NSError(domain: codeMessage, code: code, userInfo: nil))
        }
    } catch {
    
    onFailure(action: actionType, error: error as NSError)
    }
}

override func onFailure(action: Any, error: NSError) {
    delegate.onPostExecute(status: Status(error: error), action: action as! ApiManager.ActionType, response: nil)
}
}

public protocol ApiManagerDelegate {
    
    func onPreExecute(action: ApiManager.ActionType)
    
    func onPostExecute(status: BaseUrlSession.Status, action: ApiManager.ActionType, response: Any!)
}
