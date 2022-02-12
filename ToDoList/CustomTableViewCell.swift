//
//  CustomTableViewCell.swift
//  ToDoList
//
//  Created by Vadym Shemchuk on 27.01.2022.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    let conteinerView = UIView()
    
    // Labels for setting Ticket 

    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .clear
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 20)
        return lbl
    }()
        
    let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .clear
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = .systemGray
        return lbl
    }()
    
    let dateLabel: UILabel = {
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
        labelConstrains()
    }
    
    // Conteiner View for Labels
    func setConteinerView(){
        contentView.addSubview(conteinerView)
        conteinerView.addSubview(titleLabel)
        conteinerView.addSubview(descriptionLabel)
        conteinerView.addSubview(dateLabel)
        conteinerView.backgroundColor = .white
        conteinerView.layer.cornerRadius = 8
        conteinerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
    
    // Label's constraints
    func labelConstrains(){
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.left.equalToSuperview().inset(8)
            $0.right.equalToSuperview().inset(8)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(8)
            $0.right.equalToSuperview().inset(8)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(8)
            $0.right.bottom.equalToSuperview().inset(8)
        }
    }
    
}
