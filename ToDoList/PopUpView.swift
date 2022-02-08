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
    
    init(returnedPopUpText: ((_:String?) -> ())?) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .formSheet
        let returnedText = popUpWindowView.popuptextView.text
        returnedPopUpText?(returnedText)
        popUpWindowView.popupButton.setTitle("Add a ticket", for: .normal)
        popUpWindowView.popupButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        view = popUpWindowView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }

}

private class PopUpWindowView: UIView {
    let popupView = UIView()
    let popupButton = UIButton()
    let popuptextView = UITextField()
        

    let BorderWidth: CGFloat = 2.0
    
    init() {
        super.init(frame: CGRect.zero)
        
        // Semi-transparent background
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addSubview(popupView)
        popupView.addSubview(popupButton)
        
        // Popup Background
        
        
        popupView.backgroundColor = UIColor.red
        popupView.layer.borderWidth = BorderWidth
        popupView.layer.masksToBounds = true
        popupView.layer.borderColor = UIColor.white.cgColor
//
        //Popup TextView
        
        popuptextView.placeholder = "Print title"
        popuptextView.textAlignment = NSTextAlignment.justified
        popuptextView.textColor = .black
        popuptextView.backgroundColor = .lightGray
        popupView.addSubview(popuptextView)
        popuptextView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(30)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }

        // Popup Button
        popupButton.setTitleColor(UIColor.white, for: .normal)
        popupButton.titleLabel?.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
        popupButton.backgroundColor = UIColor.purple

        // Add the popupView(box) in the PopUpWindowView (semi-transparent background)


        // PopupView constraints
        popupView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(440)
        }
        
        // PopupButton constraints
        popupButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupButton.heightAnchor.constraint(equalToConstant: 44),
            popupButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: BorderWidth),
            popupButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -BorderWidth),
            popupButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -BorderWidth)
            ])

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
