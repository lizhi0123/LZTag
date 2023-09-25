//
//  LZTagCollectionCell.swift
//  Tag
//
//  Created by lizhi on 2022/3/1.
//

import UIKit
import SnapKit

open class LZTagCollectionCell: UICollectionViewCell {
    public static var reuseID: String {
      return NSStringFromClass(classForCoder())
    }
    open public(set) lazy var label: UILabel = {
        let temp = UILabel()
        temp.textColor = .darkGray
        temp.text = "wo"
        temp.font  = UIFont.systemFont(ofSize: 12)
        temp.textAlignment = .center
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
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   open func fill(title:String)  {
        self.label.text = title
        
    }
}
