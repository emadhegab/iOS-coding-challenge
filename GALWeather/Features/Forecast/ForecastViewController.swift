//
//  ForecastViewController.swift
//  GALWeather
//
//  Created Mohamed Emad Abdalla Hegab on 01.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//


import UIKit
import Speech

class ForecastViewController: UIViewController, ForecastViewProtocol {


    @IBOutlet weak var forecastContainer: UIView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempratureIconImage: UIImageView!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var speechResultLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!

    var presenter: ForecastPresenterProtocol?
    var city: String = ""
    var tempSystem: TempSystem = .celsius

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.speechRequestAuthorization()
        notificationChecker()
    }

    func setTextResult(_ text: String) {
        speechResultLabel.text = text
    }

    func setButtonText(_ text: String) {

        micButton.setTitle(text, for: .normal)
    }

    func toggleButton(isEnabled: Bool) {
        micButton.isEnabled = isEnabled
        micButton.backgroundColor = isEnabled ? UIColor(red: 224 / 255, green: 166 / 255, blue: 35 / 255, alpha: 1) :  UIColor.lightGray
    }

    private func notificationChecker() {
        NotificationCenter.default.addObserver(self, selector: #selector(micButtonPressed(_:)), name: Constants.DEEP_LINK_NOTIFICATION.name, object: nil)
    }

    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        micButton.layer.cornerRadius = micButton.frame.width / 2
        micButton.clipsToBounds = true
        micButton.isEnabled = false
        forecastContainer.isHidden = true
    }

    private func setupIcon(with url: URL?) {
        guard let url = url else { return }
        Queue.background.async {
            if let data = try? Data(contentsOf: url) {
                Queue.main.async { [weak self] in
                    self?.tempratureIconImage.image = UIImage(data: data)
                }
            }
        }
    }

    func setWeatherData() {
        forecastContainer.isHidden = false
        if let forecast = presenter?.forecast {
            self.conditionLabel.text = forecast.current.condition.text
            self.locationNameLabel.text = "\(forecast.location.name), \(forecast.location.country)"
            setupTempratureTitle()
            setupIcon(with: forecast.current.condition.iconURL())
        }
    }

    func setupTempratureTitle() {
        if let currentForecast = presenter?.forecast?.current {
            self.tempratureLabel.text = tempSystem == .celsius ? "\(currentForecast.tempC) °c" : "\(currentForecast.tempF) °F"
        }
    }

    @IBAction func systemSegmentChanged(_ segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            tempSystem = .celsius
        case 1:
            tempSystem = .fahrenheit

        default:
            tempSystem = .celsius
        }
        setupTempratureTitle()
    }

    @IBAction func micButtonPressed(_ sender: Any) {
        self.presenter?.startRecording()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: Constants.DEEP_LINK_NOTIFICATION.name, object: nil)

    }
}
