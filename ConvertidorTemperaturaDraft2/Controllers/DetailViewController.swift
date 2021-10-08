//
//  File.swift
//  ConvertidorTemperaturaDraft2
//
//  Created by user193555 on 10/7/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var convertedLabel: UILabel!
    
    var detailItem : TemperatureConversion? {
        didSet {

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let conversion = detailItem {
            originalLabel.text = String(conversion.original.value) + " " + conversion.original.unit.rawValue
            convertedLabel.text = String(conversion.converted.value) + " " + conversion.converted.unit.rawValue
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            dateLabel.text = dateFormatter.string(from: conversion.created)
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
        //navigationController?.popViewController(animated: true)
    }
}
