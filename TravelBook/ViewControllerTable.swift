//
//  ViewControllerTable.swift
//  TravelBook
//
//  Created by Zeynep Betül Kaya on 13.11.2025.
//

import UIKit
import CoreData

class ViewControllerTable: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var list: UITableView!
    var titleArray = [String]()
    var idArray = [UUID]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list.delegate = self
        list.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addItem))
        
        getData()

    }
    
    func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            self.titleArray.removeAll(keepingCapacity: false)
            self.idArray.removeAll(keepingCapacity: false)
            for result in results as! [NSManagedObject] {
                if let title = result.value(forKey: "title") as? String {
                    titleArray.append(title)
                }
                if let id = result.value(forKey: "id") as? UUID {
                    idArray.append(id)
                }
                self.list.reloadData()
            }
            
        } catch {
            print("error")
        }
    }
    
    @objc func addItem() {
        performSegue(withIdentifier: "toDetails", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = titleArray[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
}
