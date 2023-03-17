//
//  LandingPageViewController.swift
//  ToDoList
//
//  Created by Indra on 3/14/23.
//

import ReSwift

class LandingPageViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var hourlyTemperatureCollectionView: UICollectionView!
    @IBOutlet weak var currentUserLabel: UILabel!
    @IBOutlet weak var todoButton: UIButton!
    
    var timer: Timer?
    var hourlyTemp: [Double] = []
    var time: [String] = []
    var users: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.dispatch(getLocationCoordinate(state:store:))
        store.dispatch(GetUsersAction())
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.dispatch(RoutingAction(destination: .landing))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        store.subscribe(self) {
            $0.select {
                (
                    $0.locationState,
                    $0.usersState,
                    $0.currentUserState
                )
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    func setupView() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Change User", style: .plain, target: self, action: #selector(changeUser))
        self.navigationItem.hidesBackButton = true
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        
        hourlyTemperatureCollectionView.layer.cornerRadius = 10.0
        hourlyTemperatureCollectionView.backgroundColor = .lightGray.withAlphaComponent(0.5)
        hourlyTemperatureCollectionView.dataSource = self
        hourlyTemperatureCollectionView.delegate = self
        
        let nib = UINib(nibName: "HourlyTempCollectionViewCell", bundle: nil)
        hourlyTemperatureCollectionView.register(nib, forCellWithReuseIdentifier: "hourlyTempCell")
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
        self.users.forEach { username in
            alert.addAction(UIAlertAction(title: username, style: .default, handler: { _ in
                store.dispatch(ChangeCurrentUserAction(username: username))
            }))
        }
        alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { _ in
            store.dispatch(RoutingAction(destination: .login))
        }))
        alert.addAction(UIAlertAction(title: "Sign up", style: .default, handler: { _ in
            store.dispatch(RoutingAction(destination: .signup))
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.navigationController?.present(alert, animated: true)
    }
    
    @IBAction func redirectTodoPage(_ sender: UIButton) {
        store.dispatch(RoutingAction(destination: .todo))
    }
}

extension LandingPageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyTemp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyTempCell", for: indexPath) as! HourlyTempCollectionViewCell
        let date = String(time[indexPath.row]).getDateComponent(withFormat: "yyyy-MM-dd'T'HH:mm")
        let hour: String = String(format: "%02d", date?.hour ?? 00)
        let minute: String = String(format: "%02d", date?.minute ?? 00)
        cell.set(time: "\(hour):\(minute)",
                 temperature: "\(String(hourlyTemp[indexPath.row]))°")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 100)
    }
}

extension LandingPageViewController: StoreSubscriber {
    func newState(state: (locationState: LocationState, usersState: UsersState, currentUserState: CurrentUserState)) {
        NetworkManager().getForecast(latitude: state.locationState.coordinates.latitude, longitude: state.locationState.coordinates.longitude) { [unowned self] result, error in
            if let error = error {
                showAlert(title: error.localizedDescription, message: "")
            } else {
                self.hourlyTemp = result?.hourly.temperature2M ?? []
                self.time = result?.hourly.time ?? []
                self.weatherLabel.text = WeatherMapper.getString(fromValue: result?.currentWeather.weathercode ?? 1)
                self.hourlyTemperatureCollectionView.reloadData()
            }
        }
        
        self.users = state.usersState.users
        self.currentUserLabel.isHidden = state.currentUserState.currentUser.isEmpty
        self.currentUserLabel.text = "Hi, \(state.currentUserState.currentUser)!"
        self.todoButton.isHidden = self.users.isEmpty
    }
}
