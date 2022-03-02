//
//  RoundViewController.swift
//  LZTag_Example
//
//  Created by lizhi on 2022/3/2.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import LZTag

class RoundViewController: UIViewController {

    lazy var layout: LZTagLayout = {
       let temp = LZTagLayout()
       temp.delegate = self
       return temp
   }()
   
    var titles = ["round现在左对齐","可设右对齐","可设居中对齐","cell 内可以自定义1","内边距可自定义2",
                  "cell 内可以自定义3","内边距可自定义4",
                  "标签1","标签选择器","标签1","标签选择器"]

   private(set) lazy var collectionView: UICollectionView = {
       let layout = self.layout//
       let temp =  UICollectionView(frame: .zero, collectionViewLayout: layout)
       
       return temp
   }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        collectionView.register(RoundCollectionCell.self, forCellWithReuseIdentifier: "RoundCollectionCell")
        collectionView.register(CollectionHeadView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier: "CollectionHeadView")
        collectionView.dataSource = self
        collectionView.backgroundColor = .yellow
    
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }

    }

}


extension RoundViewController: UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.titles.count
   }
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoundCollectionCell", for: indexPath) as! RoundCollectionCell
       let title = self.titles[indexPath.row]
       cell.fill(title: title)
       return cell
   }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionHeadView", for: indexPath)
        return headView
    }
}


extension RoundViewController: LZTagLayoutDelegate {
   /// 标签内边距
   func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, tagInnerMarginForItemAt indexPath: IndexPath) -> CGFloat {
       return CGFloat(25)
   }
   
   func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, sizeForHeaderInSection section: Int) -> CGSize {
       return CGSize(width: 50, height: 30)
   }
   
   func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, textForItemAt indexPath: IndexPath) -> String {
       return self.titles[indexPath.row]
   }
   func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, sizeForFooterInSection section: Int) -> CGSize {
       CGSize(width: 50, height: 30)
   }
}


