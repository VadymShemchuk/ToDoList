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
    let conteinerView = UIView()
    
    let titleLBL: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .clear
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 20)
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
        lbl.textColor = .systemGray
        return lbl
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(title: String?, description: String?, date: Date?){
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setConteinerView()
        lblconstrains()
    }
    func setConteinerView(){
        contentView.addSubview(conteinerView)
        conteinerView.addSubview(titleLBL)
        conteinerView.addSubview(descrLBL)
        conteinerView.addSubview(dateLBL)
        conteinerView.backgroundColor = .white
        conteinerView.layer.cornerRadius = 8
        conteinerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
    }
    
    func lblconstrains(){
        titleLBL.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.left.equalToSuperview().inset(8)
            $0.right.equalToSuperview().inset(8)
        }
        descrLBL.snp.makeConstraints {
            $0.top.equalTo(titleLBL.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(8)
            $0.right.equalToSuperview().inset(8)
            
        }
        
        dateLBL.snp.makeConstraints {
            $0.top.equalTo(descrLBL.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(8)
            $0.right.bottom.equalToSuperview().inset(8)
        }
    }
}
