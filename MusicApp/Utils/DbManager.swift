//
//  DbManager.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/21/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DbManager {
    
    var vc:UIViewController!
    
    static let shared = DbManager()

    
    private init() {
        
    }
    
    
    func save(item:AlbumModel) -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Album",
                                       in: managedContext)!
        
        let album = NSManagedObject(entity: entity,insertInto: managedContext)
        
        album.setValue(item.name!, forKeyPath: "name")
        album.setValue(String(item.playcount!), forKeyPath: "playcount")
        album.setValue(item.imageToBaseStr!, forKeyPath: "image")
        do {
            try managedContext.save()
            print("saveed")
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
        return false
    }
    
    
    func delete(item:AlbumModel) -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Album")
        fetchRequest.predicate = NSPredicate(format: "name = %@", item.name!)
        do {
            let testTry = try managedContext.fetch(fetchRequest)
            let objectToDelete = testTry[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            do {
                try managedContext.save()
                return true
            }catch {
                return false
            }
            
        } catch {
            return false
        }
        
        return false
    }
    
    
    func fetchAllAlbums() -> [AlbumModel] {
        var albums = [AlbumModel]()
        var albumsObject: [NSManagedObject] = []

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return [AlbumModel]()
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Album")
        
        //3
        do {
            albumsObject = try managedContext.fetch(fetchRequest)
            
            Constants.FAVOURITE_ALBUMS.removeAll()
            for item in albumsObject {
                var album = AlbumModel()
                album.name = item.value(forKeyPath: "name") as? String
                Constants.FAVOURITE_ALBUMS.append(album.name!)
                album.playcount = item.value(forKeyPath: "playcount") as? String
                album.imageToBaseStr = item.value(forKeyPath: "image") as? String
                albums.append(album)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return albums
    }
    
}
