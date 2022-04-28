//
//  ViewController.swift
//  ToDoList
//
//  Created by Vinícius Flores Ribeiro on 28/04/22.
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
    
    var todos: [String] = []
    
//    var tasks: [NSManagedObject] = []
    
    // MARK: - Buckets
    
    // MARK: - Navigation items
    
    lazy var addBarButtonItem = UIBarButtonItem(title: "Add", style: .done) {
        
        let textField = UITextField()
        Alert.show(.alert, title: "Add a task", message: nil, textFields: [textField]) { (texts) in
            guard let texts = texts, let text = texts.first else {return}
            self.todos.append(text)
            self.collectionView.reloadData()
        }
        
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
        fetch()
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
//        fetchTasks { (result) in
//            switch result {
//            case .success(let managedObjects):
//                self.tasks = managedObjects
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
//                self.collectionView.reloadDataOnMainThread()
//            case .failure(let err):
////                Alert.showError(message: err.localizedDescription)
//            }
//        }
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
        todos.count
//        tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
//        let task = tasks[indexPath.row]
//        let taskTitle = task.value(forKey: "title") as? String ?? "N/A"
        cell.setup(with: todos[indexPath.row], at: indexPath)
//        cell.setup(with: taskTitle, at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

// MARK: - Extensions

extension ViewController {
    func saveTask(with title: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(.failure(CoreDataError.noAppDelegate))
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        let task = NSManagedObject(entity: entity, insertInto: managedContext)
        task.setValue(title, forKey: "title")
        
        do {
            try managedContext.save()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchTasks(completion: @escaping (Result<[NSManagedObject], Error>) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(.failure(CoreDataError.noAppDelegate))
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }
}
