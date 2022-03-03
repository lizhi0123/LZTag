//
//  CollectionFootView.swift
//  LZTag_Example
//
//  Created by lizhi on 2022/3/2.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class CollectionFootView: UICollectionReusableView {
    var label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "foot"
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
