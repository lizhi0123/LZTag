//
//  ExpandCollectionCell.swift
//  LZTag_Example
//
//  Created by lizhi on 2022/3/3.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

open class LZTagRoundImageTitleCollectionCell: UICollectionViewCell {
    open lazy var roundView: UIView = {
        let temp = UIView()
        temp.layer.masksToBounds = true
        temp.layer.cornerRadius = 12
        temp.clipsToBounds = true
        temp.backgroundColor = .lightText
        temp.layer.borderColor = UIColor.darkGray.cgColor
        temp.layer.borderWidth = 2
        
        return temp
    }()

    open lazy var zanImgView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(named: "zan")
        temp.contentMode = .scaleToFill
        return temp
    }()

    open lazy var label: UILabel = {
        let temp = UILabel()
        temp.textColor = .black
        temp.text = "label"
        temp.font = UIFont.systemFont(ofSize: 12)
        temp.textAlignment = .center
        
        return temp
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    open func addViews() {
        label.frame = bounds
        
        addSubview(roundView)
        roundView.addSubview(zanImgView)
        roundView.addSubview(label)
        
        roundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        zanImgView.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.leading.top.bottom.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.leading.equalTo(zanImgView.snp.trailing)
            make.top.bottom.trailing.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func fill(title: String) {
        label.text = title
    }
}
