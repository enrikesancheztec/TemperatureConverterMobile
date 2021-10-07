//
//  ViewController.swift
//  ConvertidorTemperaturaDraft2
//
//  Created by user193555 on 8/15/21.
//

import UIKit
import UniformTypeIdentifiers

class ViewController: UIViewController {
    let temperatureConverter = TemperatureConverter()
    let temperatureConverterService = TemperatureConverterService()
    
    @IBOutlet weak var loadedFile: UITextView!
    @IBOutlet weak var celsiusTextField: UITextField!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        celsiusTextField.delegate = self
        //setupToolbar()
    }

    @IBAction func convertir(_ sender: UIButton) {
        fahrenheitTextField.text = ""
        
        if let celsiusValue = celsiusTextField.text {
            if !celsiusValue.isEmpty {                let originalTemperature = Temperature(value: Float16(celsiusValue)!, unit: Temperature.Unit.CELSIUS)
                
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

    @IBAction func loadFile(_ sender: UIButton) {
        let supportedTypes: [UTType] = [UTType.json]
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
         documentPicker.delegate = self
         documentPicker.allowsMultipleSelection = false
         documentPicker.modalPresentationStyle = .fullScreen
         present(documentPicker, animated: true, completion: nil)
    }

    @IBAction func saveFile(_ sender: Any) {
        let fileTool = TemperatureFileTool()
        
        if let fahrenheitValue = fahrenheitTextField.text {
            if !fahrenheitValue.isEmpty {
                let convertedTemperature = Temperature(value: Float16(fahrenheitValue)!, unit: Temperature.Unit.FAHRENHEIT)
                
                do {
                    try fileTool.saveFile(temperature: convertedTemperature) {
                        fileURL in
                        let controller = UIDocumentPickerViewController(forExporting: [fileURL])
                        present(controller, animated: true)
                    }
                } catch {
                    print("Cannot save file")
                }
            } else {
                print("Fahrenheit value is empty")
            }
        }


    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHistory" {
            let controller = (segue.destination as! ListViewController)
            
            temperatureConverterService.retrieveHistory() {
                (history) in
                DispatchQueue.main.async {
                    controller.history = history
                    controller.tableView.reloadData()
                }
            }
            
        }
    }
    
    
    func setupToolbar(){
        let bar = UIToolbar()
       
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissMyKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexSpace, flexSpace, doneBtn]
        bar.sizeToFit()
        celsiusTextField.inputAccessoryView = bar
   }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
}

extension ViewController: UIDocumentPickerDelegate {
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {

        if let url = urls.first {
            let fileTool = TemperatureFileTool()
            
            do {
                let readString = try fileTool.readFileAsString(url)
                self.loadedFile.text = readString
            } catch {
                print("error trying to convert data to String")
            }
            
            do {
                let readJson = try fileTool.readFileAsJson(url)
                print("JSON: \(String(describing: readJson))")
            } catch {
                print("error trying to convert data to JSON")
            }
            
            do {
                let readTemperature = try fileTool.readFileAsTemperature(url)
                
                if (readTemperature.unit != Temperature.Unit.CELSIUS) {
                    let alertController = UIAlertController(title: "Error", message: "Invalid Unit", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    present(alertController, animated: true, completion: nil)
                } else {
                    self.celsiusTextField.text = String(readTemperature.value)
                }
                
            } catch {
                print("error trying to convert data to JSON")
            }
        }

        controller.dismiss(animated: true)
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if (Double(textField.text!) == nil) {
            textField.text = ""
            let alertController = UIAlertController(title: "Error", message: "Invalid Value", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}

