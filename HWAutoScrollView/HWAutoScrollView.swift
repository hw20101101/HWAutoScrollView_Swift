//
//  HWAutoScrollView.swift
//  AutoScrollViewDemo
//
//  Created by hwacdx on 16/9/7.
//  Copyright © 2016年 hwacdx. All rights reserved.
//

import UIKit

class HWAutoScrollView: UIView, UIScrollViewDelegate {
    
    let pageControlHeight: CGFloat = 20
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var timer: Timer!
    
    var statusArray = [String](){
        didSet {
            let scrollViewWidth: CGFloat = scrollView.frame.size.width
            let scrollViewHeight:CGFloat = scrollView.frame.size.height
            
            for i in 0...statusArray.count - 1 {
                
                let button: UIButton = UIButton()
                button.tag = i
                button.frame = CGRect.init(x: CGFloat(i) * scrollViewWidth, y: 0, width: scrollViewWidth, height: scrollViewHeight)
                button.setImage(UIImage.init(named: statusArray[i]), for: UIControlState())
                button.addTarget(self, action: #selector(buttonOnClick(_:)), for: .touchUpInside)
                button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
                self.scrollView.addSubview(button)
            }
            
            scrollView.contentSize = CGSize.init(width: scrollViewWidth * CGFloat(statusArray.count), height: 0)
            pageControl.numberOfPages = statusArray.count
        }
    }
    
    func buttonOnClick(_ button: UIButton) {
        print("点击了第\(button.tag + 1)张图片")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupScrollView()
        setupPageControl()
        startTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScrollView() {
        scrollView = UIScrollView.init(frame: CGRect(origin: CGPoint.zero, size: self.frame.size))
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
    }
    
    func setupPageControl() {
        pageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: scrollView.frame.size.height - pageControlHeight, width: scrollView.frame.size.width, height: pageControlHeight))
        pageControl.currentPage = 0
        pageControl.center = CGPoint.init(x: self.center.x, y: pageControl.center.y)
        pageControl.pageIndicatorTintColor = UIColor.red
        pageControl.currentPageIndicatorTintColor = UIColor.green
        self.addSubview(pageControl)
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(nextPage(_:)), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    func stopTimer() {
        timer.invalidate()
        timer = nil
    }
    
    func nextPage(_ timer: Timer) {
        var index = pageControl.currentPage + 1
        
        if index == statusArray.count {
            index = 0
        }
        
        let offset: CGPoint = CGPoint.init(x: scrollView.frame.size.width * CGFloat(index), y: 0)
        scrollView.setContentOffset(offset, animated: true)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
