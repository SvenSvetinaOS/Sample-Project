//
//  PhotoViewController.swift
//  Sample project
//
//  Created by Sven Svetina on 15/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import Kingfisher

class PhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var photoCollectionView: UICollectionView!
    
    var user: UserModel?
    var networkService: NetworkService?
    var photoModelForUser = [PhotoModel]()
    
    convenience init(user: UserModel, networkService: NetworkService) {
        self.init()
        self.user = user
        self.networkService = networkService
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoModelForUser.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        let photoModelForUser = self.photoModelForUser[indexPath.row]
        let photo = photoModelForUser.url
        setImage(string: photo, imageView: cell.photoImageView)
        
        return cell
    }
    
    func setupLayout() {
         let spacing: CGFloat = 5.0
         let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
         layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
         layout.minimumLineSpacing = spacing
         layout.minimumInteritemSpacing = spacing
         
         photoCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
         photoCollectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
         photoCollectionView.delegate = self
         photoCollectionView.dataSource = self
         photoCollectionView.backgroundColor = .white
         view.addSubview(photoCollectionView)
         
         photoCollectionView.autoPinEdge(toSuperviewEdge: .top)
         photoCollectionView.autoPinEdge(toSuperviewEdge: .bottom)
         photoCollectionView.autoPinEdge(toSuperviewEdge: .leading)
         photoCollectionView.autoPinEdge(toSuperviewEdge: .trailing)
         
         view.layoutSubviews()
     }
    
    func setImage(string: String, imageView: UIImageView) {
        let url = URL(string: string)
        let processor = DownsamplingImageProcessor(size: imageView.frame.size) |> RoundCornerImageProcessor(cornerRadius: 20)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
