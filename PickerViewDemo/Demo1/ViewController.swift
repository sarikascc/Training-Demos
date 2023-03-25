//
//  ViewController.swift
//  Demo1
//
//  Created by Sarika scc on 31/05/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var txt_progressValue: UITextField!
    @IBOutlet weak var txt_date: UITextField!
    @IBOutlet weak var txt_pickerView: UITextField!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    @IBOutlet weak var segmrnt_control: UISegmentedControl!
    
    let fieldPickerview = UIPickerView()
    var arrmark = ["1","2","3","4","5","6","7","8","9","10"]
    var selectedRow = -1
    var oldselectedRow = -1
    
    
    let datePickerView = UIDatePicker()
    let dateFormater = DateFormatter()
    var selectedDate : Date!
    var oldSelectedDate : Date!
    
    var selectedTag = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fieldPickerview.delegate = self
        fieldPickerview.dataSource = self
        
        dateFormater.dateFormat = "dd-MM-yyyy hh:mm a"
        
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.datePickerMode = .dateAndTime
        datePickerView.addTarget(self, action: #selector(Click_onSelectDate), for: .valueChanged)
        
    }
    
    @objc func Click_onSelectDate(sender:UIDatePicker){
        
        selectedDate = sender.date
    }
    
    func addToolBar(textfiled:UITextField){
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.tag = textfiled.tag
        textfiled.inputAccessoryView = toolBar

    }
    
    @objc func doneClick() {
        
        switch selectedTag { // textfiled tag
            
        case 1: // pickerview textfiled
            
            txt_pickerView.text = selectedRow != -1 ? arrmark[selectedRow] : ""
            oldselectedRow = selectedRow
            txt_pickerView.resignFirstResponder()
            
        case 2:  // datepicker textfiled
            
            txt_date.text = dateFormater.string(from: selectedDate)
            oldSelectedDate = selectedDate
            txt_date.resignFirstResponder()
            
        default:
            break
        }
    }
    
    @objc func cancelClick() {
        
        switch selectedTag {  // textfiled tag
            
        case 1: // pickerview textfiled
            
            selectedRow = oldselectedRow
            txt_pickerView.resignFirstResponder()
            
        case 2:  // datepicker textfiled
            
            selectedDate = oldSelectedDate
            txt_date.resignFirstResponder()
            
        default:
            break
        }
    }
    
    //MARK: textfiled delegate method
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        selectedTag = textField.tag
        
        if textField.tag == 1{
            
          
            fieldPickerview.selectRow(selectedRow != -1 ? selectedRow : 0, inComponent: 0, animated: true)
            textField.inputView = fieldPickerview
            addToolBar(textfiled: textField)
            
        }
        else if textField.tag == 2{
            
            datePickerView.setDate(selectedDate != nil ? selectedDate : Date(), animated: true)
            textField.inputView = datePickerView
            addToolBar(textfiled: textField)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 3 {
            
            setProgressValue()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == 3 {
            
            if string == "" {
                
                return true
            }
            else if string == "." {
                
                return false
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
   
    //MARK: pickerview delegate method
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        arrmark.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return arrmark[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedRow = row
    }
    
   
    @IBAction func click_onSetProgressValue(_ sender: UIButton) {
        
        setProgressValue()
    }
    
    func setProgressValue(){  // set progress bar value
        
        let val = Int(txt_progressValue.text!) ?? 0
        let finalValue = Float(Double(val) / 100.0)
        print("FinalValue:",finalValue)
        progressView.setProgress(finalValue, animated: true)
    }
    
    @IBAction func click_onNextBtn(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ScrollVC")as! ScrollVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func click_onsegmentControll(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
        case 0:
            self.view.backgroundColor = .red
            
        case 1:
            self.view.backgroundColor = .green
        default:
            break
        }
        
    }
}

