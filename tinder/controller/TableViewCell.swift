//
//  TableViewCell.swift
//  tinder
//
//  Created by sweta makuwala on 09/12/21.
//

import UIKit
protocol CellDelegate{
    func personButtonTapped(at index:Int)
    func calenderButtonTapped(at index: Int)
    func locationButtonTapped(at index: Int)
    func addFav(at index: Int)
    func removeFavFromCell(person: Person)
    func deleteFavPerson(name:String)
}
protocol deleteDelegate {
    func deleteFavPresonFromcell(person: Person)
}
class TableViewCell: UITableViewCell {
    var delegate : CellDelegate!
    var deleteFavPersonDelegate: deleteDelegate!
    var indexPath:IndexPath!
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var personButton: UIButton!
    @IBOutlet weak var calenderButton: UIButton!
    var row = Int()
    let datamanager = DataManager()
    var tableVC = TableViewController()
    var addressArray = [String]()
    var dobArray = [String]()
    var nameArrayNew = [String]()
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func personButtonpressed(_ sender: UIButton) {
        self.delegate.personButtonTapped(at: row)
    }
    
    @IBAction func calenderButtonPressed(_ sender: UIButton) {
        self.delegate.calenderButtonTapped(at: row)
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        self.delegate.locationButtonTapped(at: row)
    }
    var buttonSwitched : Bool = false
    
    @IBAction func favButtonPressed(_ sender: UIButton) {
        self.buttonSwitched = !self.buttonSwitched

            if self.buttonSwitched
            {
                self.delegate.addFav(at: row)
                favButton.setImage(#imageLiteral(resourceName: "heavy-black-heart_2764.png"), for: .normal)
            }
            else
            {
                favButton.setImage(#imageLiteral(resourceName: "img_309380"), for: .normal)
                let name = nameArrayNew[row]
                self.delegate.deleteFavPerson(name:name)
            }
    }
    
}
