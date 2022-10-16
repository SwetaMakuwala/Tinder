//
//  TableTableViewController.swift
//  tinder
//
//  Created by sweta makuwala on 09/12/21.
//

import UIKit
import CoreData
protocol DeleteFavPerson{
    func deleteFavPresonFromcell(person: Person)
}
class TableViewController: UITableViewController{
  
    var delegate: DeleteFavPerson!
    var row = 0
    var dataManager = DataManager()
    var nameArray = [String]()
    var addressArray = [String]()
    var dobArray = [String]()
    var pictureArray = [String]()
    let sortTableVC = SortTableViewController()
    let context = PersistenceStorage.shared.context
 static var personArray = [Person]()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.fetchRequest()
        getAllItems()
        tableView.reloadData()
        print(TableViewController.personArray.count)
       
       
    }
   
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
          return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        // Configure the cell...
        cell.delegate = self
        cell.indexPath = indexPath
        cell.row = indexPath.row
        cell.nameLabel.text = nameArray[indexPath.row]
        cell.nameArrayNew.append(nameArray[indexPath.row])
// load images from web
//        let imageUrl = URL(string: pictureArray[indexPath.row])!
//        let imageData = try? Data(contentsOf: imageUrl)
//
//        cell.imageDisplay.image = UIImage(data: imageData! )
        
//        if let url = URL(string: pictureArray[indexPath.row]){
//            let task = URLSession.shared.dataTask(with: url) { data, response , error in
//                guard let data = data , error == nil else { return}
//                DispatchQueue.main.async {
//                    cell.imageDisplay.image = UIImage(data: data)
//                }
//            }
//            task.resume()
//        }
        if let url = URL(string: pictureArray[indexPath.row]) {
            print(pictureArray[indexPath.row])
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let data = data , error == nil {
                    DispatchQueue.main.async {
                       
                        cell.imageDisplay.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
        return cell
    }
    
    

  }
// MARK: - cell delegate
extension TableViewController : CellDelegate{
    func personButtonTapped(at index: Int) {
        createAnAlert(title: "Person's Info:", message: nameArray[index])
    }
    func calenderButtonTapped(at index: Int) {
        createAnAlert(title: "Date of Birth and Age Info:", message: dobArray[index])
        
    }
    func locationButtonTapped(at index: Int) {
        createAnAlert(title: "Address Info: ", message: addressArray[index])
    }
    
    
    func addFav(at row: Int) {
        createFavourite(name: nameArray[row], dob: dobArray[row], address: addressArray[row], picture: pictureArray[row])
    }
    func removeFavFromCell(person: Person){
        deleteFavPresonFromcell(person: person)
 
      }
    func createAnAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK: - CoreData
extension TableViewController {
  
    func getAllItems() {
        do {
            TableViewController.personArray = try context.fetch(Person.fetchRequest())
        } catch {
            print(error)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
   
    }
    func createFavourite(name: String, dob: String, address: String, picture: String) {
        let newPerson = Person(context: context)
        newPerson.name = name
        newPerson.dob = dob
        newPerson.address = address
        newPerson.picture = picture
       print(newPerson)
 
        do {
            try context.save()
            getAllItems()
        }catch {
            print(error)
        }
    }
   func deleteFavPresonFromcell(person: Person) {
    print("///\(person)////")
        context.delete(person)
    tableView.reloadData()
    
        do {
            try context.save()
            getAllItems()
        } catch{
            print("delete error: \(error)")
        }
    }
 
    func deleteFavPerson(name:String)
    {
        let context = PersistenceStorage.shared.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Person")
        fetchRequest.predicate = NSPredicate(format: "name = %@", "\(name)")
        do
        {
            let fetchedResults =  try context.fetch(fetchRequest) as? [NSManagedObject]
            for entity in fetchedResults! {
                context.delete(entity)
                getAllItems()
            }
        }
        catch _ {
            print("Could not delete")
        }
    }
    
}
