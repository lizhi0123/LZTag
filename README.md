#### iOS swift 标签选择器 居中对齐，左对齐,右对齐
![image.png](https://upload-images.jianshu.io/upload_images/2384741-706fa275ee092897.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



实现方法
> UICollectionView 重新自定义 UICollectionViewLayout

demo 地址 https://gitee.com/Sunny0123/lztag

 - #### 引用

```
pod 'LZTag', :git => 'https://gitee.com/Sunny0123/lztag.git'
```

- #### 主要实现代码


```
//
//  LZTagLayout.swift
//  Tag
//
//  Created by lizhi on 2022/3/1.
//

import UIKit

protocol LZTagLayoutDelegate: NSObject {
    func collectionView(_ collectionView: UICollectionView, TextForItemAt indexPath: IndexPath) -> String
}

// NSTextAlignment    textAlignment
enum TagContentAlignment {
    case left
    // right 未实现
//    case right
    case center
}

class LZTagLayout: UICollectionViewLayout {
    // 标签的内边距
    var tagInnerMargin: CGFloat = 25
    // 元素间距
    var itemSpacing: CGFloat = 10
    // 行间距
    var lineSpacing: CGFloat = 10
    // 标签的高度
    var itemHeight: CGFloat = 25
    // 标签的字体
    var itemFont = UIFont.systemFont(ofSize: 12)
    
    weak var delegate: LZTagLayoutDelegate?
    var titles = ["我是标题11", "对对我是标签选择器2", "对对我是标签选择器13", "我要居中显示24", "我5", "我是6", "我是标题11", "对对我是标签选择器2", "对对我是标签选择器13", "我要居中显示24", "我5", "我是6"]
    /// tag 内容的对齐方式
    var contentAlignment = TagContentAlignment.center

    // 可见区域
    private var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    // 内容高度
    private var contentHeight: CGFloat = 0
    override func prepare() {
        guard let collectionView = self.collectionView else { return }
        let sections = collectionView.numberOfSections
        contentHeight = 0
        visibleLayoutAttributes.removeAll(keepingCapacity: true)
      
        for section in 0 ..< sections {
            // 处理tag
            let rows = collectionView.numberOfItems(inSection: section)
            var frame = CGRect(x: 0, y: contentHeight + lineSpacing, width: 0, height: 0)
            var contentWidthInRowCenter = CGFloat(0)
            var indexPathsInRowCenter = [IndexPath]()
            for item in 0 ..< rows {
                let indexPath = IndexPath(item: item, section: section)
                let text = titles[item] // delegate.collectionView(collectionView, TextForItemAt: indexPath)
                let tagWidth = textWidth(text) + tagInnerMargin
                switch contentAlignment {
                case .left:
                    // 其他
                    if frame.maxX + tagWidth + itemSpacing * 2 > self.collectionView!.frame.width {
                        // 需要换行
                        frame = CGRect(x: itemSpacing, y: frame.maxY + lineSpacing, width: tagWidth, height: itemHeight)
                    } else {
                        frame = CGRect(x: frame.maxX + itemSpacing, y: frame.origin.y, width: tagWidth, height: itemHeight)
                    }
                case .center:
                    // 其他
                    if frame.maxX + tagWidth + itemSpacing * 2 > self.collectionView!.frame.width {
                        resetCenterAlignmentRowFrame(contentWidthInRow: contentWidthInRowCenter, indexPathsInRow: indexPathsInRowCenter)
                        indexPathsInRowCenter.removeAll()
                        contentWidthInRowCenter = 0
                        // 需要换行
                        frame = CGRect(x: itemSpacing, y: frame.maxY + lineSpacing, width: tagWidth, height: itemHeight)
                        contentWidthInRowCenter = itemSpacing + tagWidth
                    } else {
                        frame = CGRect(x: frame.maxX + itemSpacing, y: frame.origin.y, width: tagWidth, height: itemHeight)
                        contentWidthInRowCenter = contentWidthInRowCenter + itemSpacing + tagWidth
                    }
                    indexPathsInRowCenter.append(indexPath)
                }
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                visibleLayoutAttributes.removeAll { $0.indexPath == indexPath }
                visibleLayoutAttributes.append(attributes)
            }
            if indexPathsInRowCenter.isEmpty == false {
                resetCenterAlignmentRowFrame(contentWidthInRow: contentWidthInRowCenter, indexPathsInRow: indexPathsInRowCenter)
                contentWidthInRowCenter = 0
                indexPathsInRowCenter.removeAll()
            }
            contentHeight = frame.maxY
        }
        
        func resetCenterAlignmentRowFrame(contentWidthInRow: CGFloat, indexPathsInRow: [IndexPath]) {
            let offset = ((self.collectionView?.frame.size.width ?? 0) - contentWidthInRow - itemSpacing) / 2
            for indexPath in indexPathsInRow {
                let attribute = visibleLayoutAttributes.first { $0.indexPath == indexPath }
                if let centerOld = attribute?.center {
                    attribute?.center = CGPoint(x: centerOld.x + offset, y: centerOld.y)
                }
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.frame.size.width ?? 0, height: contentHeight)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let layoutAttribute = visibleLayoutAttributes.first { $0.indexPath == indexPath }
        return layoutAttribute
    }
    
    // 根据文字 确定label的宽度
    private func textWidth(_ text: String) -> CGFloat {
        let rect = (text as NSString).boundingRect(with: .zero, options: .usesLineFragmentOrigin, attributes: [.font: itemFont], context: nil)
        return rect.width
    }
}

```
