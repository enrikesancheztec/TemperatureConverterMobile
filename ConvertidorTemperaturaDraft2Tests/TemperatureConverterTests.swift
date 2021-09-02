//
//  TemperatureConverterTests.swift
//  ConvertidorTemperaturaDraft2Tests
//
//  Created by user193555 on 8/15/21.
//

import XCTest

@testable import ConvertidorTemperaturaDraft2

class TemperatureConverterTests: XCTestCase {
    let temperatureConverter = TemperatureConverter()

    func testConvertCelsius0ToCelsius() throws {
        // Given
        let input = Temperature(value: 0, unit: Temperature.Unit.CELSIUS)
        
        // When
        let result = temperatureConverter.convert(temperature: input, unitToConvert: Temperature.Unit.CELSIUS)
        
        // Then
        let expectedValue: Float16 = 0
        let expectedUnit = Temperature.Unit.CELSIUS
        XCTAssertEqual(result.value, expectedValue)
        XCTAssertEqual(result.unit, expectedUnit)
    }
    
    func testConvertFahrenheit0ToFahrenheit() throws {
        // Given
        let input = Temperature(value: 0, unit: Temperature.Unit.FAHRENHEIT)
        
        // When
        let result = temperatureConverter.convert(temperature: input, unitToConvert: Temperature.Unit.FAHRENHEIT)
        
        // Then
        let expectedValue: Float16 = 0
        let expectedUnit = Temperature.Unit.FAHRENHEIT
        XCTAssertEqual(result.value, expectedValue)
        XCTAssertEqual(result.unit, expectedUnit)
    }

    func testConvertCelsius0ToFahrenheit() throws {
        // Given
        let input = Temperature(value: 0, unit: Temperature.Unit.CELSIUS)
        
        // When
        let result = temperatureConverter.convert(temperature: input, unitToConvert: Temperature.Unit.FAHRENHEIT)
        
        // Then
        let expectedValue: Float16 = 32
        let expectedUnit = Temperature.Unit.FAHRENHEIT
        XCTAssertEqual(result.value, expectedValue)
        XCTAssertEqual(result.unit, expectedUnit)
    }

    func testConvertFahrenheit68ToCelsius() throws {
        // Given
        let input = Temperature(value: 68, unit: Temperature.Unit.FAHRENHEIT)
        
        // When
        let result = temperatureConverter.convert(temperature: input, unitToConvert: Temperature.Unit.CELSIUS)
        
        // Then
        let expectedValue: Float16 = 20
        let expectedUnit = Temperature.Unit.CELSIUS
        XCTAssertEqual(result.value, expectedValue)
        XCTAssertEqual(result.unit, expectedUnit)
    }
    
    func testUnitDecodableEnum() throws {
        // Given
        let json = """
            {
                "value": 20,
                "unit": "CELSIUS"
            }
        """.data(using: .utf8)!
        do {
            // When
            let temperature = try JSONDecoder().decode(Temperature.self, from: json)
            
            // Then
            XCTAssertEqual(temperature.unit, Temperature.Unit.CELSIUS)
        } catch {
            XCTFail("error info: \(error)")
        }
        
    }
    
    func testDecodeHistory() throws {
            // Given
            let json = """
                [{
                    "created": "2021-8-29",
                    "original": {
                        "value": 15,
                        "unit": "CELSIUS"
                    },
                    "converted": {
                        "value": 59,
                        "unit": "FAHRENHEIT"
                    }
                }]
            """.data(using: .utf8)!
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let history = try decoder.decode([TemperatureConversion].self, from: json)
            
            XCTAssertEqual(history[0].original.value, 15)
            XCTAssertEqual(history[0].converted.value, 59)
        }
}
