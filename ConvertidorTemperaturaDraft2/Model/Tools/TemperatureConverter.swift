//
//  TemperatureConverter.swift
//  ConvertidorTemperaturaDraft2
//
//  Created by user193555 on 8/15/21.
//

import Foundation

// https://google.github.io/swift/
public class TemperatureConverter {
    public func convert(temperature: Temperature, unitToConvert: Temperature.Unit) -> Temperature {
        if (temperature.unit == Temperature.Unit.CELSIUS && unitToConvert == Temperature.Unit.FAHRENHEIT) {
            let convertedValue: Float16 = (temperature.value * 9/5) + 32
            return Temperature(value: convertedValue, unit: unitToConvert)
        } else if (temperature.unit == Temperature.Unit.FAHRENHEIT && unitToConvert == Temperature.Unit.CELSIUS) {
            let convertedValue: Float16 = (temperature.value - 32) * 5/9
            return Temperature(value: convertedValue, unit: unitToConvert)
        } else {
            return Temperature(value: temperature.value, unit: temperature.unit)
        }        
    }
}
