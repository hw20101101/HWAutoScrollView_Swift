//
//  ViewController.swift
//  AutoScrollViewDemo
//
//  Created by hwacdx on 16/9/7.
//  Copyright © 2016年 hwacdx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pageView: HWAutoScrollView!
    let pageViewHeight: CGFloat = 200
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupPageView()
    }

    func setupPageView() {
        pageView = HWAutoScrollView.init(frame: CGRect(origin: CGPoint.zero, size: CGSize.init(width: self.view.frame.size.width, height: pageViewHeight)))
        pageView.statusArray = ["001", "002", "003"];
        self.view.addSubview(pageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

