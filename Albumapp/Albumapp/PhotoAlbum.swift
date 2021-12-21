//
//  PhotoAlbum.swift
//  albumapp
//
//  Created by nju on 2021/12/21.
//

import UIKit

class PhotoAlbum: NSObject {
    var title:String
    var photoimage = [UIImage]()
    
    init(title:String)
    {
        self.title = title
    }
}
