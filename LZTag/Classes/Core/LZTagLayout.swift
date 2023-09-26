//
//  LZTagLayout.swift
//  Tag
//
//  Created by lizhi on 2022/3/1.
//

import UIKit

 public protocol LZTagLayoutDelegate: NSObject {
    /// 文字内容for cell
    func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, textForItemAt indexPath: IndexPath) -> String
    /// section head footer size
    func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, sizeForSupplementaryElementOfKind kind: String, at section: Int) -> CGSize

    ///  标签的内边距
    func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, tagInnerMarginForItemAt indexPath: IndexPath) -> CGFloat
}

// NSTextAlignment    textAlignment
public enum TagContentAlignment {
    case left
    case right
    case center
}

open class LZTagLayout: UICollectionViewLayout {
    // 标签的内边距
//    open var tagInnerMargin: CGFloat = 25
    // 元素间距
    open var itemSpacing: CGFloat = 10
    // 行间距
    open var lineSpacing: CGFloat = 10
    // 标签的高度
    open var itemHeight: CGFloat = 25
    // 标签的字体
    open var itemFont = UIFont.systemFont(ofSize: 12)
    
    // 缩放边距，现在只支持 左 和 右
    open var sectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)//.zero

    open weak var delegate: LZTagLayoutDelegate?
