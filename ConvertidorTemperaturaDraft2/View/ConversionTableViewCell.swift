//
//  File.swift
//  ConvertidorTemperaturaDraft2
//
//  Created by user193555 on 9/26/21.
//

import UIKit

class ConversionTableViewCell: UITableViewCell {
    @IBOutlet weak var conversionDate: UILabel!
    @IBOutlet weak var originalUnit: UILabel!
    @IBOutlet weak var originalValue: UILabel!
    @IBOutlet weak var convertedValue: UILabel!
    @IBOutlet weak var convertedUnit: UILabel!
    
    func updateCell(conversion: TemperatureConversion) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        conversionDate.text = dateFormatter.string(from: conversion.created)
        originalValue.text = String(conversion.original.value)
        originalUnit.text = conversion.original.unit.rawValue
        convertedValue.text = String(conversion.converted.value)
        convertedUnit.text = conversion.converted.unit.rawValue
    }
    
}
