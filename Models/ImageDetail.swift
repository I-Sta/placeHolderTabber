//
//  ImageDetai.swift
//  placeHolderTabber
//
//  Created by Field Employee on 4/8/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit

class ImageDetail: UIViewController {
//    
//
    @IBOutlet weak var imageMax: UIImageView!
    var selectedImage: String?
    
    
//
override func viewDidLoad() {
    super.viewDidLoad()

    if let imageToLoad = selectedImage {
        guard let url = URL(string: imageToLoad ) else{
            return
        }
        if let data = try? Data(contentsOf: url){
        let image2 = UIImage(data: data)
        imageMax.image = image2
            }
        }
    }
}
