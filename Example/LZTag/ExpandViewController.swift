//
//  ExpandViewController.swift
//  LZTag_Example
//
//  Created by lizhi on 2022/3/3.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import LZTag

class ExpandViewController: UIViewController {

    lazy var layout: LZTagLayout = {
       let temp = LZTagLayout()
        temp.itemHeight = 40
       temp.delegate = self
       return temp
   }()
   
    var titles = ["round现在左对齐","可设右对齐","可设居中对齐","cell 内可以自定义1","内边距可自定义2",
                  "cell 内可以自定义3","内边距可自定义4",
                  "标签1","标签选择器","标签1","标签选择器"]

   private(set) lazy var collectionView: UICollectionView = {
       let layout = self.layout
//       let  layout = UICollectionViewFlowLayout()
       let temp =  UICollectionView(frame: .zero, collectionViewLayout: layout)
       return temp
   }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        collectionView.register(ExpandCollectionCell.self, forCellWithReuseIdentifier: "ExpandCollectionCell")
        collectionView.register(CollectionHeadView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: "CollectionHeadView")
        collectionView.register(CollectionFootView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionFooter , withReuseIdentifier: "CollectionFootView")
        collectionView.dataSource = self
        collectionView.backgroundColor = .yellow
    
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }

    }

}


extension ExpandViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.titles.count
   }
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExpandCollectionCell", for: indexPath) as! ExpandCollectionCell
       let title = self.titles[indexPath.row]
       cell.fill(title: title)
       return cell
   }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeadView", for: indexPath)
            headView.backgroundColor = .systemRed
            return headView
            
        case UICollectionView.elementKindSectionFooter:
            
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionFootView", for: indexPath) as! CollectionFootView
            footerView.backgroundColor = .systemOrange
            return footerView
        default:
            return UICollectionReusableView()
        }
       
    }
}


extension ExpandViewController: LZTagLayoutDelegate {
   /// 标签内边距
   func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, tagInnerMarginForItemAt indexPath: IndexPath) -> CGFloat {
       let zanwidth = 30//图片赞的宽度
       let spacing = 10//间距
       return CGFloat(zanwidth + spacing)
   }
   
    func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, sizeForSupplementaryElementOfKind kind: String, at section: Int) -> CGSize {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return CGSize(width: 250, height: 30)
        case UICollectionView.elementKindSectionFooter:
            return CGSize(width: 250, height: 40)
        default:
            return CGSize(width: 250, height: 40)
        }
       
   }
   
   func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, textForItemAt indexPath: IndexPath) -> String {
       return self.titles[indexPath.row]
   }

}


