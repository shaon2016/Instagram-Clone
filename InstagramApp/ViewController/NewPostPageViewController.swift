//
//  NewPostPageViewController.swift
//  InstagramApp
//
//  Created by MacBook Pro  on 30/3/20.
//  Copyright © 2020 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

class NewPostPageViewController: UIPageViewController , UIPageViewControllerDelegate{
    
    var orderedViewControllers = [UIViewController]()
    
    var pagesToShow = NewPostPagesToShow.pagesToShow()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        for pageToShow in pagesToShow {
            let page = newVC(pageToShow: pageToShow)
            orderedViewControllers.append(page)
        }
        
        if let firstVC = orderedViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(newPage(notification:)), name: NSNotification.Name("newPage"), object: nil)
    }
    
    @objc func newPage(notification : NSNotification) {
        if let receivedObj = notification.object as? NewPostPagesToShow {
            // raw value will send 0, 1 as enum type is int
            showVC(index: receivedObj.rawValue)
        }
    }
    
    
    // Instantitate  new vc for page
    private func newVC(pageToShow : NewPostPagesToShow) -> UIViewController {
        var vc : UIViewController
        
        let newPostStoryboard = UIStoryboard(name: "NewPost", bundle: nil)
        
        switch pageToShow {
        case .camera:
            vc = newPostStoryboard.instantiateViewController(withIdentifier: pageToShow.identifier) as! CameraVC
        case .library:
            vc = newPostStoryboard.instantiateViewController(withIdentifier: pageToShow.identifier) as! PhotoLibraryVC
        }
        
        return vc
    }
    
    // Show vc to page
    func showVC(index : Int)  {
        if currentIndex > index {
            setViewControllers([orderedViewControllers[index]], direction: .reverse, animated: true, completion: nil)
        } else if currentIndex < index {
            setViewControllers([orderedViewControllers[index]], direction: .forward, animated: true, completion: nil)
        }
        
        currentIndex = index
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("newPage"), object: nil )
    }
    
}


extension NewPostPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // current live index of the vc we are in at this moment
        guard let vcIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let prevIndex = vcIndex - 1
        
        //        // check we are in first index or not
        //        guard prevIndex >= 0 else {
        //            return nil
        //        }
        if prevIndex <= 0 {
            return nil
        }
        
        return orderedViewControllers[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // current live index of the vc we are in at this moment
        guard let vcIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = vcIndex + 1
        
        let lastVCIndex = orderedViewControllers.count
        
        guard lastVCIndex != nextIndex else {
            return nil
        }
        
        guard lastVCIndex > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}
