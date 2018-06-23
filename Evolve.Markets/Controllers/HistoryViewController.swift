//
//  UserSettingsViewController.swift
//  Evolve.Markets
//
//  Created by atao1 on 6/22/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UserSettingsViewController: UIViewController {
    
    @IBOutlet weak var historyTableview: UITableView!
    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController<AppLogins>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFetchedResultsController()
    }
    
    func setUpFetchedResultsController() {
        func setUpFetchedResultsController() {
            let fetchRequest:NSFetchRequest<AppLogins> = AppLogins.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "applogins")
            fetchedResultsController.delegate = self
            do {
                try fetchedResultsController.performFetch()
            } catch{
                fatalError("The Fetch Could Not Be Performed: \(error.localizedDescription)")
            }
        }
    
    }
}
extension UserSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (fetchedResultsController.sections?[section].numberOfObjects)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = historyTableview.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        let loginDate = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = String(describing: loginDate.loginDate)
        
        return cell
    }
}
    

//MARK: Fetch Results Controller Delegate
extension UserSettingsViewController:NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            return
        case .delete:
            return
        default:
            break
        }
    }
}
