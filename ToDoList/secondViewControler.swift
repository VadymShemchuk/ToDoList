//
//  secondViewControler.swift
//  ToDoList
//
//  Created by Vadym Shemchuk on 13.01.2022.
//

import UIKit
import SnapKit
import UserNotifications

class secondViewController: UIViewController {
    
    
    
    //MARK: - Properties
    
    var titleField = TextField()
    var descriptionField = UITextView()
    var dateField = TextField()
    var returnedText: ((_:Ticket) -> ())?
    var receptionData: Ticket?
    private var userTicketDate: Date? = nil
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    
    
    
    
    
    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.systemGray5
        recepientData()
        setupSaveButtonTollBar()
        setupDatePicker()
        textLabelsConstrains()
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
    
    
    func setupSaveButtonTollBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTicket))
    }
    
    @objc func saveTicket(){
        let titleText = titleField.text
        let descriptionText = descriptionField.text
        let date = userTicketDate
        let ticket = Ticket.init(title: titleText, description: descriptionText, date: date)
        receptionData = ticket
        returnedText?(receptionData!)
        navigationController?.popViewController(animated: true)
        
    }
    
    func recepientData(){
        titleField.text = receptionData?.title
        descriptionField.text = receptionData?.description
        dateField.text = receptionData?.date?.formatted(date: .abbreviated, time: .shortened)
    }
    
    //MARK: - text views design
    
    func textLabelsConstrains(){
        view.addSubview(titleField)
        //titleField.placeholder = "Print a title"
        titleField.backgroundColor = .white
        titleField.font = UIFont.boldSystemFont(ofSize: 20)
        titleField.layer.cornerRadius = 8
        
        titleField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(44)
        }
        
        view.addSubview(descriptionField)
        descriptionField.backgroundColor = .white
        descriptionField.font = UIFont.systemFont(ofSize: 18)
        descriptionField.textColor = .systemGray
        descriptionField.layer.cornerRadius = 8
        descriptionField.snp.makeConstraints {
            $0.top.equalTo(titleField.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(88)
        }
        
        view.addSubview(dateField)
        dateField.backgroundColor = .white
        dateField.placeholder = "Add a date"
        dateField.font = UIFont.systemFont(ofSize: 18)
        dateField.textColor = .systemGray
        dateField.layer.cornerRadius = 8
        dateField.snp.makeConstraints {
            $0.top.equalTo(descriptionField.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(44)
        }
    }
    
    //MARK: - Date Picker
    
    func setupDatePicker(){
        dateField.inputView = datePicker
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
        dateField.inputAccessoryView = toolBar
    }
    
    @objc func doneAction() {
        dateField.text = datePicker.date.formatted(date: .abbreviated, time: .shortened)
        userTicketDate = datePicker.date
        view.endEditing(true)
    }
    
    @objc func cancelAction(){
        view.endEditing(true)
    }
    
    // MARK: - notification center
    
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
        formatter.dateFormat = "d MMM y HH:mm"
        return formatter.string(from: date)
    }
}

extension secondViewController {
    
    class TextField: UITextField{
        let padding = UIEdgeInsets (top: 0, left: 8, bottom: 0, right: 0)
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    }
}
