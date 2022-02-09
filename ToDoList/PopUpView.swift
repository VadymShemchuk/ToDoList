//
//  PopUpView.swift
//  ToDoList
//
//  Created by Vadym Shemchuk on 07.02.2022.
//

import UIKit
import SnapKit

class PopUpWindow: UIViewController {
    
    private let popUpWindowView = PopUpWindowView()
    var returnedPopUpText: ((_:String?) -> ())?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        popUpWindowView.popupButton.setTitle("Add new task", for: .normal)
        popUpWindowView.popupButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        view = popUpWindowView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func dismissView(){
        let returnedText = popUpWindowView.popuptextView.text
        returnedPopUpText?(returnedText)
        self.dismiss(animated: true, completion: nil)
    }

}

private class PopUpWindowView: UIView {
    let popupView = UIView()
    let popupButton = UIButton()
    let popuptextView = TextField()
        

    let BorderWidth: CGFloat = 2.0
    
    init() {
        super.init(frame: CGRect.zero)
        
        // Semi-transparent background
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addSubview(popupView)
        popupView.addSubview(popupButton)
        
        // Popup Background
        
        
        popupView.backgroundColor = UIColor.systemGray3
        popupView.layer.borderWidth = BorderWidth
        popupView.layer.cornerRadius = 8
        popupView.layer.masksToBounds = true
        popupView.layer.borderColor = UIColor.white.cgColor
//
        //Popup TextView
        
        popuptextView.placeholder = "Print task name"
        popuptextView.textAlignment = NSTextAlignment.justified
        popuptextView.textColor = .black
        popuptextView.backgroundColor = .systemGray5
        popuptextView.layer.cornerRadius = 8
        popupView.addSubview(popuptextView)
        popuptextView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(44)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }

        // Popup Button
        popupButton.setTitleColor(UIColor.white, for: .normal)
        popupButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        popupButton.backgroundColor = UIColor.systemBlue

        // Add the popupView(box) in the PopUpWindowView (semi-transparent background)


        // PopupView constraints
        popupView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(293)
            $0.height.equalTo(176)
        }
        
        // PopupButton constraints
        
        popupButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(44)
        }

    }
    
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
