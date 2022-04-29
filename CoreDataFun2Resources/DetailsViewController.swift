//
//  DetailsViewController.swift
//  CoreDataDemo2
//
//  Created by Alex Nagy on 15/07/2020.
//  Copyright © 2020 Alex Nagy. All rights reserved.
//

import UIKit
import SparkUI
import Layoutless

import CoreData

// MARK: - Protocols

class DetailsViewController: SViewController {
    
    // MARK: - Navigator
    
    // MARK: - Dependencies
    
    var todo: String!
    
    // MARK: - Delegates
    
    // MARK: - Properties
    
    var managedContext: NSManagedObjectContext!
    
    // MARK: - Buckets
    
    // MARK: - Navigation items
    
    lazy var doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done) {
        
    }
    
    // MARK: - Views
    
    let imageView = UIImageView()
        .contentMode(.scaleAspectFill)
        .masksToBounds()
        .height(200)
        .background(color: .systemGray5)
    
    // MARK: - init - deinit
    
    // MARK: - Lifecycle
    
    override func preLoad() {
        super.preLoad()
    }
    
    override func onLoad() {
        super.onLoad()
    }
    
    override func onAppear() {
        super.onAppear()
    }
    
    override func onDisappear() {
        super.onDisappear()
    }
    
    // MARK: - Configure
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        
        title = todo
        
        navigationItem.setRightBarButton(doneBarButtonItem, animated: false)
    }
    
    override func configureViews() {
        super.configureViews()
        
    }
    
    // MARK: - Layout
    
    override func layoutViews() {
        super.layoutViews()
        
        stack(.vertical)(
            imageView
            ).fillingParent().layout(in: container)
    }
    
    // MARK: - Interaction
    
    override func addActions() {
        super.addActions()
    }
    
    override func subscribe() {
        super.subscribe()
    }
    
    // MARK: - internal
    
    // MARK: - private
    
    // MARK: - fileprivate
    
    // MARK: - public
    
    // MARK: - open
    
    // MARK: - @objc Selectors
    
}

// MARK: - Delegates

// MARK: - Datasources

// MARK: - Extensions

