//
//  PhotosDetailViewController.swift
//  tumblr
//
//  Created by Sandesh Basnet on 9/4/18.
//  Copyright © 2018 Sandesh Basnet. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosDetailViewController: UIViewController {
    

    @IBOutlet weak var photoDetail: UIImageView!
    
    var imageUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let url = URL(string: imageUrl)
        self.photoDetail.af_setImage(withURL:url!)
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
