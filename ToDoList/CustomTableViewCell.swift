//
//  CustomTableViewCell.swift
//  ToDoList
//
//  Created by Vadym Shemchuk on 27.01.2022.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    //static let identifier = "CustomTableViewCell"
    private var lblText: String = ""
    
    let titleLBL: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textAlignment = .left
        lbl.backgroundColor = .lightGray
        return lbl
    }()
    
    let descrLBL: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textAlignment = .left
        lbl.backgroundColor = .clear
        return lbl
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        contentView.addSubview(descrLBL)
        contentView.addSubview(titleLBL)
        lblconstrains()
        
    }
    
    func lblconstrains(){
        //descrLBL.text = lblText
        titleLBL.snp.makeConstraints {
            $0.centerX.equalTo(UITableViewCell() as ConstraintRelatableTarget)
            $0.left.right.equalTo(contentView)
            $0.size.equalTo(22)
        }
        
        descrLBL.snp.makeConstraints {
            $0.centerX.equalTo(UITableViewCell() as ConstraintRelatableTarget)
            $0.left.right.equalTo(contentView)
            $0.top.equalTo(titleLBL.snp.bottom)
            $0.size.equalTo(22)
        }
        
//        NSLayoutConstraint.activate([descrLBL.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
//                                     descrLBL.centerXAnchor.constraint(equalTo: centerXAnchor)])
//        NSLayoutConstraint.activate([titleLBL.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
//                                     titleLBL.centerXAnchor.constraint(equalTo: centerXAnchor)])

    }
}
