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

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var historyTableview: UITableView!
    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController<AppLogins>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataController = EMClient.sharedInstance().dataController
        setUpFetchedResultsController()
    }
    //MARK: fetched results controller
    func setUpFetchedResultsController() {
        let fetchRequest:NSFetchRequest<AppLogins> = AppLogins.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "loginDate", ascending: false)
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

//MARK: Tableview delegate
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fetchedResultsController.sections?[section].numberOfObjects != nil {
            return (fetchedResultsController.fetchedObjects?.count)!
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = historyTableview.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        let loginDate = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = String(describing: loginDate.loginDate!)
        
        return cell
    }
}

//MARK: Fetch Results Controller Delegate
extension HistoryViewController:NSFetchedResultsControllerDelegate {
    
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
