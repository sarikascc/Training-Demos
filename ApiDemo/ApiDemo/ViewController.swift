//
//  ViewController.swift
//  ApiDemo
//
//  Created by Rutika Scc on 04/04/22.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrDetail = [LocationDetail]()
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        
//        getDataAlamofire()
        //        callAPIThorughURLSessionWithJSONObject()
                callAPIThroughURLSession()
        
    }
    
    //MARK: tableview delegate method
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        arrDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "TableViewCell")as!TableViewCell
        cell.lblName.text = arrDetail[indexPath.row].name
        cell.lblCountry.text = arrDetail[indexPath.row].country
        cell.lblRegion.text = "\(arrDetail[indexPath.row].temp)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    //MARK: call API with URLSession
    
    // Decodable
    func callAPIThroughURLSession() {
        
        let urlString = "https://api.weatherapi.com/v1/current.json?key=14c6dc262aef4815b5785118220404&q=india&aqi=no"
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url) {data, res, err in
                
                guard let data = data else {return print("error with data")}
                
                let decoder = JSONDecoder()
                guard let json: RData = try? decoder.decode(RData.self, from: data) else {return print("error with json")}
                
                print("json:",json)
                var d1 = LocationDetail()
                d1.name = json.location.name
                d1.country = json.location.country
                d1.region = json.location.region
                d1.temp = json.current.temp_c
                
                self.arrDetail.append(d1)
                DispatchQueue.main.async {
                    
                    self.table.reloadData()
                }
                
                print(self.arrDetail)
                
            }.resume()
        }
    }
    
    // JSON Object
    func callAPIThorughURLSessionWithJSONObject() {
        
        let urlString = "https://api.weatherapi.com/v1/current.json?key=14c6dc262aef4815b5785118220404&q=india&aqi=no"
        
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url) {data, res, err in
                
                print("data:\(data)")
                
                guard let data = data else {return print("error with data")}
                
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [String: AnyObject]
                    
                    print("parsedData:\(parsedData)")
                    
                    guard let results = parsedData["location"] as? [String:AnyObject] else { return }
                    guard let currentVal = parsedData["current"] as? [String:AnyObject] else { return }
                    
                    var d1 = LocationDetail()
                    d1.name = results["name"]as!String
                    d1.country = results["country"] as! String
                    d1.region = results["region"] as? String ?? ""
                    d1.temp = currentVal["temp_c"] as? Double ?? 0.0
                    
                    self.arrDetail.append(d1)
                    
                    DispatchQueue.main.async {
                        
                        self.table.reloadData()
                    }
                    
                    print(self.arrDetail)
                    
                }
                catch let err{
                    
                    debugPrint(err.localizedDescription)
                }
                
            }.resume()
        }
    }
    
    //MARK: call API with Alamofire library
    
    func getDataAlamofire(){
        
        AF.request("https://api.weatherapi.com/v1/current.json?key=14c6dc262aef4815b5785118220404&q=india&aqi=no", method: .get, encoding: JSONEncoding.default)
            .validate()
            .responseData { response in
                
                switch response.result {
                case .success:
                    
                    print("Responce success 1")
                    do {
                        
                        let json = try JSON(data: response.value!)
                        print("Alamofire Data:",json)
                        
                        let location = json["location"]
                        let current = json["current"]
                        
                        var d1 = LocationDetail()
                        d1.name = location["name"].stringValue
                        d1.country = location["country"].stringValue
                        d1.region = location["region"].stringValue
                        d1.temp = current["temp_c"].doubleValue
                        
                        self.arrDetail.append(d1)
                        DispatchQueue.main.async {
                            
                            self.table.reloadData()
                        }
                    }
                    catch
                    {
                        print("data error: ",error.localizedDescription)
                    }
                    
                case .failure(let error):
                    
                    print("Error:: \(error)")
                }
            }
    }
    
}

