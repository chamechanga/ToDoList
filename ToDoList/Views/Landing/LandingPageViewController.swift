//
//  LandingPageViewController.swift
//  ToDoList
//
//  Created by Indra on 3/14/23.
//

import UIKit
import CoreLocation

class LandingPageViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var hourlyTemperatureCollectionView: UICollectionView!
    
    let networkManager = NetworkManager()
    let locationManager = CLLocationManager()
    
    var timer: Timer?
    var hourlyTemp: [Double] = []
    var time: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "User", style: .plain, target: self, action: #selector(changeUser))
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        self.getHourlyTemperature()
        self.setupCollectionView()
    }
    
    @objc
    func tick() {
        dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
    }
    
    @objc
    func changeUser() {
        let alert = UIAlertController(title: "Change Users",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { _ in
            
        }))
        alert.addAction(UIAlertAction(title: "Sign up", style: .default, handler: { _ in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.navigationController?.present(alert, animated: true)
    }
    
    @IBAction func redirectTodoPage(_ sender: UIButton) {
        let viewController = ToDoViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupCollectionView() {
        hourlyTemperatureCollectionView.dataSource = self
        
        let nib = UINib(nibName: "HourlyTempCollectionViewCell", bundle: nil)
        hourlyTemperatureCollectionView.register(nib, forCellWithReuseIdentifier: "hourlyTempCell")
    }
    
    func getHourlyTemperature() {
        let networkManager = NetworkManager()
        let coordinates = getLocationCoordinate()
        
        guard
            let latitude = coordinates.latitude,
            let longitude = coordinates.longitude
        else {
            return
        }
        
        networkManager.getForecast(latitude: latitude, longitude: longitude) { [unowned self] result, error in
            self.hourlyTemp = result?.hourly.temperature2M ?? []
            self.time = result?.hourly.time ?? []
            self.hourlyTemperatureCollectionView.reloadData()
        }
        
    }
    
    private func getLocationCoordinate() -> (latitude: Double?, longitude: Double?) {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
            let currentCoordinate = locationManager.location?.coordinate
            return (currentCoordinate?.latitude, currentCoordinate?.longitude)
        }
        
        return (nil, nil)
    }
}

extension LandingPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyTemp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyTempCell", for: indexPath) as! HourlyTempCollectionViewCell
        cell.set(time: String(time[indexPath.row]), temperature: String(hourlyTemp[indexPath.row]))
        return cell
    }
}
