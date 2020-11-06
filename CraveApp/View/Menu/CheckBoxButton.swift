//
//  CheckBoxButton.swift
//  CraveApp
//
//  Created by Alex Cole on 10/28/20.
//

import UIKit

class CheckBoxButton: UIButton {
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                self.backgroundColor = UIColor(named: "craveGreen")
            } else {
                self.backgroundColor = .systemBackground
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemBackground
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 7
        
        self.bounds = CGRect(x: 0, y: 0, width: 70, height: 50)
        
        self.addTarget(self, action: #selector(checkBtn), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func checkBtn() {
        isChecked = !isChecked
    }

}
