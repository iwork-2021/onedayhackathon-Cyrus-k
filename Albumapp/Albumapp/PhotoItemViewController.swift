//
//  PhotoItemViewController.swift
//  albumapp
//
//  Created by nju on 2021/12/21.
//

import UIKit

class PhotoItemViewController: UIViewController {

    var photo:UIImage?
    @IBOutlet weak var photoimage: UIImageView!
    override func viewDidLoad() {
        self.photoimage.image = photo
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
