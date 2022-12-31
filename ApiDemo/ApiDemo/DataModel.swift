//
//  DataModel.swift
//  ApiDemo
//
//  Created by Sarika scc on 08/06/22.
//

import Foundation

struct RData: Codable {
    
    var location : Location
    var current : Current
}


struct Condition : Codable {
    
  var text : String
  var code : Int
}

struct Location : Codable {
    
    let name: String
    let country: String
    let region :String
    let lat: Double
    let lon: Double
}

struct Current : Codable{
    
    var temp_c : Double
    var condition : Condition
}

struct LocationDetail{
    
    var name : String
    var country : String
    var temp : Double
    var region : String
    
    init(){
        
        name = ""
        country = ""
        temp = 0
        region = ""
    }
}

