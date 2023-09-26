//
//  BasicViewController.swift
//  LZTag_Example
//
//  Created by lizhi on 2022/3/2.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        let tagview = LZTagView(frame: CGRect(x: 10, y: 100, width: 350, height: 200))
        tagview.tagContentAlignment = .left
        tagview.backgroundColor = .yellow
        tagview.titles = ["左对齐1", "左对齐2", "左对齐3", "我是标题11", "对对我是标签选择器2", "对对我是标签选择器13", "我要居中显示24", "我5", "我是6", "我是标题11", "对对我是标签选择器2"]
        self.view.addSubview(tagview)

        let tagview2 = LZTagView(frame: CGRect(x: 10, y: 320, width: 350, height: 200))
        tagview2.tagContentAlignment = .center
        tagview2.backgroundColor = .yellow
        tagview2.titles = ["左对齐1", "左对齐2", "左对齐3", "我是标题11", "对对我是标签选择器2", "对对我是标签选择器13", "我要居中显示24", "我5", "我是6", "我是标题11", "对对我是标签选择器2"]
        self.view.addSubview(tagview2)

        let tagview3 = LZTagView(frame: CGRect(x: 10, y: 530, width: 350, height: 200))
        tagview3.tagContentAlignment = .right
        tagview3.backgroundColor = .yellow
        tagview3.titles = ["左对齐1", "左对齐2", "左对齐3", "我是标题11", "对对我是标签选择器2", "对对我是标签选择器13", "我要居中显示24", "我5", "我是6", "我是标题11", "对对我是标签选择器2"]
        self.view.addSubview(tagview3)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
