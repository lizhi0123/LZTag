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
    /// section head size
    func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, sizeForHeaderInSection section: Int) -> CGSize

    func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, sizeForFooterInSection section: Int) -> CGSize

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

    open weak var delegate: LZTagLayoutDelegate?
//    var titles = [String]()
    /// tag 内容的对齐方式
    open var contentAlignment = TagContentAlignment.center

    // 可见区域
    private(set) var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    // 内容高度
    private(set) var contentHeight: CGFloat = 0
    override open func prepare() {
        guard let collectionView = self.collectionView, let delegate = self.delegate else { return }
        let sections = collectionView.numberOfSections
        contentHeight = 0
        visibleLayoutAttributes.removeAll(keepingCapacity: true)

        for section in 0 ..< sections {
            let headSize = delegate.tagLayout(self, collectionView: collectionView, sizeForHeaderInSection: section)
            contentHeight += headSize.height
            // 处理tag
            let rows = collectionView.numberOfItems(inSection: section)
            var frame = CGRect(x: 0, y: contentHeight + lineSpacing, width: 0, height: 0)
            var contentWidthInRow = CGFloat(0)
            var indexPathsInRow = [IndexPath]()
            for item in 0 ..< rows {
                let indexPath = IndexPath(item: item, section: section)
                let text = delegate.tagLayout(self, collectionView: collectionView, textForItemAt: indexPath)
                let tagInnerMargin = delegate.tagLayout(self, collectionView: collectionView, tagInnerMarginForItemAt: indexPath)
                let tagWidth = textWidth(text) + tagInnerMargin

                switch contentAlignment {
                case .left:
                    break
                case .right:
                    if frame.maxX + tagWidth + itemSpacing * 2 > self.collectionView!.frame.width {
                        // 需要换行
                        resetRightAlignmentRowFrame(contentWidthInRow: contentWidthInRow, indexPathsInRow: indexPathsInRow)
                    }

                case .center:
                    if frame.maxX + tagWidth + itemSpacing * 2 > self.collectionView!.frame.width {
                        // 需要换行
                        resetCenterAlignmentRowFrame(contentWidthInRow: contentWidthInRow, indexPathsInRow: indexPathsInRow)
                    }
                }
                // 正常靠左显示
                if frame.maxX + tagWidth + itemSpacing * 2 > self.collectionView!.frame.width {
                    indexPathsInRow.removeAll()
                    contentWidthInRow = 0
                    // 需要换行
                    frame = CGRect(x: itemSpacing, y: frame.maxY + lineSpacing, width: tagWidth, height: itemHeight)
                    contentWidthInRow = itemSpacing + tagWidth
                } else {
                    frame = CGRect(x: frame.maxX + itemSpacing, y: frame.origin.y, width: tagWidth, height: itemHeight)
                    contentWidthInRow = contentWidthInRow + itemSpacing + tagWidth
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
            let footerSize = delegate.tagLayout(self, collectionView: collectionView, sizeForFooterInSection: section)
            contentHeight = frame.maxY + footerSize.height
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

        func resetRightAlignmentRowFrame(contentWidthInRow: CGFloat, indexPathsInRow: [IndexPath]) {
            let offset = ((self.collectionView?.frame.size.width ?? 0) - contentWidthInRow - itemSpacing)
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
        return visibleLayoutAttributes
    }

    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let layoutAttribute = visibleLayoutAttributes.first { $0.indexPath == indexPath }
        return layoutAttribute
    }

    // 根据文字 确定label的宽度
    func textWidth(_ text: String) -> CGFloat {
        let rect = (text as NSString).boundingRect(with: .zero, options: .usesLineFragmentOrigin, attributes: [.font: itemFont], context: nil)
        return rect.width
    }
}
