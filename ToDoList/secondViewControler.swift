//
//  secondViewControler.swift
//  ToDoList
//
//  Created by Vadym Shemchuk on 13.01.2022.
//

import UIKit
import SnapKit

class secondViewController: UIViewController {
    
    //MARK: - Properties
    
    let editButton = UIButton()
    var titleText: String = ""
    var descriptionText: String = ""
    var titleField = UITextField()
    var descriptionField = UITextField()
    var returnedText: ((_:Ticket) -> ())?
    var receptionData: Ticket?
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    @objc func editText(){
        saveTicket()
        returnedText?(receptionData!)
        navigationController?.popViewController(animated: true)
    }
    
    func saveTicket(){
        let titleText = titleField.text
        let descriptionText = descriptionField.text
        let ticket = Ticket.init(title: titleText, description: descriptionText)
        receptionData = ticket
    }
    
    func recepientData(){
        titleField.text = receptionData?.title
        view.addSubview(titleField)
        titleField.backgroundColor = .lightGray
        titleField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.size.equalTo(150)
        }
        descriptionField.text = receptionData?.description
        view.addSubview(descriptionField)
        descriptionField.backgroundColor = .lightGray
        descriptionField.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(180)
            $0.right.equalToSuperview().offset(-20)
            $0.size.equalTo(150)
        }
    }
    
    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        recepientData()
        setupEditButton()
    }
}

private extension secondViewController {
    
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
}
