//
//  FirstViewController.swift
//  SmartCook
//
//  Created by Aditi and Qianyi Huang on 31/10/18.
//  Copyright © 2018 Aditi and Qianyi Huang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
class FirstViewController: UIViewController {
    
    @IBOutlet weak var liveImage: UIImageView!
    var storageRef = Storage.storage().reference(withPath: "/imgs/test.jpg")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        liveImage.layer.borderWidth = 10
        let blue = UIColor(red: 0.2, green: 0.7, blue: 0.9, alpha: 1)
        liveImage.layer.borderColor = blue.cgColor
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updateImage), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        
    }
    
    @objc func updateImage(){
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                // Uh-oh, an error occurred!
                print("error occurs")
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                
                self.liveImage.image = image
            }
        }
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
