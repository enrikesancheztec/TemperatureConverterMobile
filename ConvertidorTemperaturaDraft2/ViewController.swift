//
//  ViewController.swift
//  ConvertidorTemperaturaDraft2
//
//  Created by user193555 on 8/15/21.
//

import UIKit

class ViewController: UIViewController {
    let temperatureConverter = TemperatureConverter()
    @IBOutlet weak var celsiusTextField: UITextField!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func convertir(_ sender: UIButton) {
        fahrenheitTextField.text = ""
        
        if let celciusValue = celsiusTextField.text {
            if !celciusValue.isEmpty {
                let fahrenheitValue = temperatureConverter.convert(temperature: Temperature(value: Float16(celciusValue)!, unit: Temperature.Unit.CELSIUS), unitToConvert: Temperature.Unit.FAHRENHEIT)
                print("Farenheit " + String(fahrenheitValue.value))
                fahrenheitTextField.text = String(fahrenheitValue.value)
            } else {
                print("Celcius value is empty")
            }
        }
    }
}

