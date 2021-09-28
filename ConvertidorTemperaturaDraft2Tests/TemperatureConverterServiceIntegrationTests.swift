//
//  TemperatureConverterTests.swift
//  ConvertidorTemperaturaDraft2Tests
//
//  Created by user193555 on 8/15/21.
//

import XCTest

@testable import ConvertidorTemperaturaDraft2

class TemperatureConverterServiceIntegrationTests: XCTestCase {
    let temperatureConverterService = TemperatureConverterService()

    func testRetrieveHistory() throws {
        // When
        let historyExpectation = expectation(description: "History Retrieved")
        temperatureConverterService.retrieveHistory() {
            (history) in
            historyExpectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 10) {
            (error) in

            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            } else {
                XCTAssert(true)
            }
        }
    }

    func testConvertToFahrenheit() throws {
        // Given
        let input = Temperature(value: 24, unit: Temperature.Unit.CELSIUS)
        
        // When
        let convertExpectation = expectation(description: "Conversion Done")
        temperatureConverterService.convertToFahrenheit(temperature: input) {
            (history) in
            convertExpectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 10) {
            (error) in

            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            } else {
                XCTAssert(true)
            }
        }
    }

    func testDecodableEnum() throws {
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
