//
//  ViewController.swift
//  ConvertidorTemperaturaDraft2
//
//  Created by user193555 on 8/15/21.
//

import UIKit

class ViewController: UIViewController {
    let temperatureConverter = TemperatureConverter()
    let temperatureConverterService = TemperatureConverterService()
    
    @IBOutlet weak var celsiusTextField: UITextField!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func convertir(_ sender: UIButton) {
        fahrenheitTextField.text = ""
        
        if let celsiusValue = celsiusTextField.text {
            if !celsiusValue.isEmpty {
                /*
                let fahrenheitValue = temperatureConverter.convert(temperature: Temperature(value: Float16(celsiusValue)!, unit: Temperature.Unit.CELSIUS), unitToConvert: Temperature.Unit.FAHRENHEIT)
                print("Farenheit " + String(fahrenheitValue.value))
                fahrenheitTextField.text = String(fahrenheitValue.value)
                */
                let originalTemperature = Temperature(value: Float16(celsiusValue)!, unit: Temperature.Unit.CELSIUS)
                
                temperatureConverterService.convertToFahrenheit(temperature: originalTemperature) {
                    [weak self] (fahrenheitTemperature) in
                    DispatchQueue.main.async {
                        self?.fahrenheitTextField.text = String(fahrenheitTemperature.value)
                    }
                    
                }
            } else {
                print("Celsius value is empty")
            }
        }
    }
}

