//
//  RoundCollectionCell.swift
//  LZTag_Example
//
//  Created by lizhi on 2022/3/2.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class RoundCollectionCell: UICollectionViewCell {

    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.textColor = .black
        temp.text = "label"
        temp.font  = UIFont.systemFont(ofSize: 12)
        temp.textAlignment = .center
        
        temp.layer.masksToBounds = true
        temp.layer.cornerRadius = 12
        temp.clipsToBounds  = true
        temp.backgroundColor = .lightText
        temp.layer.borderColor = UIColor.darkGray.cgColor
        temp.layer.borderWidth = 2
        
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.frame = self.bounds
        
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(title:String)  {
        self.label.text = title
    }
}
