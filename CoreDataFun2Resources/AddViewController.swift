//
//  AddViewController.swift
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

class AddViewController: SImagePickerViewController {
    
    // MARK: - Navigator
    
    // MARK: - Dependencies
    
    // MARK: - Delegates
    
    // MARK: - Properties
    
    var managedContext: NSManagedObjectContext!

    
    var dificulties = [1, 2, 3, 4, 5]
    
    // MARK: - Buckets
    
    // MARK: - Navigation items
    
    lazy var saveBarButtonItem = UIBarButtonItem(title: "Save", style: .done) {
        guard let title = self.titleTextField.object.text, let image = self.imageView.image else { return }
        let difficulty = self.dificulties[self.difficultyPicker.selectedRow(inComponent: 0)]
        
        self.saveTask(title: title, difficulty: difficulty, image: image) { (result) in
            switch result {
            case .success(let finished):
                if finished {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(let err):
                Alert.showErrorSomethingWentWrong()
            }
        }
    }
    
    // MARK: - Views
    
    let titleTextField = STextField().placeholder("Add title...")
    
    let imageView = UIImageView()
        .contentMode(.scaleAspectFill)
        .masksToBounds()
        .height(200)
        .background(color: .systemGray5)
    
    lazy var difficultyPicker = UIPickerView().delegate(self).select(2)
    
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
        
        title = "Add Task"
        navigationItem.setRightBarButton(saveBarButtonItem, animated: false)
    }
    
    override func configureViews() {
        super.configureViews()
    }
    
    // MARK: - Layout
    
    override func layoutViews() {
        super.layoutViews()
        
        stack(.vertical)(
            titleTextField.insetting(by: 12),
            imageView,
            difficultyPicker,
            Spacer()
            ).fillingParent().layout(in: container)
    }
    
    // MARK: - Interaction
    
    override func addActions() {
        super.addActions()
        
        imageView.addAction {
            self.showChooseImageSourceTypeAlertController()
        }
    }
    
    override func subscribe() {
        super.subscribe()
        
        imagePickerControllerImage.content.subscribe(with: self) { (image) in
            self.imageView.image = image
        }
    }
    
    // MARK: - internal
    
    // MARK: - private
    
    // MARK: - fileprivate
    
    // MARK: - public
    
    // MARK: - open
    
    // MARK: - @objc Selectors
    
}

// MARK: - Delegates

extension AddViewController: UIPickerViewDelegate {
    
}

// MARK: - Datasources

extension AddViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dificulties.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(dificulties[row])"
    }
    
}

// MARK: - Extensions

extension AddViewController {
    func saveTask(title: String, difficulty: Int, image: UIImage, id: UUID = UUID(), createdAt: Date = Date(), completed: Bool = false, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext) else {
            return
        }
        
        let task = Task(entity: entity, insertInto: managedContext)
        
        task.title = title
        task.difficulty = Int64(difficulty)
        task.imageData = image.pngData()
        task.id = id
        task.createdAT = createdAt
        task.completed = completed
        
        switch difficulty {
        case 1:
            task.color = UIColor.systemRed
        case 2:
            task.color = UIColor.systemOrange
        case 3:
            task.color = UIColor.systemYellow
        case 4:
            task.color = UIColor.systemTeal
        case 5:
            task.color = UIColor.systemBlue
        default:
            return
        }
        
        do {
            try managedContext.save()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
        
    }
}
