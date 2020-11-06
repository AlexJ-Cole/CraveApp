//
//  FilterTableViewCell.swift
//  CraveApp
//
//  Created by Alex Cole on 10/28/20.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    static let identifier = "FilterTableViewCell"
    
    //MARK: - Subviews
    
    var checkBtn: CheckBoxButton = {
        let btn = CheckBoxButton()
        return btn
    }()
    
    //MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let offset: CGFloat = 10
        
        self.addSubview(checkBtn)
        
        checkBtn.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
        checkBtn.autoPinEdge(toSuperviewEdge: .top, withInset: offset)
        checkBtn.autoPinEdge(toSuperviewEdge: .bottom, withInset: offset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure Function
    
    public func configure(with string: String) {
        self.textLabel?.text = string
    }
    
}
