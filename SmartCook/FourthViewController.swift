//
//  FourthViewController.swift
//  SmartCook
//
//  Created by Aditi and Qianyi Huang on 01/11/18.
//  Copyright © 2018 Aditi and Qianyi Huang. All rights reserved.
//

import UIKit
import Firebase

class FourthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteAccountButton(_ sender: Any) {
        let user = Auth.auth().currentUser
        user?.delete { error in
            if error != nil {
                print(error!)
            } else {
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }
        }
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
