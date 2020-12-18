//
//  NotesViewController.swift
//  Notes
//
//  Created by Арман on 1/25/20.
//  Copyright © 2020 Арман. All rights reserved.
//

import UIKit





class NotesViewController: UIViewController, AddViewControllerDelegate, DetailViewControllerDelegate {
    func reloadCollection(at indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
    
    func removeFromCollection(data: Note, at indexPath: IndexPath) {
        DataService.instance.removeNote(at: indexPath)
        collectionView.deleteItems(at: [indexPath])
    }
    

    
    
    func addToCollection(data: Note) {
        DataService.instance.addNote(data)
        collectionView.reloadData()
    }
    
    
    
    
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.alwaysBounceVertical = true
        cv.register(Cell.self, forCellWithReuseIdentifier: "cell")
        cv.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    
    
    
    
    let text: UITextView = {
        let t = UITextView()
        t.text = "Notes"
//        t.textColor = Theme.color.normal
        t.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.font = Theme.fonts.normalTitle
        t.isUserInteractionEnabled = true
        return t
    }()
    
    let gradView: GradientView = {
        let gView = GradientView.init()
        gView.translatesAutoresizingMaskIntoConstraints = false
        
        gView.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        return gView
    }()
    
    let newColors = [UIColor(red: 255/255, green: 0, blue: 255/255, alpha: 1),
                     UIColor(red: 110/255, green: 0, blue: 170/255, alpha:1)].map { $0.cgColor }
    
    let newColors2 = [UIColor.purple, UIColor.orange].map { $0.cgColor }
    
    let newColors3 = [UIColor.orange, UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1)].map { $0.cgColor }
    
//    let newColors4 = [UIColor.red, UIColor.blue].map { $0.cgColor }
    
    var gradientArray = [[UIColor(red: 255/255, green: 0, blue: 255/255, alpha: 1),
    UIColor(red: 110/255, green: 0, blue: 170/255, alpha:1)].map { $0.cgColor }, [UIColor.purple, UIColor.orange].map { $0.cgColor }, [UIColor.orange, UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1)].map { $0.cgColor }]
    var currentGradient = 0
    
    
    let dummText = "Hello there this is my new app for making notes and reminders okey"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        print(DataService.instance.getNotes())
//        let initLayer = gradView.layer
//        gradView.layer.mask = text.layer.sublayers?.last
        
//        gradView.layer.mask =  UIView()
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print(family, names)
//        }
    }
    
    @objc func willEnterForeground() {
        gradView.gradient.colors = gradientArray[currentGradient]
        animateGradient()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupViews() {
        view.addSubview(gradView)
//        gradView.addSubview(text)
        gradView.addSubview(collectionView)
        
        gradView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gradView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        gradView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gradView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: gradView.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: gradView.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: gradView.trailingAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: gradView.bottomAnchor, constant: 0).isActive = true
        
        
//        text.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        text.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        text.topAnchor.constraint(equalTo: gradView.topAnchor, constant: 50).isActive = true
//        text.leadingAnchor.constraint(equalTo: gradView.leadingAnchor, constant: 25).isActive = true
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
    }
    func animateGradient() {
        if currentGradient < gradientArray.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.delegate = self
        gradientChangeAnimation.duration = 11.0
        gradientChangeAnimation.toValue = gradientArray[currentGradient]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradView.gradient.add(gradientChangeAnimation, forKey: "colorChange")
    }
    
    
    
    
    
}

extension NotesViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradView.gradient.colors = gradientArray[currentGradient]
            animateGradient()
        }
    }
}






extension NotesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.2, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.instance.getNotes(for: section).count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return DataService.instance.getDates().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        let note = DataService.instance.getNotes(for: indexPath.section)[indexPath.row]
        if note.colorTag == .red {
            cell.coloredTag.colorFill = UIColor.red
            cell.coloredTag.colorStroke = UIColor.red
        }
        if note.colorTag == .green {
            cell.coloredTag.colorFill = UIColor.green
            cell.coloredTag.colorStroke = UIColor.green
        }
        if note.colorTag == .blue {
            cell.coloredTag.colorFill = UIColor.blue
            cell.coloredTag.colorStroke = UIColor.blue
        }
        if note.colorTag == .purple {
            cell.coloredTag.colorFill = UIColor.purple
            cell.coloredTag.colorStroke = UIColor.purple
        }

        cell.title.text = note.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 103)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! Header
        header.text.text = DataService.instance.stringDateFor(for: indexPath)
        if indexPath.section != 0 {
            header.button.isHidden = true
        } else {
            header.button.isHidden = false
        }
        header.button.addTarget(self, action: #selector(openAddView), for: .touchUpInside)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailNoteViewController()
        vc.data = DataService.instance.getNotes(for: indexPath.section)[indexPath.row]
        vc.indexPath = indexPath
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    @objc func openAddView(sender: UIButton) {
        let vc = AddViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
//        notesArray.append(Note(title: "New", text: nil, date: nil, colorTag: nil))
        
    }
    
}




class GradientView: UIView {

    let gradient = CAGradientLayer()



    override init(frame: CGRect) {
        super.init(frame: frame)
        addGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds

    }
    
    func addGradient(){
        gradient.colors = [UIColor(red: 255/255, green: 0, blue: 255/255, alpha: 1).cgColor,
                                UIColor(red: 110/255, green: 0, blue: 170/255, alpha:1).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.drawsAsynchronously = true
        self.layer.addSublayer(gradient)

    }

}





