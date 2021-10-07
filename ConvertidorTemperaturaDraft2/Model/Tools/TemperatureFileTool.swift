//
//  TemperatureFIleTool.swift
//  ConvertidorTemperaturaDraft2
//
//  Created by user193555 on 10/3/21.
//

import Foundation

class TemperatureFileTool {
    enum Error: Swift.Error {
        case fileAlreadyExists
        case invalidDirectory
        case writtingFailed
    }
    
    let fileManager: FileManager
    
    init(fileManager: FileManager = .default) {
            self.fileManager = fileManager
    }

    public func readFileAsTemperature(_ url: URL) throws -> Temperature {
        print("The Url is : \(url)")
        var readTemperature : Temperature
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        readTemperature = try decoder.decode(Temperature.self, from: data)
        print("Temperature Object=  value:\(readTemperature.value) unit:\(readTemperature.unit)")

        return readTemperature
    }
    
    public func readFileAsString(_ url: URL) throws -> String {
        print("The Url is : \(url)")
        var strData : String
        
        let data = try Data(contentsOf: url)
        strData = String(decoding: data, as: UTF8.self)
        print("String data=\(strData)")

        return strData
    }
    
    public func readFileAsJson(_ url: URL) throws -> Any? {
        print("The Url is : \(url)")
        let data = try Data(contentsOf: url)
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        print("Json data=\(String(describing: json))")
        
        return json
    }

    public typealias SaveFileClosure = (URL) -> Void

    public func saveFile(temperature: Temperature, _ handler: SaveFileClosure) throws {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(temperature)
        let fileManager = FileManager.default
        let fileURL = fileManager.temporaryDirectory.appendingPathComponent("exported.json")
        try jsonData.write(to: fileURL)
        
        handler(fileURL)
    }
}
