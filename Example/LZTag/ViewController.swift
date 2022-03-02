//
//  ViewController.swift
//  LZTag
//
//  Created by lizhi0123 on 03/02/2022.
//  Copyright (c) 2022 lizhi0123. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let tagview = LZTagView(frame: CGRect(x: 10, y: 100, width: 350, height: 200))
        tagview.tagContentAlignment = .left
        tagview.backgroundColor = .yellow
        tagview.titles = ["左对齐1", "左对齐2", "左对齐3", "我是标题11", "对对我是标签选择器2", "对对我是标签选择器13", "我要居中显示24", "我5", "我是6", "我是标题11", "对对我是标签选择器2"]
        self.view.addSubview(tagview)

        let tagview2 = LZTagView(frame: CGRect(x: 10, y: 320, width: 350, height: 200))
        tagview2.tagContentAlignment = .center
        tagview2.backgroundColor = .yellow
        tagview2.titles = ["中间对齐1", "中间对齐2", "中间对齐3", "中间对齐4", "我是标题11", "对对我是标签选择器2", "对对我是标签选择器13", "我要居中显示24", "我5", "我是6", "我是标题11", "对对我是标签选择器2"]
        self.view.addSubview(tagview2)
        
        let tagview3 = LZTagView(frame: CGRect(x: 10, y: 530, width: 350, height: 200))
        tagview3.tagContentAlignment = .right
        tagview3.backgroundColor = .yellow
        tagview3.titles = ["右对齐1", "右对齐2", "右对齐3","我是标题11", "对对我是标签选择器2", "对对我是标签选择器13", "我要居中显示24", "我5", "我是6", "我是标题11", "对对我是标签选择器2"]
        self.view.addSubview(tagview3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
