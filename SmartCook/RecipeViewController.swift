//
//  RecipeViewController.swift
//  SmartCook
//
//  Created by Aditi and Qianyi Huang on 03/11/18.
//  Copyright © 2018 Aditi and Qianyi Huang. All rights reserved.
//

import UIKit
import WebKit

class RecipeViewController: UIViewController, ViewRecipeDelegate, UIWebViewDelegate {

    var recipeURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(webView)
        let url = URL(string: recipeURL!)
        webView.load(URLRequest(url: url!))
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewRecipe(url: String) {
        self.recipeURL = url
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
