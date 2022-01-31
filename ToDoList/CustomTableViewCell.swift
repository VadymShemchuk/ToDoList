//
//  CustomTableViewCell.swift
//  ToDoList
//
//  Created by Vadym Shemchuk on 27.01.2022.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    var lblText: String = ""
    var heightConstrain: NSLayoutConstraint!
    
    let titleLBL: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    let descrLBL: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        lblconstrains()
    }
    
    func lblconstrains(){
        contentView.addSubview(titleLBL)
        titleLBL.snp.makeConstraints {
            $0.centerX.equalTo(UITableViewCell() as ConstraintRelatableTarget)
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(15)
            $0.right.equalToSuperview()
        }
        contentView.addSubview(descrLBL)
        descrLBL.snp.makeConstraints {
            $0.centerX.equalTo(UITableViewCell() as ConstraintRelatableTarget)
            $0.left.equalToSuperview().inset(15)
            $0.right.equalToSuperview()
            $0.top.equalTo(titleLBL.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
}
