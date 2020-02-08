//
//  CitySearchViewController.swift
//  Weather
//
//  Created by Mehsam Saeed on 05/02/2020.
//  Copyright © 2020 Mehsam. All rights reserved.
//

import UIKit
import Reusable
class Singlton {
    static let shared=Singlton()
    var cityList = [City]()
    private init(){}
}
protocol ControllerDismissDelegate{
    func didDismissViewController(selectedCity:City)
}
class CitySearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var dismissVCDelegate:ControllerDismissDelegate?
    let searchController = UISearchController(searchResultsController: nil)
    var cityList = [City](){
        didSet{
            DispatchQueue.main.async {[weak self] in
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
            
        }
    }
    var filterdCityList = [City](){
        didSet{
            DispatchQueue.main.async {[weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    private func configureUI(){
        activityIndicator.startAnimating()
        tableView.dataSource = self
        tableView.delegate = self
        configureSearchController()
        loadCity()
    }
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.red
        tableView.register(cellType: SearchTableViewCell.self)
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    private func loadCity(){
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            self.getJasonFromFile(fileName: "cityList", fileType: "txt") { [weak self](cityList) in
                guard let self = self else {return}
                 self.cityList = cityList
            }
        }
    }
    func getJasonFromFile(fileName:String , fileType:String , handler:@escaping([City])->() ) {
        
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
                do {
                    guard Singlton.shared.cityList.count > 0 else {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let results = try JSONDecoder().decode([City].self, from:data)
                        Singlton.shared.cityList = results
                        handler(results)
                        return
                    }
                    handler(Singlton.shared.cityList)
                   
                } catch {
                    print(error)
                }
            }
        }

    }
    
    private func filterFootballers(for searchText: String) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {[weak self] in
            self?.filterdCityList = (self?.cityList.filter { city in
                return city.name.lowercased().contains(searchText.lowercased())
                })!
        }
      
    }


}
extension CitySearchViewController: UISearchResultsUpdating {
   func updateSearchResults(for searchController: UISearchController) {
    filterFootballers(for: searchController.searchBar.text ?? "")
  }
}
extension CitySearchViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filterdCityList.count
        }
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SearchTableViewCell
        let cellData:City
        if searchController.isActive && searchController.searchBar.text != "" {
          cellData =  filterdCityList[indexPath.row]
        } else {
          cellData = cityList[indexPath.row]
        }

        cell.cityListLabel.text = cellData.name
        return cell
    }
}
extension CitySearchViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData:City
        if searchController.isActive && searchController.searchBar.text != "" {
          cellData =  filterdCityList[indexPath.row]
        } else {
          cellData = cityList[indexPath.row]
        }
        dismissVCDelegate?.didDismissViewController(selectedCity: cellData)
        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
}
