//
//  LZTagView.swift
//  Tag
//
//  Created by lizhi on 2022/3/1.
//

import UIKit
import LZTag

 class LZTagView: UIView {
    
     lazy var layout: LZTagLayout = {
        let lay = LZTagLayout()
         lay.itemSpacing = 10
         lay.lineSpacing = 10
         lay.itemHeight = 25
         lay.itemFont = UIFont.systemFont(ofSize: 12)
         lay.itemSpacing = 10
         lay.contentAlignment = .left
         lay.delegate = self
        return lay
    }()
    
    var tagContentAlignment = TagContentAlignment.left {
        didSet {
            self.layout.contentAlignment = tagContentAlignment
        }
    }
    
    var titles = [String]()

    private(set) lazy var collectionView: UICollectionView = {
        let layout = self.layout//
        let temp =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.frame = self.bounds
        collectionView.backgroundColor = .gray
        collectionView.register(LZTagCollectionCell.self, forCellWithReuseIdentifier: LZTagCollectionCell.reuseID)
        collectionView.dataSource = self
    
        self.addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LZTagView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LZTagCollectionCell.reuseID, for: indexPath) as! LZTagCollectionCell
        let title = self.titles[indexPath.row]
        cell.fill(title: title)
        cell.backgroundColor = .orange
        return cell
    }
}


extension LZTagView: LZTagLayoutDelegate {
    func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, sizeForSupplementaryElementOfKind kind: String, at section: Int) -> CGSize {
        return CGSize(width: 50, height: 10)
    }
    
    /// 标签内边距
    func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, tagInnerMarginForItemAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(25)
    }
    
    
    func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, textForItemAt indexPath: IndexPath) -> String {
        return self.titles[indexPath.row]
    }

}
