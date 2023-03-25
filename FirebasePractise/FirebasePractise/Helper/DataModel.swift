
import Foundation
import UIKit
import FirebaseFirestore


struct User
{
    var key: String
    var name: String
    var email: String
    
    
    init() {

        self.email = ""
        self.key = ""
        self.name = ""
        
    }
}

struct Fruits {
    
    var key : String
    var name : String
    var created_by : String
    var created_date : Date!
    
    init(){
        
        name = ""
        key = ""
        created_date = nil
        created_by = ""
    }
}

struct Detail{
    
   var name : String
    var age : String
    var gender : String
    var key : String
    var time : Date
    var url : String
//    var marks = [Double]()
    var marks = [String : Any]()
    
    init(){
        name = ""
        age = ""
        gender = ""
        key = ""
        time = Date()
        url = ""
//      marks = []
        marks = [:]
    }
}
struct Job
{
    
    var key: String
    var title: String
    var location: String
    var job_type: String
    var salary: String
    var active_status :Bool
    var details : String
    var category :String
    var startdate : String
    var endDate : String
    var startTime : String
    var endTime : String
    var candidate_count : Int
    var company_id :String
    var candidates:[String]
    var company_name :String

    init() {

        self.title = ""
        self.key = ""
        self.location = ""
        self.job_type = ""
        self.salary = ""
        self.details = ""
        self.active_status = false
        self.category = ""
        self.startdate = ""
        self.endDate = ""
        self.startTime = ""
        self.endTime = ""
        self.candidate_count = 0
        self.company_id = ""
        self.candidates = []
        self.company_name = ""
    }
}

//struct FAQ {
//
//    var key : String
//    var que :String
//    var ans :String
//
//    init(){
//
//        self.key = ""
//        self.que = ""
//        self.ans = ""
//    }
//}

struct SRQ {
    
    var key : String
    var que :String
    var ans :String
    
    //screening
    var model_ans: String
    var score:Int
    
    //FAQ
    var keyword :String
    
    init(){
        
        self.key = ""
        self.que = ""
        self.ans = ""
        
        //screening
        self.model_ans = ""
        self.score = 0
        
        
        //FAQ
        self.keyword = ""
    }
}



struct CandidateJob {
    
    var key : String
    var status :Int
    var job_id : String
    
    init(){
        
        self.key = ""
        self.status = 0
        self.job_id = ""
    }
}

struct Messages {
    
    var message: String
    var sender_recevier_id : String
    var key :String
    var timestamp : Int
    var model_answer:String
  
    
    init(){
        
        self.message = ""
        self.sender_recevier_id = ""
        self.key = ""
        self.timestamp = 0
        self.model_answer = ""
       
    }
}




