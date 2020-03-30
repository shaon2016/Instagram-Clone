//
//  SearchBarContainerView.swift
//  InstagramApp
//
//  Created by MacBook Pro  on 26/3/20.
//  Copyright © 2020 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

class SearchBarContainerView: UIView {

    let searchBar : UISearchBar
    
    init(customSearchBar : UISearchBar) {
        searchBar = customSearchBar
        
        super.init(frame: CGRect.zero)
        
        addSubview(searchBar)
    }
    
    convenience override init(frame: CGRect) {
        self.init(customSearchBar: UISearchBar())
        
        self.frame = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Called every time when there is a change in the view
    override func layoutSubviews() {
        super.layoutSubviews()
        
        searchBar.frame = bounds
    }

}
