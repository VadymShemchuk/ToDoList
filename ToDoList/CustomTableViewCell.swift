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
        lbl.backgroundColor = .clear
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.layer.cornerRadius = 8
        return lbl
    }()
    
    let descrLBL: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .clear
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = .systemGray
        return lbl
    }()
    
    let dateLBL: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .clear
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        backgroundColor = .clear
        contentView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalToSuperview()
        }
        lblconstrains()
    }
    
    func lblconstrains(){
        contentView.addSubview(titleLBL)
        titleLBL.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview()
        }
        contentView.addSubview(descrLBL)
        descrLBL.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview()
            $0.top.equalTo(titleLBL.snp.bottom)
        }
        contentView.addSubview(dateLBL)
        dateLBL.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview()
            $0.top.equalTo(descrLBL.snp.bottom)
            $0.bottom.equalToSuperview()
    }
}
}
