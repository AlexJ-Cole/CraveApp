//
//  MenuItemViewController.swift
//  CraveApp
//
//  Created by Alex Cole on 10/28/20.
//

import UIKit

class MenuItemViewController: UIViewController {
    
    //MARK: - UI Elements
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    var itemView = MenuItemDetailView()
    
    //MARK: - Variables
    
    var item: MenuItem!
    
    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = item.name
        
        scrollView.delegate = self
        
        setupItemView()
        scrollView.addSubview(itemView)
        
        view.addSubview(scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = view.frame
        itemView.frame = view.frame
        
        //Sets scrollView content size to match content size of businessView after all views have been populated with data.
        //This NEEDS to be delayed by a little bit so that frames can properly be drawn before setting the contentSize for scrollView
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            var contentRect = CGRect.zero
            for view in strongSelf.itemView.subviews {
                contentRect = contentRect.union(view.frame)
            }

            strongSelf.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: contentRect.height)
        })
    }
    
    func setupItemView() {
        itemView.delegate = self
        itemView.imageView.image = UIImage(named: "crave_logo")
        itemView.descLabel.text = item.description
        if String(item.price).split(separator: ".")[1].count == 1 {
            itemView.priceLabel.text = "$\(item.price)0"
        } else {
            itemView.priceLabel.text = "$\(item.price)"
        }
    }
}

extension MenuItemViewController: UIScrollViewDelegate {
    
}

extension MenuItemViewController: MenuItemDetailViewDelegate {
    
}
