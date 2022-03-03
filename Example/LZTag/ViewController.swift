//
//  ViewController.swift
//  LZTag
//
//  Created by lizhi0123 on 03/02/2022.
//  Copyright (c) 2022 lizhi0123. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LZTag标签选择器"
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "基本使用"
        case 1:
            cell.textLabel?.text = "圆角使用"
        case 2:
            cell.textLabel?.text = "拓展使用"
        default:
            cell.textLabel?.text = "test"
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var controller = UIViewController()
        switch indexPath.row {
        case 0:
            controller = BasicViewController()
        case 1:
            controller = RoundViewController()
        case 2:
            controller = ExpandViewController()
        default:
            break
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
