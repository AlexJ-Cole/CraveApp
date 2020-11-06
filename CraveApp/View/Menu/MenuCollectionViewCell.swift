//
//  MenuCollectionViewCell.swift
//  CraveApp
//
//  Created by Alex Cole on 10/28/20.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MenuCollectionViewCell"
    
    //MARK: - Subviews
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 22)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.8
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(priceLabel)
        
        let offset: CGFloat = 10
        
        imageView.autoPinEdge(toSuperviewEdge: .left, withInset: offset)
        imageView.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
        imageView.autoPinEdge(toSuperviewEdge: .top, withInset: offset)
        imageView.autoSetDimension(.height, toSize: self.frame.height / 2)
        
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: offset)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
        titleLabel.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: offset)

        priceLabel.autoPinEdge(toSuperviewEdge: .left, withInset: offset)
        priceLabel.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
        priceLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: offset)
        priceLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: offset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure Function
    
    public func configure(with model: MenuItem) {
        imageView.image = UIImage(named: "crave_logo")
        
        titleLabel.text = model.name
        
        if String(model.price).split(separator: ".")[1].count == 1 {
            priceLabel.text = "$\(model.price)0"
        } else {
            priceLabel.text = "$\(model.price)"
        }
        
        self.backgroundColor = UIColor(named: "craveTeal")
    }
    
}
