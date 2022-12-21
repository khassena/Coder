//
//  SearchBar.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 01.12.2022.
//

import UIKit

class SearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
    
        setSearchFieldBackgroundImage(SearchBar.getBackImage(), for: .normal)
        
        searchTextField.leftView = Constants.SearchBar.magnifierGray
        searchTextField.layer.masksToBounds = true
        searchTextField.layer.cornerRadius = Constants.SearchBar.cornerRadius
        searchTextField.tintColor = Color.purple
        searchTextField.attributedPlaceholder = Constants.SearchBar.attributedString
        
        setPositionAdjustment(Constants.SearchBar.leftPositionAdjust, for: .search)
        setPositionAdjustment(Constants.SearchBar.rightPositionAdjust, for: .clear)
        setPositionAdjustment(Constants.SearchBar.rightPositionAdjust, for: .bookmark)
        searchTextPositionAdjustment = Constants.SearchBar.leftPositionAdjust
        
        showsBookmarkButton = true
        setImage(Constants.SearchBar.sortButtonNormal, for: .bookmark, state: .normal)
        setImage(Constants.SearchBar.sortButtonSelected, for: .bookmark, state: .selected)
        setImage(Constants.SearchBar.clear , for: .clear, state: .normal)
        
        showsCancelButton = true
        
        let barButtonAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        barButtonAppearance.setTitleTextAttributes(Constants.SearchBar.cancelAttributes, for: .normal)
    }

}

extension SearchBar {
    private static func getBackImage() -> UIImage {
        return UIGraphicsImageRenderer(size: Constants.SearchBar.size).image { rendererContext in
            Constants.SearchBar.backgroundColor.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: Constants.SearchBar.size))
        }
    }
}
