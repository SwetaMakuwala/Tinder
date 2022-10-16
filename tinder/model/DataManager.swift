//
//  DataManager.swift
//  tinder
//
//  Created by sweta makuwala on 09/12/21.
//

import Foundation
protocol DataManagerDelegate {
    func passedInfo(dataModel: DataModel) 
}
class DataManager {
    let urlString = "https://randomuser.me/api/?results=50#"
    var dataModel = DataModel(name: [], address: [], dob: [], picture: [])
    var delegate: DataManagerDelegate?
  //  var array = [DataJSON]()
    var nameArray = [String]()
    var addressArray = [String]()
    var dobArray = [String]()
    var pictureArray = [String]()
    func fetchRequest(){
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String){
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    print("error is \(error!)")
                    return
                }
                if let safeData = data {
                    if let info = self.parseJSON(PassData: safeData){
                        self.delegate?.passedInfo(dataModel: info)
                  
                    }
                }
            }
            
            task.resume()
        }
    }
    func parseJSON(PassData: Data) -> DataModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(DataJSON.self, from: PassData)
            for i in decodedData.results{
                nameArray.append(i.name.title + " " + i.name.first + " " + i.name.last)
                addressArray.append( i.location.city + " " +  i.location.state + " " +  i.location.country)
                dobArray.append("Date:\(i.dob.date) \n Age:\(i.dob.age)")
                pictureArray.append(i.picture.medium)
            }
            return dataModel
        }catch {
            print(error)
            return nil
        }
    }
}
