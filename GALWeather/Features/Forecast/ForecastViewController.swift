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


    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var speechResultLabel: UILabel!

    var presenter: ForecastPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.speechRequestAuthorization()
//        presenter?.getForecast(for: "Berlin")
    }


    func startRecording() {
        self.presenter?.startRecording()

    }

    func setTextResult(_ text: String) {
        speechResultLabel.text = text
    }

    func setButtonText(_ text: String) {
        micButton.setTitle(text, for: .normal)
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

    @IBAction func micButtonPressed(_ sender: Any) {
        startRecording()
    }
}
