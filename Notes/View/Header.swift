//
//  Header.swift
//  Notes
//
//  Created by Арман on 3/7/20.
//  Copyright © 2020 Арман. All rights reserved.
//

import UIKit

class Header: UICollectionViewCell {
    
     let text: UITextView = {
        let t = UITextView()
        t.text = "Notes"
        t.textColor = UIColor.white
        t.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.font = Theme.fonts.normalTitle
        t.isScrollEnabled = false
        t.isEditable = false
        t.isSelectable = false
        return t
        }()
    
    let button: UIButton = {
        let button = BlueRoundButton()
        button.setTitle("Add", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red:0.00, green:0.55, blue:1.0, alpha: 1)
        button.layer.cornerRadius = 35 / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 3.0
//        button.layer.masksToBounds = false
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    func setupViews() {
        addSubview(text)
        addSubview(button)
        text.widthAnchor.constraint(equalToConstant: 150).isActive = true
        text.heightAnchor.constraint(equalToConstant: 50).isActive = true
        text.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        button.widthAnchor.constraint(equalToConstant: 115).isActive = true
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.topAnchor.constraint(equalTo: topAnchor, constant: 35).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  BlueRoundButton.swift
//  Dyal
//
//  Created by Арман on 10/13/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class BlueRoundButton: UIButton {

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

            self.transform = CGAffineTransform.identity

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)


    }
    
    
    var section: Int?
    
    
    override func awakeFromNib() {
//        self.showsTouchWhenHighlighted = false
        self.backgroundColor = UIColor(red:0.00, green:0.55, blue:1.0, alpha: 1)
        self.reversesTitleShadowWhenHighlighted = false
        self.setTitle(currentTitle, for: .normal)
        self.setTitle(currentTitle, for: .highlighted)
        self.titleLabel?.font = .systemFont(ofSize: 15)
        self.layer.cornerRadius = self.frame.height / 2
//        self.adjustsImageWhenHighlighted = true
//        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
//        self.layer.shadowOpacity = 0.1
//        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
        self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
//        self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .highlighted)
//        self.setTitleColor(.white, for: .selected)
    }

}

