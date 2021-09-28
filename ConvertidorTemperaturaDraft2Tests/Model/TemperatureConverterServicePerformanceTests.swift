//
//  TemperatureConverterServicePerformanceTests.swift
//  ConvertidorTemperaturaDraft2Tests
//
//  Created by user193555 on 9/26/21.
//

import XCTest

@testable import ConvertidorTemperaturaDraft2

class TemperatureConverterServicePerformanceTests: XCTestCase {
    let temperatureConverterService = TemperatureConverterService()

    func testRetrieveHistory() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            temperatureConverterService.retrieveHistory(){
                (history) in
            }
        }
    }

}
