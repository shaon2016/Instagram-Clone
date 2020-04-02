//
//  TabBarDelegate.swift
//  InstagramApp
//
//  Created by Gwinyai on 25/10/2018.
//  Copyright © 2018 Gwinyai Nyatsoka. All rights reserved.
//

import Foundation

import UIKit

class TabBarDelegate: NSObject, UITabBarControllerDelegate {
    
    // Called everytime we select a new view controller
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let navigationController = viewController as? UINavigationController
        
        _ = navigationController?.popViewController(animated: false)
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let selectedViewController = tabBarController.selectedViewController
        
        guard let _selectedViewController = selectedViewController else {
            
            return false
            
        }
        
        // if we are in the page where we are in currently
        // We don't want to do anything in the current page
        // We want to go on another page. So return false means do nothing
        if viewController == _selectedViewController {
            
            return false
            
        }
        
        // Currently where we want to go to
        guard let controllerIndex = tabBarController.viewControllers?.index(of: viewController) else {
            
            return true
            
        }
        
        // 2 index for newpost vc
        if controllerIndex == 2 {
            
            let newPostStoryboard = UIStoryboard(name: "NewPost", bundle: nil)
            
            let newPostVC = newPostStoryboard.instantiateViewController(withIdentifier: "NewPostVC") as! NewPostVC
            
            let navController = UINavigationController(rootViewController: newPostVC)
            
            _selectedViewController.present(navController, animated: true, completion: nil)
            
            // Here returning false means
            // We are canceling tab bar default behavior
            // it helps to start the vc with the help of present (selectedViewController.present)
            return false
            
        }
        
        let navigationController = viewController as? UINavigationController
        
        _ = navigationController?.popToRootViewController(animated: false)
        
        return true
        
    }
    
    
}
