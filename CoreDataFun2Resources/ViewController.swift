//
//  ViewController.swift
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

class ViewController: SViewController {
    
    // MARK: - Navigator
    
    // MARK: - Dependencies
    
    // MARK: - Delegates
    
    // MARK: - Properties
    
        
//    var tasks: [Task] = []
    
    var managedContext: NSManagedObjectContext!
    
    // MARK: - Buckets
    
    // MARK: - Navigation items
    
    lazy var addBarButtonItem = UIBarButtonItem(title: "Add", style: .done) {
        let textField = UITextField()

        let controller = AddViewController()
        controller.managedContext = self.managedContext
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    // MARK: - Views
    
    lazy var flowLayout = FlowLayout()
        .item(width: self.view.frame.width, height: 60)
    lazy var collectionView = CollectionView(with: flowLayout, delegateAndDataSource: self)
        .registerCell(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
    
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
        fetch()
    }
    
    override func onDisappear() {
        super.onDisappear()
    }
    
    // MARK: - Configure
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        
        title = "To-do List"
        navigationItem.setRightBarButton(addBarButtonItem, animated: true)
    }
    
    override func configureViews() {
        super.configureViews()
    }
    
    // MARK: - Layout
    
    override func layoutViews() {
        super.layoutViews()
        
        stack(.vertical)(
            collectionView
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
    
    fileprivate func fetch() {
        fetchTasks { (result) in
            switch result {
                
            case .success(let tasks):
                Service.tasks = tasks
                self.collectionView.reloadData()
            case .failure(let err):
                Alert.showError(message: err.localizedDescription)
            }
        }
    }
    
    // MARK: - public
    
    // MARK: - open
    
    // MARK: - @objc Selectors
    
}

// MARK: - Delegates

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}

// MARK: - Datasources

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Service.tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        let task = Service.tasks[indexPath.row]
        cell.setup(with: task, at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailsViewController()
//        controller.todo = todos[indexPath.row]
        controller.task = Service.tasks[indexPath.row]
        controller.managedContext = self.managedContext
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

// MARK: - Extensions

extension ViewController {
    func fetchTasks(completion: @escaping (Result<[Task], Error>) -> ()) {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", argumentArray: [#keyPath(Task.completed), false])
        
        do {
            let tasks = try managedContext.fetch(request)
            completion(.success(tasks))
        } catch {
            completion(.failure(error))
        }
    }
}
