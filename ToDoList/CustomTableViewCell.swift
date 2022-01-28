//
//  CustomTableViewCell.swift
//  ToDoList
//
//  Created by Vadym Shemchuk on 27.01.2022.
//

import UIKit
//import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    //static let identifier = "CustomTableViewCell"
    private var lblText: String = ""
    
    let descrLBL: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textAlignment = .right
        return lbl
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        contentView.addSubview(descrLBL)
        frameLbl()
        
    }
    
    func frameLbl(){
        descrLBL.text = lblText
        NSLayoutConstraint.activate([descrLBL.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
                                     descrLBL.centerXAnchor.constraint(equalTo: centerXAnchor)])

    }
}
