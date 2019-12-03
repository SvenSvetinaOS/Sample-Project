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
    
    var albumModelForUser = [AlbumModel]()
    var photoModelForUser = [PhotoModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = albumCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AlbumSectionHeader", for: indexPath) as! AlbumSectionHeader
        sectionHeader.configureWithModel(albumModelForUser, indexPath)
        
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 320, height: 25)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return albumModelForUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoModelForUser.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumCollectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCell
        let photosForUser = albumModelForUser[indexPath.section].photoModel
        let thumbnailUrl = photosForUser[indexPath.row].thumbnailUrl
        
        setImage(string: thumbnailUrl, imageView: cell.albumImageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoModel = albumModelForUser[indexPath.section].photoModel
        
        let photoViewController = PhotoViewController()
        photoViewController.photoModelForUser = photoModel
    }
    
    func setupLayout() {
        albumCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: createCompositionalLayout())
        albumCollectionView.register(UINib(nibName: "AlbumSectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AlbumSectionHeader")
        albumCollectionView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellWithReuseIdentifier: "albumCell")
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        albumCollectionView.backgroundColor = .white
        albumCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(albumCollectionView)
        
        albumCollectionView.autoPinEdge(toSuperviewEdge: .top)
        albumCollectionView.autoPinEdge(toSuperviewEdge: .bottom)
        albumCollectionView.autoPinEdge(toSuperviewEdge: .leading)
        albumCollectionView.autoPinEdge(toSuperviewEdge: .trailing)
        
        view.layoutSubviews()
    }
    
    func setImage(string: String, imageView: UIImageView) {
        let url = URL(string: string)
        let processor = DownsamplingImageProcessor(size: imageView.frame.size) |> RoundCornerImageProcessor(cornerRadius: 5)
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
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layotEnvironment in
            let photoModelForUser = self.photoModelForUser[sectionIndex]
            
            switch photoModelForUser.thumbnailUrl {
            default:
                return self.createSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 3
        layout.configuration = config
        return layout
    }
    
    func createSection() -> NSCollectionLayoutSection {
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(25)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(150), heightDimension: .estimated(150))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.boundarySupplementaryItems = [sectionHeader]
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return layoutSection
    }
}
