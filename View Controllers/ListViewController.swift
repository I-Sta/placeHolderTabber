//
//  FirstViewController.swift
//  placeHolderTabber
//
//  Created by Field Employee on 4/6/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage


//MARK: - Image parsing
let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCacheWithUrlString(_ urlString:String){
        self.image = nil
        
        // Check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        //Otherwise fire off a new download
        Alamofire.request(urlString).responseImage {
            response in
            
            if let downloadedImage = response.result.value {
                //Image is here
                imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                self.image = downloadedImage
        }
      }
    }
}

class ViewController: UITableViewController {
    
    let placeHolderURL = "https://jsonplaceholder.typicode.com/photos"
    var albumsArray = [PlaceHolderItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
        // Do any additional setup after loading the view.
    }

    func getJSON(){
    Alamofire.request(placeHolderURL).responseJSON { response in
        
        if response.result.value != nil {
            let json = JSON(response.result.value!) //Convert the responseJSON to SwiftyJSON
            let results = json["results"].arrayValue //Get the results as an array
            
            for (key, result) in json { // Loop through the results for the data we want
               
                let albumId = result["albumId"].intValue
                let id = result["id"].intValue
                let title = result["title"].stringValue
                let images = result["url"].stringValue
                let tImages = result["thumbnailUrl"].stringValue
                
                let albums = PlaceHolderItem()
                albums.albumId = albumId
                albums.id = id
                albums.title = title
                albums.imageUrl = images
                albums.thumbnailUrl = tImages
                //Add each value to the empty arrays we set up
                self.albumsArray.append(albums)
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
    // MARK: - Tableview Functions

    override func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return albumsArray.count
       }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "JSONcell", for: indexPath) as! JSONTableViewCell
        //loads the thumbnails, but is paused till offscreen
        cell.imageView?.loadImageUsingCacheWithUrlString(albumsArray[indexPath.row].thumbnailUrl)
        cell.titleLabel.text = albumsArray[indexPath.row].title
        cell.idLabel.text = "\(albumsArray[indexPath.row].id)"
        cell.albumIdLabel.text = "\(albumsArray[indexPath.row].albumId)"
           return cell
       }

    func tableView(_ tableView: ViewController, canEditRowAt indexPath: IndexPath) -> Bool {
           // Return false if you do not want the specified item to be editable.
           return true
       }

    // MARK: UITableViewDelegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc  = storyboard.instantiateViewController(identifier: "detailView") as? ImageDetail {
            let url = String(_: albumsArray[indexPath.row].imageUrl)
            vc.selectedImage = url
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

