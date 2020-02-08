//
//  ViewController.swift
//  Weather
//
//  Created by Mehsam Saeed on 31/01/2020.
//  Copyright © 2020 Mehsam. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var citylabel: UILabel!
    let manager = NetworkManager.init()
    let locationManager = CLLocationManager()
    var currentCity:CordinateWeather!

    override func viewDidLoad() {
        super.viewDidLoad()
        configuireLocation()
    }

    @IBAction func buttonPressed(_ sender: Any) {
        
        setLabel(city: "", temp: 0)
        activityIndicator.startAnimating()
        guard currentCity != nil else{return}
        getWeatherOFCordinate(lat: currentCity.coord.lat, long: currentCity.coord.lon)
        
    }
    
    @IBAction func changeCityButtonTapped(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CitySearchViewController") as? CitySearchViewController{
            vc.dismissVCDelegate = self
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    private func getWeatherOFCordinate(lat:Double,long:Double){
        manager.getWeatherOfCordidate(lat: lat, long: long) { (weatherReport) in
            print(weatherReport)
            self.currentCity = weatherReport
            self.setLabel(city: weatherReport.name, temp: weatherReport.main.temp)
        }
    }
    private func getWeatherOFCity(cityID:Int){
        manager.getWeatherOfCity(cityID: cityID) { (cityWeather) in
            print(cityWeather)
            self.setLabel(city: cityWeather.name, temp: cityWeather.main.temp)
           
        }
    }
    private func setLabel(city:String,temp:Double){
        self.citylabel.text = city
        let temp2 = temp > 0 ? 273.0:0.0
        let temprature = Int(temp - temp2)
        self.tempratureLabel.text = String(temprature)
        activityIndicator.stopAnimating()
    }
    
    
    private func configuireLocation(){
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            
            locationManager.requestLocation()
            //locationManager.startUpdatingLocation()
        }
    }
    
    
}
extension ViewController:CLLocationManagerDelegate{
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        getWeatherOFCordinate(lat:locValue.latitude, long: locValue.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        // might be that user didn't enable location service on the device
        // or there might be no GPS signal inside a building
      
        // might be a good idea to show an alert to user to ask them to walk to a place with GPS signal
    }
}
extension ViewController:ControllerDismissDelegate {
    func didDismissViewController(selectedCity:City) {
        setLabel(city: "", temp: 0)
        activityIndicator.startAnimating()
        getWeatherOFCordinate(lat: Double(selectedCity.coord.lat), long: selectedCity.coord.lon)
        
    }
}
