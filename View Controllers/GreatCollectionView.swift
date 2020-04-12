//
//  SecondViewController.swift
//  placeHolderTabber
//
//  Created by Field Employee on 4/6/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//
import UIKit
import SwiftyJSON
import Alamofire

class GreatCollectionView: UICollectionViewController {
    
    
    
    
  @IBOutlet weak var coreCollectionView: UICollectionView!
    
    var albumsArray = [PlaceHolderItem]()
    let placeHolderURL = "https://jsonplaceholder.typicode.com/photos"
    
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
                        self.coreCollectionView.reloadData()
                    }
                }
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coreCollectionView.dataSource = self
        getJSON()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumsArray.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! GreatCollectionViewCell
        cell.imageView?.loadImageUsingCacheWithUrlString(albumsArray[indexPath.row].thumbnailUrl)
        return cell
    }
    func collectionView(_ tableView: UICollectionView, canEditRowAt indexPath: IndexPath) -> Bool {
             // Return false if you do not want the specified item to be editable.
             return true
         }
    func collectionView(_ tableView: UICollectionView, didSelectRowAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc  = storyboard.instantiateViewController(identifier: "detailView") as? ImageDetail {
                let url = String(_: albumsArray[indexPath.row].imageUrl)
                vc.selectedImage = url
                navigationController?.pushViewController(vc, animated: true)
        }
     

    }
    }
