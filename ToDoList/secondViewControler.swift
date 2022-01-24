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
    var text: String = ""
    var textField = UITextField()
    var returnedText: ((_:String) -> ())?

    @objc func editText(){
        returnedText?(textField.text ?? "")
        navigationController?.popViewController(animated: true)
    }

    func recepientData(){
        textField.text = text
        view.addSubview(textField)
        textField.backgroundColor = .yellow
        textField.snp.makeConstraints {
            $0.center.equalToSuperview()
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
