//
//  SearchViewController.swift
//  Cards
//
//  Created by Marek Fořt on 9/7/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import UIKit
import ReactiveSwift

class SearchViewController: PreviewCoursesViewController, UISearchResultsUpdating, UISearchControllerDelegate {
    
    let viewModel = SearchViewModel()
    
    var controller: UINavigationController?
    var searchController: UISearchController?
    
    var lastSearchText: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateSettingImage = true
        
        setCollectionView()
        
        isExecuting.value = false
        loadingImageView.isHidden = true
        
        setupBindings()
        
    }
    
    private func setupBindings() {
        
        viewModel.courses.producer.observe(on: UIScheduler()).startWithValues { [weak self] courses in
            self?.previews = courses
            self?.coursesCollectionView?.reloadData()
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let courseViewController = createCourseViewController(indexPath: indexPath)
        controller?.pushViewController(courseViewController, animated: true)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,
        lastSearchText != searchText else {return}
        
        lastSearchText = searchText
        if searchText.isEmpty {
            viewModel.courses.value = []
        }
        else {
            viewModel.searchCourses(searchText: searchText).start()
        }
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController?.searchBar.endEditing(true)
    }
    
    
    
}

