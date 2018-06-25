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
        print(dataController.viewContext.hasChanges)
        setUpFetchedResultsController()
        self.navigationItem.title = "Login History"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpFetchedResultsController()
        performUIUpdatesOnMain {
            self.historyTableview.reloadData()
        }
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
    }
    
    //MARK: fetched results controller
    func setUpFetchedResultsController() {
        let fetchRequest:NSFetchRequest<AppLogins> = AppLogins.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "loginDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "AppLogins")
        
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
        return fetchedResultsController.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects!.count 
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = historyTableview.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        let loginDate = fetchedResultsController.object(at: indexPath)
        let date = DateFormatter()
        date.dateStyle = .full

        cell.textLabel?.text = loginDate.success
        cell.detailTextLabel?.text = String(describing: loginDate.loginDate!)
        
        return cell
    }
}

