//
//  SortPresenter.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 10.01.2023.
//

import Foundation

protocol SortViewProtocol: AnyObject {
    func sortBy(_ button: SortModel)
}

protocol SortViewPresenterProtocol: AnyObject {
    func didTapSortButton(_ button: SortModel)
    var staff: Staff? { get set } 
}

class SortPresenter: SortViewPresenterProtocol {
    var staff: Staff?
    weak var view: SortViewProtocol?
    
    init(view: SortViewProtocol) {
        self.view = view
    }
    
    func didTapSortButton(_ button: SortModel) {
        view?.sortBy(button)
    }
}