//    var titles = [String]()
    /// tag 内容的对齐方式
    open var contentAlignment = TagContentAlignment.left

    // 可见区域
    private(set) var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    private var headerFooterLayoutAttributes = [UICollectionViewLayoutAttributes]()
    // 内容高度
    private(set) var contentHeight: CGFloat = 0
    override open func prepare() {
        guard let collectionView = self.collectionView, let delegate = self.delegate else { return }
        let sections = collectionView.numberOfSections
        contentHeight = 0
        visibleLayoutAttributes.removeAll()
        headerFooterLayoutAttributes.removeAll()

        for section in 0 ..< sections {
            let sectionIndexPath = IndexPath(item: 0, section: section)
            let headerAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: sectionIndexPath)
            //head
            let sectionHeadSize = delegate.tagLayout(self, collectionView: collectionView, sizeForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: section)
            let sectionOriginY = contentHeight
            let sectionHeaderFrame = CGRect(x: 0 , y: sectionOriginY , width: sectionHeadSize.width , height: sectionHeadSize.height)
            headerAttribute.frame = sectionHeaderFrame
            headerFooterLayoutAttributes.append(headerAttribute)
            
            contentHeight += sectionHeadSize.height
            // 处理tag
            let rows = collectionView.numberOfItems(inSection: section)
            var frame = CGRect(x: self.sectionInset.left, y: contentHeight + lineSpacing, width: 0, height: 0)
            /// 一行 已内容的宽度
            var contentWidthInRow = CGFloat(0)
            var indexPathsInRow = [IndexPath]()
            
            /// 是否是 第一行的第一个item
            var isFirstItemInSection = true
            
            for item in 0 ..< rows {
                let indexPath = IndexPath(item: item, section: section)
                let text = delegate.tagLayout(self, collectionView: collectionView, textForItemAt: indexPath)
                let tagInnerMargin = delegate.tagLayout(self, collectionView: collectionView, tagInnerMarginForItemAt: indexPath)
                let tagWidth = textWidth(text) + tagInnerMargin

                switch contentAlignment {
                case .left:
                    break
                case .right:
                    if frame.maxX  + itemSpacing + tagWidth > self.collectionView!.frame.width -  self.sectionInset.right {
                        // 需要换行
                        resetRightAlignmentRowFrame(contentWidthInRow: contentWidthInRow, indexPathsInRow: indexPathsInRow)
                    }

                case .center:
                    if frame.maxX  + itemSpacing  + tagWidth    > self.collectionView!.frame.width - self.sectionInset.right {
                        // 需要换行
                        resetCenterAlignmentRowFrame(contentWidthInRow: contentWidthInRow, indexPathsInRow: indexPathsInRow)
                    }
                }
                // 正常靠左显示
                if frame.maxX  + itemSpacing  + tagWidth > (self.collectionView!.frame.width - self.sectionInset.right) {
                    indexPathsInRow.removeAll()
                    contentWidthInRow = 0
                    // 需要换行
                    frame = CGRect(x: self.sectionInset.left, y: frame.maxY + lineSpacing, width: tagWidth, height: itemHeight)
                    contentWidthInRow =  self.sectionInset.left + tagWidth
                } else {//不换行
                    var newFrameX:CGFloat
                    if (isFirstItemInSection){
                        newFrameX = frame.maxX
                    }else {
                        newFrameX = frame.maxX + itemSpacing
                    }
                    frame = CGRect(x: newFrameX, y: frame.origin.y, width: tagWidth, height: itemHeight)
                    contentWidthInRow = isFirstItemInSection ? tagWidth : contentWidthInRow + itemSpacing + tagWidth
                    isFirstItemInSection = false
                }
                indexPathsInRow.append(indexPath)

                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                visibleLayoutAttributes.removeAll { $0.indexPath == indexPath }
                visibleLayoutAttributes.append(attributes)
            }
            if indexPathsInRow.isEmpty == false { // 最后一行重设frame
                switch contentAlignment {
                case .left:
                    break
                case .right:
                    resetRightAlignmentRowFrame(contentWidthInRow: contentWidthInRow, indexPathsInRow: indexPathsInRow)
                case .center:
                    resetCenterAlignmentRowFrame(contentWidthInRow: contentWidthInRow, indexPathsInRow: indexPathsInRow)
                }

                contentWidthInRow = 0
                indexPathsInRow.removeAll()
            }
            
            contentHeight = frame.maxY + lineSpacing

            //footer
            let sectionFooterSize = delegate.tagLayout(self, collectionView: collectionView, sizeForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter, at: section)
            let sectionFooterOriginY = contentHeight
            let sectionFooterFrame = CGRect(x: 0 , y: sectionFooterOriginY , width: sectionFooterSize.width , height: sectionFooterSize.height)
            let footerAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: sectionIndexPath)
            footerAttribute.frame = sectionFooterFrame
            headerFooterLayoutAttributes.append(footerAttribute)
            
            
            contentHeight = contentHeight + sectionFooterSize.height
        }

        
        /// <#Description#>
        /// - Parameters:
        ///   - contentWidthInRow: 一行已有内容的宽度
        ///   - indexPathsInRow: <#indexPathsInRow description#>
        func resetCenterAlignmentRowFrame(contentWidthInRow: CGFloat, indexPathsInRow: [IndexPath]) {
            //移动距离
            let offset = ((self.collectionView?.frame.size.width ?? 0) - self.sectionInset.left - self.sectionInset.right - contentWidthInRow - itemSpacing ) / 2
            for indexPath in indexPathsInRow {
                let attribute = visibleLayoutAttributes.first { $0.indexPath == indexPath }
                if let centerOld = attribute?.center {
                    attribute?.center = CGPoint(x: centerOld.x + offset, y: centerOld.y)
                }
            }
        }

        
        /// <#Description#>
        /// - Parameters:
        ///   - contentWidthInRow: 一行已有内容的宽度
        ///   - indexPathsInRow: <#indexPathsInRow description#>
        func resetRightAlignmentRowFrame(contentWidthInRow: CGFloat, indexPathsInRow: [IndexPath]) {
            //移动距离
            let offset = ((self.collectionView?.frame.size.width ?? 0) - self.sectionInset.left - self.sectionInset.right - contentWidthInRow - itemSpacing )
            for indexPath in indexPathsInRow {
                let attribute = visibleLayoutAttributes.first { $0.indexPath == indexPath }
                if let centerOld = attribute?.center {
                    attribute?.center = CGPoint(x: centerOld.x + offset, y: centerOld.y)
                }
            }
        }
    }

    override open var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.frame.size.width ?? 0, height: contentHeight)
    }

    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return visibleLayoutAttributes + headerFooterLayoutAttributes
//        return visibleLayoutAttributes
    }

    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let layoutAttribute = visibleLayoutAttributes.first { $0.indexPath == indexPath }
        return layoutAttribute
    }
    
    open override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let layoutAttribute = headerFooterLayoutAttributes.first {( $0.indexPath == indexPath) && ($0.representedElementKind == elementKind) }
        return layoutAttribute
    }

    // 根据文字 确定label的宽度
    func textWidth(_ text: String) -> CGFloat {
        let rect = (text as NSString).boundingRect(with: .zero, options: .usesLineFragmentOrigin, attributes: [.font: itemFont], context: nil)
        return rect.width
    }
}


