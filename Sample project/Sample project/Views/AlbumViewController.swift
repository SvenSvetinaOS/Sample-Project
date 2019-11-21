//
//  AlbumViewController.swift
//  Sample project
//
//  Created by Sven Svetina on 19/11/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import Kingfisher

class AlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var albumCollectionView: UICollectionView!
    var sectionHeader = UICollectionReusableView()
    weak var sectionLabel: UILabel!
    
    var user: UserModel?
    var networkService: NetworkService?
    var albumModelForUser = [AlbumModel]()
    
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
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = albumCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AlbumSectionHeader", for: indexPath) as! AlbumSectionHeader
        sectionHeader.albumName.text = albumModelForUser[indexPath.section].title.capitalized
        sectionHeader.albumName.sizeToFit()
        sectionHeader.albumName.autoCenterInSuperview()
        
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 320, height: 25)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return albumModelForUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumCollectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCell
        
        let albumModelForUser = self.albumModelForUser[indexPath.section]
        
        let thumbnailUrl = albumModelForUser.photoModel.first?.thumbnailUrl
        
        setImage(string: thumbnailUrl!, imageView: cell.albumImageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoModel = albumModelForUser[indexPath.section].photoModel
        
        let photoViewController = PhotoViewController()
        photoViewController.photoModelForUser = photoModel
        
        navigationController?.pushViewController(photoViewController, animated: true)
    }
    
    func setupLayout() {
        let spacing: CGFloat = 5.0
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        albumCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        albumCollectionView.register(UINib(nibName: "AlbumSectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AlbumSectionHeader")
        albumCollectionView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellWithReuseIdentifier: "albumCell")
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        albumCollectionView.backgroundColor = .white
        view.addSubview(albumCollectionView)
        
        albumCollectionView.autoPinEdge(toSuperviewEdge: .top)
        albumCollectionView.autoPinEdge(toSuperviewEdge: .bottom)
        albumCollectionView.autoPinEdge(toSuperviewEdge: .leading)
        albumCollectionView.autoPinEdge(toSuperviewEdge: .trailing)
        
        view.layoutSubviews()
    }
    
    func setImage(string: String, imageView: UIImageView) {
        let url = URL(string: string)
        let processor = DownsamplingImageProcessor(size: imageView.frame.size) |> RoundCornerImageProcessor(cornerRadius: 0)
        imageView.kf.indicatorType = .none
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
