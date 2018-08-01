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

    var presenter: ForecastPresenterProtocol?
    var city: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.speechRequestAuthorization()
    }

    func setTextResult(_ text: String) {
        speechResultLabel.text = text
    }

    func setButtonText(_ text: String) {

        micButton.setTitle(text, for: .normal)
    }

    func callWeatherWithCity() {
        presenter?.getForecast(for: self.city)
    }

    func toggleButton(isEnabled: Bool) {
        micButton.isEnabled = isEnabled
        micButton.backgroundColor = isEnabled ? UIColor(red: 224 / 255, green: 116 / 255, blue: 45 / 255, alpha: 1) :  UIColor.lightGray
    }

    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        micButton.layer.cornerRadius = micButton.frame.width / 2
        micButton.clipsToBounds = true
        micButton.isEnabled = false
    }

    private func setupIcon(with url: URL?) {
        guard let url = url else { return }
        if let data = try? Data(contentsOf: url) {
            self.tempratureIconImage.image = UIImage(data: data)
        }
    }

    func setWeatherData(forecast: Forecast) {
        let currentForecast = forecast.current
        self.tempratureLabel.text = "\(currentForecast.tempC) °c"
        self.conditionLabel.text = currentForecast.condition.text
        setupIcon(with: currentForecast.condition.iconURL())
    }

    @IBAction func systemSegmentChanged(_ sender: Any) {
    }

    @IBAction func micButtonPressed(_ sender: Any) {
        self.presenter?.startRecording()
    }
}
