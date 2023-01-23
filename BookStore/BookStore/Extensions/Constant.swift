//
//  Constant.swift
//  BookStore
//
//  Created by Sarika on 22/03/22.
//

import Foundation
import UIKit

let appThemeColor = UIColor(named: "appThemeColor")// 3A6541

extension UIView {
    
    
    var cornerRadius : CGFloat {
        
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    func hideV(){
        
        self.isHidden = true
    }
    
    func showV(){
        
        self.isHidden = false
    }
    
    func setBorder(_ BW:CGFloat,color:UIColor,CR:CGFloat) {
        
        self.layer.cornerRadius = CR
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = BW
        self.clipsToBounds = true
    }
    
    func setShadoCell() {
        
        let layer = self.layer
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        layer.shadowOpacity = 0.35
        layer.shadowRadius = 2
        layer.masksToBounds = false
    }
}

func showAlertWithMsg(msg:String,cc:UIViewController) {
    
    let alertVc = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
    alertVc.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    cc.present(alertVc, animated: true, completion: nil)
}

func validationTextField(txt:UITextField,msg:String,cc:UIViewController) -> Bool {
    
    if txt.text == "" {
        
        showAlertWithMsg(msg: msg, cc: cc)
        return false
    }
    else
    {
        return true
    }
    
}
