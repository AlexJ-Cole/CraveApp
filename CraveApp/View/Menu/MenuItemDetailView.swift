//
//  MenuItemDetailView.swift
//  CraveApp
//
//  Created by Alex Cole on 11/2/20.
//

import UIKit

protocol MenuItemDetailViewDelegate {
    //This protocol should handle toppings/add-in/flavor/exclusion selections
    //Probably gonna have to subclass UIButton for these checkboxes kinda like `CheckBoxButton`
}

class MenuItemDetailView: UIView {
    
    //MARK: - Variables
    
    var delegate: MenuItemDetailViewDelegate?
    
    //MARK: - UI Elements

    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let descLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .equalSpacing
        view.axis = .vertical
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autoSetDimension(.height, toSize: 1000)
        
        self.addSubview(imageView)
        self.addSubview(descLabel)
        self.addSubview(priceLabel)
        self.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        let offset: CGFloat = 10
        let mainWidth = UIScreen.main.bounds.width
        
        imageView.autoPinEdge(toSuperviewEdge: .left, withInset: offset)
        imageView.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
        imageView.autoPinEdge(toSuperviewEdge: .top, withInset: offset)
        imageView.autoSetDimension(.height, toSize: mainWidth - 20)
        
        descLabel.autoPinEdge(toSuperviewEdge: .left, withInset: offset)
        descLabel.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
        descLabel.autoPinEdge(.top, to: .bottom, of: imageView)
        descLabel.autoSetDimension(.width, toSize: mainWidth - 20)
        
        priceLabel.autoPinEdge(toSuperviewEdge: .left, withInset: offset)
        priceLabel.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
        priceLabel.autoPinEdge(.top, to: .bottom, of: descLabel, withOffset: offset)
        
        stackView.autoPinEdge(.top, to: .bottom, of: priceLabel, withOffset: offset)
        stackView.autoPinEdge(toSuperviewEdge: .left, withInset: offset)
        stackView.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
    }
}
