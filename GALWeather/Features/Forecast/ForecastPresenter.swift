//
//  ForecastPresenter.swift
//  GALWeather
//
//  Created Mohamed Emad Abdalla Hegab on 01.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//


import UIKit
import Speech

class ForecastPresenter: NSObject, ForecastPresenterProtocol {


    weak private var view: ForecastViewProtocol?
    var interactor: ForecastInteractorProtocol?

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    init(interface: ForecastViewProtocol, interactor: ForecastInteractorProtocol?) {
        super.init()
        self.view = interface
        self.interactor = interactor
        speechRecognizer?.delegate = self
    }

    func getForecast(for city: String) {
        interactor?.getForecast(for: city, onComplete: { (forecast) in
            print(forecast.current.condition.iconURL()?.absoluteURL ?? "")
        }, onError: { (error) in
            print(error)
        })
    }

    func speechRequestAuthorization() {

        SFSpeechRecognizer.requestAuthorization { (authStatus) in

            var isButtonEnabled = false

            switch authStatus {
            case .authorized:
                isButtonEnabled = true

            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")

            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")

            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }

            OperationQueue.main.addOperation() { [weak self] in
                self?.view?.toggleButton(isEnabled: isButtonEnabled)
            }
        }
    }



    func startRecording() {

        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            view?.toggleButton(isEnabled: false)
            view?.setButtonText("Start Recording")
        } else {
            record()
            view?.setButtonText("Stop Recording")
        }


    }

    fileprivate func record() {

        resetRecognitionTask()

        audioSessionCreating()

        recognitionRequestCreating()

        let inputNode = audioEngine.inputNode

        speechRecognizer?.recognitionTask(with: recognitionRequest!, resultHandler: { [weak self] (result, error) in
            guard let `self` = self else { return }
            var isFinal = false

            if result != nil {
                if let resultString = result?.bestTranscription.formattedString {
                    self.view?.setTextResult(resultString)
                }
                isFinal = (result?.isFinal)!
                print(isFinal)
            }

            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

                self.view?.toggleButton(isEnabled: true)
            }
        })

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()

        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
    fileprivate func audioSessionCreating() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch let error {
            print("audioSession properties error \(error)")
        }
    }

    fileprivate func recognitionRequestCreating() {
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        guard let recognitionRequest = recognitionRequest else {
            print("SFSpeechAudioBufferRecognitionRequest not created")
            return
        }
        recognitionRequest.shouldReportPartialResults = true

    }

    fileprivate func resetRecognitionTask() {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
    }


}


extension ForecastPresenter: SFSpeechRecognizerDelegate {

    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
            view?.toggleButton(isEnabled: available)
    }
}





