//
//  AddViewController.swift
//  Notes
//
//  Created by Арман on 3/8/20.
//  Copyright © 2020 Арман. All rights reserved.
//

import UIKit

protocol AddViewControllerDelegate: NSObjectProtocol {
    func addToCollection(data: Note)
}


class AddViewController: UIViewController {
    
    
    var note: Note?
    
    weak var delegate : AddViewControllerDelegate?
    
    var titleField: PrettyTextField = {
        var field = PrettyTextField()
//        field.placeholder = "Title"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = #colorLiteral(red: 0.8613020778, green: 0.8614470363, blue: 0.8612830043, alpha: 1)
        field.layer.cornerRadius = 15/2
        field.textColor = UIColor.black
        field.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        return field
    }()
    
    
    
    var detailTextViewField: UITextView = {
        let t = UITextView()
        t.text = ""
        t.isEditable = true
        t.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        t.backgroundColor = #colorLiteral(red: 0.8613020778, green: 0.8614470363, blue: 0.8612830043, alpha: 1)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.font = UIFont.boldSystemFont(ofSize: 20)
        t.layer.cornerRadius = 10
        t.layer.masksToBounds = true
        return t
    }()
    
    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    var stackView: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 30
        return stack
    }()
    
    let addButton: UIButton = {
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
    
    let backButton: UIButton = {
        let button = BlueRoundButton()
        button.setTitle("Return", for: .normal)
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
    
    func makeDot(with color: UIColor) -> coloredDot {
        let dot = coloredDot()
        dot.translatesAutoresizingMaskIntoConstraints = false
        dot.colorFill = color
        dot.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return dot
    }
    
    func addTargets(){
        let colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.purple]
        for color in colors {
            let dot = makeDot(with: color)
            dot.addTarget(self, action: #selector(dotPressed(sender:)), for: .touchUpInside)
            stackView.addArrangedSubview(dot)
        }
        backButton.addTarget(self, action: #selector(endAdd), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(endAdd), for: .touchUpInside)
        datePicker.addTarget(self, action: #selector(datePicked(sender:)), for: .valueChanged)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func addSubviews(){
        view.addSubview(stackView)
        view.addSubview(titleField)
        view.addSubview(datePicker)
        view.addSubview(detailTextViewField)
        view.addSubview(addButton)
        view.addSubview(backButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        note = Note(title: nil, text: nil, date: DataService.instance.currentDate, colorTag: .blue)
        titleField.delegate = self
        detailTextViewField.delegate = self
        addTargets()
        addSubviews()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setupViews()
    }
    
    @objc func datePicked(sender: UIDatePicker) {
        note?.date = sender.date
    }
    
    @objc func dotPressed(sender: coloredDot) {
        switch sender.colorFill {
        case UIColor.red:
            note?.colorTag = .red
        case UIColor.purple:
            note?.colorTag = .purple
        case UIColor.blue:
            note?.colorTag = .blue
        case UIColor.green:
            note?.colorTag = .green
        default:
            note?.colorTag = .none
        }
        for dot in stackView.arrangedSubviews {
            if let dott = dot as? coloredDot {
                if dott == sender {
                    dott.colorStroke = UIColor.gray
                } else {
                    dott.colorStroke = UIColor.clear
                }
            }
        }
    }
        
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func endAdd(_ sender: UIButton) {
        if let delegate = delegate {
                if sender == addButton {
                    note?.title = titleField.text
                    note?.text = detailTextViewField.text
                    note?.date = datePicker.date
                delegate.addToCollection(data: note!)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        backButton.bottomAnchor.constraint(equalTo: titleField.topAnchor, constant: -30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 115).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        titleField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        detailTextViewField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        detailTextViewField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        detailTextViewField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 30).isActive = true
        detailTextViewField.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        datePicker.heightAnchor.constraint(equalToConstant: 60).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        datePicker.topAnchor.constraint(equalTo: detailTextViewField.bottomAnchor).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        stackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 30).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 115).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
}

extension AddViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        if textField == titleField {
          note?.title = textField.text
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == titleField {
          note?.title = textField.text
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == titleField {
          note?.title = textField.text
        }
    }
}

extension AddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
    }
    
    func textViewDidChange(_ textView: UITextView) {
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == detailTextViewField {
          note?.text = detailTextViewField.text
        }
    }
}
