//
//  ViewController.swift
//  Recycling_Finder
//
//  Created by Muharrem Köroğlu on 10.10.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var typeNameArray = [String]()
    var idArray = [UUID]()
    
    var selectedType = ""
    var selectedId : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButton))
        
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = typeNameArray[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedType = typeNameArray[indexPath.row]
        selectedId = idArray[indexPath.row]
        performSegue(withIdentifier: "toAddVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddVC" {
            let destination = segue.destination as! AddViewController
            destination.selectedType = selectedType
            destination.selectedId = selectedId
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DataSource")
        fetchRequest.returnsObjectsAsFaults = false
        let idString = idArray[indexPath.row].uuidString
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    if let id = result.value(forKey: "id") as? UUID {
                        if id == idArray[indexPath.row] {
                            context.delete(result)
                            typeNameArray.remove(at: indexPath.row)
                            idArray.remove(at: indexPath.row)
                            self.tableView.reloadData()
                            do{
                                try context.save()
                            }catch{
                                print("Error!")
                            }
                        }
                    }
                    break
                }
            }
        }catch{
            print("Error!")
        }
    }

    @objc func addButton () {
        selectedType = ""
        performSegue(withIdentifier: "toAddVC", sender: nil)
    }
    
    @objc func fetchData () {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DataSource")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                
                self.typeNameArray.removeAll()
                self.idArray.removeAll()
                
                for result in results as! [NSManagedObject]{
                 
                    if let type = result.value(forKey: "type") as? String {
                        self.typeNameArray.append(type)
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    self.tableView.reloadData()
                }

            }
        }catch{
            print("Error")
        }
    }
}

