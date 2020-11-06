//
//  HoursCollectionViewCell.swift
//  CraveApp
//
//  Created by Alex Cole on 10/30/20.
//

import UIKit

class HoursCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HoursCollectionViewCell"
    
    //MARK: - Subviews
    
    private let dayLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 24, weight: .semibold)
        lbl.textAlignment = .center
        lbl.textColor = UIColor(named: "craveTeal")
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let topHourLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = UIColor(named: "craveTeal")
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let botHourLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = UIColor(named: "craveTeal")
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let toLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "TO"
        lbl.textAlignment = .center
        lbl.textColor = UIColor(named: "craveTeal")
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 15
        
        self.addSubview(dayLabel)
        self.addSubview(topHourLabel)
        self.addSubview(toLabel)
        self.addSubview(botHourLabel)
        
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.8
        self.backgroundColor = .systemBackground
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let offset: CGFloat = 10
        
        dayLabel.autoPinEdge(toSuperviewEdge: .top, withInset: offset)
        dayLabel.autoPinEdge(toSuperviewEdge: .left, withInset: offset)
        dayLabel.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
        
        topHourLabel.autoPinEdge(toSuperviewEdge: .left, withInset: offset)
        topHourLabel.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
        topHourLabel.autoPinEdge(.top, to: .bottom, of: dayLabel, withOffset: 40)
        
        toLabel.autoPinEdge(toSuperviewEdge: .left, withInset: offset)
        toLabel.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
        toLabel.autoPinEdge(.top, to: .bottom, of: topHourLabel, withOffset: 20)
        
        botHourLabel.autoPinEdge(toSuperviewEdge: .left, withInset: offset)
        botHourLabel.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
        botHourLabel.autoPinEdge(.top, to: .bottom, of: toLabel, withOffset: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure Function
    
    public func configure(with model: Hours) {
        dayLabel.text = model.day
        topHourLabel.text = model.open
        botHourLabel.text = model.close
        toLabel.text = model.isOpen ? "TO" : "CLOSED"
        
        //Draws a border around the item that represents current day
        self.layer.borderColor = model.isToday ? UIColor(named: "craveTeal")?.cgColor : nil
        self.layer.borderWidth = model.isToday ? 3 : 0
    }
}
