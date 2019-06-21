//
//  SearchTableDataSource.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/20/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit

class SearchTableDataSource:NSObject,UITableViewDelegate,UITableViewDataSource  {
    var items = [Artist]()
    var table:UITableView!
    var mainVc:UIViewController!
    
    init(vc:UIViewController,items:[Artist],currentTable:UITableView) {
        super.init()
        
        self.mainVc = vc
        self.items = items
        table = currentTable
        table.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        cell.setDetails(artist: items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let vc = main.instantiateViewController(withIdentifier: "AlbumsViewController") as! AlbumsViewController
        vc.artist = items[indexPath.row].name
        mainVc.show(vc, sender: mainVc)
    }
    
  
}
