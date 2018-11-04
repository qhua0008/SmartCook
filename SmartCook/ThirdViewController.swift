//
//  ThirdViewController.swift
//  SmartCook
//
//  Created by Aditi and Qianyi Huang on 03/11/18.
//  Copyright © 2018 Aditi and Qianyi Huang. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desitnationVC = segue.destination as! ThirdTableViewController
        desitnationVC.ingredient = searchTextField.text
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
