//
//  secondViewControler.swift
//  ToDoList
//
//  Created by Vadym Shemchuk on 13.01.2022.
//

import UIKit
import SnapKit

class secondViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    
    let editButton = UIButton()
    var titleText: String = ""
    var descriptionText: String = ""
    var titleField = UITextField()
    var descriptionField = UILabel()
    var returnedText: ((_:Ticket) -> ())?
    var receptionData: Ticket?
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    let datePicker = UIDatePicker()
    let notificationCenter = UNUserNotificationCenter.current()
    
    
    
    
    
    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        recepientData()
        setupEditButton()
        setupDatePicker()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) {
            (permissionGranted, error) in
            if(!permissionGranted)
            {
                print("Permission Granted")
            }
        }
    }
}

// MARK: - Private

private extension secondViewController {
    
    func saveTicket(){
        let titleText = titleField.text
        let descriptionText = descriptionField.text
        let ticket = Ticket.init(title: titleText, description: descriptionText)
        receptionData = ticket
    }
    
    func recepientData(){
        titleField.text = receptionData?.title
        view.addSubview(titleField)
        titleField.backgroundColor = .clear
        titleField.font = UIFont.boldSystemFont(ofSize: 16)
        
        titleField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(95)
            $0.left.equalToSuperview().inset(15)
            $0.right.equalToSuperview().offset(-15)
        }
        
        descriptionField.text = receptionData?.description
        view.addSubview(descriptionField)
        descriptionField.backgroundColor = .clear
        descriptionField.snp.makeConstraints {
            $0.top.equalTo(titleField.snp.bottom)
            $0.left.equalToSuperview().inset(15)
            $0.right.equalToSuperview().offset(-15)
        }
    }
    
    func setupDatePicker(){
        titleField.inputView = datePicker
        datePicker.datePickerMode = .dateAndTime
        datePicker.backgroundColor = .lightGray
        datePicker.preferredDatePickerStyle = .wheels
        let localID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localID!)
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        let flexSpase = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([cancelButton, flexSpase,doneButton], animated: true)
        titleField.inputAccessoryView = toolBar
        
        
    }
    
    @objc func doneAction(){
        let formater = DateFormatter()
        formater.dateFormat = "MMM d, h:mm a"
        titleField.text = titleField.text!+" "+formater.string(from: datePicker.date)
        notificationAction()
        view.endEditing(true)
    }
    @objc func cancelAction(){
        view.endEditing(true)
    }
    
    func setupEditButton(){
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.blue, for: .normal)
        editButton.layer.borderWidth = 1
        editButton.layer.cornerRadius = 20.0
        editButton.clipsToBounds = true
        editButton.backgroundColor = .orange
        editButton.addTarget(self, action: #selector(editText), for: .touchUpInside)
        view.addSubview(editButton)
        editButton.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.size.equalTo(44)
        }
        
    }
    
    @objc func editText(){
        saveTicket()
        returnedText?(receptionData!)
        navigationController?.popViewController(animated: true)
    }
    
    func notificationAction(){
        notificationCenter.getNotificationSettings { (settings) in
            
            DispatchQueue.main.async {
                let title = self.titleField.text!
                let message = self.descriptionField.text!
                let date = self.datePicker.date
                
                if (settings.authorizationStatus == .authorized) {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = message
                    
                    let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    self.notificationCenter.add(request) {(error) in if(error != nil)
                        {
                        print("Error" + error.debugDescription)
                        return
                    }
                    }
                    let ac = UIAlertController(title: "Task Added", message: "At" + self.formatedDate(date: date), preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in }))
                    self.present(ac, animated: true)
                }
                else
                {
                    let ac = UIAlertController(title: "Enable Notification", message: "Please turn On notifications in settings", preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: "Settings", style: .default) { (_) in
                        guard let settingsURL = URL(string: UIApplication.openSettingsURLString)
                        else
                        {
                            return
                        }
                        
                        if (UIApplication.shared.canOpenURL(settingsURL))
                        {
                            UIApplication.shared.open(settingsURL) { (_) in}
                        }
                    }
                    ac.addAction(goToSettings)
                    ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in }))
                    self.present(ac, animated: true)
                    
                }
            }
        }
    }
    
    func formatedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: date)
    }
}
