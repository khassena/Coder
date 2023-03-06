//
//  SortPresenter.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 10.01.2023.
//

import UIKit

protocol SortViewProtocol: UIViewControllerTransitioningDelegate {
    var sortVC: SortViewController? { get set }
    func sortBy(_ button: SortModel)
}

protocol SortViewPresenterProtocol: AnyObject {
    func didTapSortButton(_ button: SortModel)
    var staff: Staff? { get set }
}

class SortPresenter: SortViewPresenterProtocol {
    var staff: Staff?
    weak var view: SortViewProtocol?
    var sortVC: SortViewController?
    
    init(view: SortViewProtocol, router: RouterProtocol, sortVC: SortViewController) {
        self.view = view
        self.sortVC = sortVC
    }
    
    func didTapSortButton(_ button: SortModel) {
        view?.sortBy(button)
    }
}

