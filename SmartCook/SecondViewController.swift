//
//  SecondViewController.swift
//  SmartCook
//
//  Created by Aditi on 31/10/18.
//  Copyright © 2018 Aditi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import UserNotifications

class SecondViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humdityLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var smallView: UIView!
    
    var temp: Double?
    var humdity: Double?
    
     var databaseRef = Database.database().reference().child("tah")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        smallView.layer.cornerRadius = 10
        //retrieve data from database
        databaseRef.observe(.value, with: { (snapshot) in
            if(snapshot.exists()) {
                let array: NSArray = snapshot.children.allObjects as NSArray
                
                
                for obj in array {
                    let snapshot: DataSnapshot = obj as! DataSnapshot
                    if let childSnapshot = snapshot.value as? [String : AnyObject]
                    {
                        if let t = childSnapshot["temperature"] {
                            self.temp = t as? Double
                        }
                        if let r = childSnapshot["humidity"] {
                            self.humdity = r as? Double
                        }
                    }
                }
                
                if (self.temp != nil) {
                    let temp = Double(round(Double(self.temp!)*100)/100)
                    self.temperatureLabel.text = String(temp) + "°C"
                    if (temp >= 40)
                    {
                        self.temperatureLabel.textColor = UIColor.red
                        //let burntFood = UIImage(named: "burntFood")
                        self.foodImageView = UIImageView(image: #imageLiteral(resourceName: "burntFood"))
                        self.notification(option: 1)
                    }
                    else
                    {
                        self.temperatureLabel.textColor = UIColor.green
                        //let food = UIImage(named: "food")
                        self.foodImageView = UIImageView(image: #imageLiteral(resourceName: "food"))
                    }
                }
                if (self.humdity != nil) {
                    let humdity = Double(round(Double(self.humdity!)*100)/100)
                    self.humdityLabel.text = String(humdity) + "g/m3"
                    if (humdity >= 40)
                    {
                        self.humdityLabel.textColor = UIColor.red
                        //let boilingWater = UIImage(named: "boilingWater")
                        self.foodImageView = UIImageView(image: #imageLiteral(resourceName: "boilingWater"))
                        self.notification(option: 2)
                    }
                    else
                    {
                        self.humdityLabel.textColor = UIColor.green
                    }
                }
            }
        })
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { didAllow, error in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func notification(option: Int) {
        if (option == 1)
        {
            let alert = UIAlertController(title: "Burnt!!!", message: "Your food is about to burn.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            let content = UNMutableNotificationContent()
            content.title = "Burnt!!!"
            content.subtitle = "Your food is about to burn."
            content.badge = 1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
            let request = UNNotificationRequest(identifier: "timeDone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Boiling!!!", message: "Something on your cooktop is about to boil.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            let content = UNMutableNotificationContent()
            content.title = "Boiling!!!"
            content.subtitle = "Something on your cooktop is about to boil."
            content.badge = 1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
            let request = UNNotificationRequest(identifier: "timeDone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
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
