//
//  Note.swift
//  Notes
//
//  Created by Арман on 3/7/20.
//  Copyright © 2020 Арман. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    var data = String()
    var title: UITextView = {
        let t = UITextView()
        t.text = "Note"
        t.textColor = UIColor.black
        t.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        t.textAlignment = .center
        t.translatesAutoresizingMaskIntoConstraints = false
        t.font = UIFont.boldSystemFont(ofSize: 16)
        t.isScrollEnabled = false
        t.isEditable = false
        t.isSelectable = false
        t.isUserInteractionEnabled = false
        return t
    }()
    
    var coloredTag: coloredDot = {
        let tag = coloredDot()
        tag.isUserInteractionEnabled = false
        tag.translatesAutoresizingMaskIntoConstraints = false
        tag.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return tag
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        contentView.addSubview(title)
        contentView.addSubview(coloredTag)
        title.widthAnchor.constraint(equalToConstant: 150).isActive = true
        title.heightAnchor.constraint(equalToConstant: 35).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        coloredTag.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13).isActive = true
        coloredTag.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13).isActive = true
        coloredTag.widthAnchor.constraint(equalToConstant: 6.5).isActive = true
        coloredTag.heightAnchor.constraint(equalToConstant: 6.5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
