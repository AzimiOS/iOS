//
//  ViewController.swift
//  api call
//
//  Created by Apple on 10/03/18.
//  Copyright © 2018 Azim. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var hoilday: UITableView!
    var holidayarr = NSArray()
    var detailArr = NSArray()
   

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      let dict = holidayarr.object(at: section) as! NSDictionary //holi arr is forceflly dictionary
        let holi = dict.value(forKey: "details") as! NSArray //object holi is assign details which is array
        return holi.count

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cool") as!
        TableViewCell
        let dict = holidayarr.object(at: indexPath.section) as! NSDictionary
        
        print("datdtrdrft\(holidayarr)")
        let detailArr = dict.value(forKey: "details") as! NSArray
        
        //make another dictionary object in order to go inside
        
        let dict1 = detailArr.object(at: indexPath.row) as! NSDictionary
        cell.dateDAy.text = dict1.value(forKey: "date") as? String
        
        //print
        cell.textLabel?.text = dict1.value(forKey: "title") as? String                      //(show here title)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.Day.text = dict1.value(forKey: "day") as? String
        
        let stringcolor = dict1.value(forKey: "color") as? String
        cell.backgroundColor = hexStringToUIColor(hex: stringcolor as! String) as! UIColor
        //first convert the hex to color then make its contants obj then call
        
        
        print("sucess")
        
        return cell
        
        }
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "headerTableViewCell") as! headerTableViewCell
        let dt = holidayarr.object(at: section) as! NSDictionary
        print("daaaaaaaaaaa\(dt)")
        
        let url = URL(string: dt.value(forKey: "image") as! String)
        header.headimg.kf.setImage(with: url)
        
        let di = holidayarr.object(at: section) as! NSDictionary
        header.textLabel?.textAlignment = .center
        header.textLabel?.textColor = Color.white
    header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        header.textLabel?.text =  di.value(forKey: "month") as! String
        //let detailArr = di.object(forKey: section) as! NSArray
        
        
        
        
        
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return holidayarr.count
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        let dict = holidayarr.object(at: section) as! NSDictionary
        return dict.value(forKey: "month") as? String
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

    override func viewDidLoad(){
        super.viewDidLoad()
        let url = URL(string: "http://mahindralylf.com/apiv1/getholidays")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, er) in
        
            if er != nil
            {
                print(er.debugDescription)
                //error
            }
            else
            {
                print("sucess",data!)//sucess
                do{
                let dict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary // dictionary
                  
                    
                    self.holidayarr = dict.value(forKey: "holidays")  as! NSArray
                    
                    
        
                    DispatchQueue.main.async { // reson behind y it was not displaying initially
                        self.hoilday.reloadData() //reload tableView
                    }
                    
                    
                    print("dict is",dict.value(forKey: "holidays")!)
                    //we want with data
                }catch{
                    print("exception")
                }
                }
                
            
        }
        task.resume()// Do any additional setup after loading the view, typically from a nib.
    }
    
    




}
