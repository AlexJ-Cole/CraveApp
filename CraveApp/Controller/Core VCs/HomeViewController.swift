//
//  HomeViewController.swift
//  CraveApp
//
//  Created by Alex Cole on 10/28/20.
//

import UIKit
import PureLayout

class HomeViewController: UIViewController {
    
    //MARK: - UI Elements
    
    private let logoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "crave_logo")
        return view
    }()
    
    private let hoursField: UITextField = {
        let field = UITextField()
        field.textAlignment = .center
        return field
    }()
    
    private let orderBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "craveTeal")
        btn.setTitle("Order Now", for: .normal)
        btn.layer.cornerRadius = 30
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 3
        btn.layer.shadowOpacity = 0.8
        return btn
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemBackground
        view.showsHorizontalScrollIndicator = false
        view.register(HoursCollectionViewCell.self, forCellWithReuseIdentifier: HoursCollectionViewCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Variables
    
    var hours = [Hours]()
    
    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = .systemBackground
        
        view.addSubview(logoView)
        view.addSubview(orderBtn)
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        orderBtn.addTarget(self, action: #selector(orderTapped), for: .touchUpInside)
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            FirestoreManager.shared.getOpenHours(completion: { result in
                switch result {
                case .success(let hours):
                    self?.hours = hours
                    self?.collectionView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        self?.checkHours()
                    })
                case .failure(let error):
                    print("Error: \(error)")
                }
            })
        }
    }

    override func viewDidLayoutSubviews() {
        let offset: CGFloat = 10
        let margOffset: CGFloat = 40
        
        logoView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 0, left: offset, bottom: 0, right: offset), excludingEdge: .bottom)
        logoView.autoSetDimension(.height, toSize: 300)
        
        collectionView.autoPinEdge(.top, to: .bottom, of: logoView, withOffset: offset)
        collectionView.autoPinEdge(toSuperviewEdge: .left)
        collectionView.autoPinEdge(toSuperviewEdge: .right)
        collectionView.autoSetDimension(.height, toSize: view.bounds.height / 4)
        
        orderBtn.autoPinEdge(toSuperviewSafeArea: .left, withInset: margOffset)
        orderBtn.autoPinEdge(toSuperviewSafeArea: .right, withInset: margOffset)
        orderBtn.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: margOffset)
        orderBtn.autoSetDimension(.height, toSize: 52)
    }
    
    //MARK: - Helper Functions
    
    /// Scrolls to current day in collection view and sets `isToday` property of its model to true
    /// This causes a border to be drawn around the item representing the current day
    private func checkHours() {
        let day = Calendar.current.component(.weekday, from: Date()) - 1
        let path = IndexPath(item: day, section: 0)
        
        collectionView.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
        hours[day].isToday = true
        
        collectionView.reloadData()
    }
    
    //MARK: - Button Tap Handlers
    
    @objc func orderTapped() {
        let url = URL(string: "https://www.talech.com/biz/ordering/493096/CRAVE-AMERICAN-CANYON-CA%22#/menu")
        
        let vc = WebViewController()
        vc.url = url
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionView Delegates

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = hours[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HoursCollectionViewCell.identifier, for: indexPath) as! HoursCollectionViewCell
        
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
