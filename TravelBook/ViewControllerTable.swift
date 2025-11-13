//
//  ViewControllerTable.swift
//  TravelBook
//
//  Created by Zeynep Betül Kaya on 13.11.2025.
//

import UIKit

class ViewControllerTable: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var list: UITableView!
    var titlePlace = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list.delegate = self
        list.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlePlace.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = titlePlace[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
}
