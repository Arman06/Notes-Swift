//
//  DetailNoteViewController.swift
//  Notes
//
//  Created by Арман on 3/7/20.
//  Copyright © 2020 Арман. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: NSObjectProtocol {
    func removeFromCollection(data: Note, at indexPath: IndexPath)
    func reloadCollection(at indexPath: IndexPath)
}


class DetailNoteViewController: UIViewController {
    
    var data: Note?
    
    var indexPath: IndexPath?
    
    weak var delegate : DetailViewControllerDelegate?
    
    let titleText: UITextView = {
        let t = UITextView()
        t.text = "Notes"
        t.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        t.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.font = Theme.fonts.normalTitle
        t.isScrollEnabled = false
        return t
    }()
    
    let text: UITextView = {
        let t = UITextView()
        t.text = "Notes"
        t.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        t.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.font = Theme.fonts.normalBody
        return t
    }()
    
    
    var dot: coloredDot = {
        var dot = coloredDot()
        dot.translatesAutoresizingMaskIntoConstraints = false
        return dot
    }()
    
    
    var stackView: UIStackView = {
       var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fillEqually
//        stack.spacing = 30
        return stack
    } ()
    
    let deleteButton: UIButton = {
        let button = BlueRoundButton()
        button.setTitle("Delete", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red:0.00, green:0.55, blue:1.0, alpha: 1)
        button.layer.cornerRadius = 35 / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0.3099266291, alpha: 1)
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 3.0
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        return button
    }()
    
    @objc func deleteButtonTapped(_ sender: UIButton){
        delegate?.removeFromCollection(data: data!, at: indexPath!)
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        titleText.text = data?.title
        titleText.delegate = self
        text.sizeToFit()
        text.delegate = self
        text.text = data?.text
        if data?.colorTag == .red {
            dot.colorFill = UIColor.red
        }
        if data?.colorTag == .green {
            dot.colorFill = UIColor.green
        }
        if data?.colorTag == .blue {
            dot.colorFill = UIColor.blue
        }
        if data?.colorTag == .purple {
            dot.colorFill = UIColor.purple
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        setupViews()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupViews() {
//        stackView.addArrangedSubview(titleText)
//        stackView.addArrangedSubview(dot)
//        view.addSubview(stackView)
        view.addSubview(deleteButton)
        deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        deleteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        view.addSubview(titleText)
        view.addSubview(text)
//        view.addSubview(dot)
//        stackView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        titleText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleText.widthAnchor.constraint(equalToConstant: 150).isActive = true
        titleText.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
//        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        dot.widthAnchor.constraint(equalToConstant: 10).isActive = true
//        dot.heightAnchor.constraint(equalToConstant: 10).isActive = true
//        dot.leadingAnchor.constraint(equalTo: titleText.trailingAnchor, constant: 5).isActive = true
//        dot.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        
        text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        text.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        text.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 15).isActive = true
        text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
    }
}

extension DetailNoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
//        textView.sizeToFit()
//        DataService.instance.updateNote(at: indexPath!, to: titleText.text, with: text.text)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        DataService.instance.updateNote(at: indexPath!, to: titleText.text, with: text.text)
        delegate?.reloadCollection(at: indexPath!)
    }
}
