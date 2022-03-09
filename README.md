#### iOS swift 标签选择器 支持居中对齐，左对齐,右对齐

文章掘金地址：https://juejin.cn/post/7070728070151274532
文章简书地址：https://www.jianshu.com/p/41600e45a10a

基本效果图
![image.png](https://upload-images.jianshu.io/upload_images/2384741-706fa275ee092897.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
圆角效果图
![WechatIMG205.png](https://upload-images.jianshu.io/upload_images/2384741-efa55074a4439f2d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
自定义cell
![image.png](https://upload-images.jianshu.io/upload_images/2384741-dd06f21cfa1d013f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)





实现方法
> UICollectionView 重新自定义 UICollectionViewLayout

demo 地址 https://gitee.com/Sunny0123/lztag(不更新，最新到github)
最新代码地址：https://github.com/lizhi0123/LZTag


v1.0.1 支持 swift5
v1.0.0 支持 swift 4.2


 - #### 引用

```
pod 'LZTag'
```
- #### 使用方法
1.设置collection的layout 为 LZTagLayout
```
 lazy var layout: LZTagLayout = {
       let temp = LZTagLayout()
       temp.delegate = self
       return temp
   }()
 private(set) lazy var collectionView: UICollectionView = {
       let layout = self.layout
       let temp =  UICollectionView(frame: .zero, collectionViewLayout: layout)
       return temp
   }()
```

2.正常使用collectionview
```
collectionView.register(RoundCollectionCell.self, forCellWithReuseIdentifier: "RoundCollectionCell")
        collectionView.register(CollectionHeadView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier: "CollectionHeadView")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionFooter , withReuseIdentifier: "UICollectionReusableView")
        collectionView.dataSource = self
        collectionView.backgroundColor = .yellow
    
        self.view.addSubview(collectionView)
```
3.实现UICollectionViewDataSource，cell可根据需求自定义
```

extension RoundViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
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
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionHeadView", for: indexPath)
            headView.backgroundColor = .systemRed
            return headView
            
        default:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "UICollectionReusableView", for: indexPath)
            footerView.backgroundColor = .systemOrange
            return footerView
        }
       
    }
}
```
4.实现LZTagLayout 的 LZTagLayoutDelegate
  ```
extension RoundViewController: LZTagLayoutDelegate {
   /// 标签内边距
   func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, tagInnerMarginForItemAt indexPath: IndexPath) -> CGFloat {
       return CGFloat(25)
   }
   
    func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, sizeForSupplementaryElementOfKind kind: String, at section: Int) -> CGSize {
        switch kind {
        case UICollectionElementKindSectionHeader:
            return CGSize(width: 250, height: 30)
        case UICollectionElementKindSectionFooter:
            return CGSize(width: 250, height: 40)
        default:
            return CGSize(width: 250, height: 40)
        }
       
   }
   
   func tagLayout(_ layout: LZTagLayout, collectionView: UICollectionView, textForItemAt indexPath: IndexPath) -> String {
       return self.titles[indexPath.row]
   }

}

```


参考 https://www.jianshu.com/p/47f320732e87