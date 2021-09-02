//
//  TemperatureConverterService.swift
//  ConvertidorTemperaturaDraft2
//
//  Created by user193555 on 8/22/21.
//

import Foundation

class TemperatureConverterService {
    public typealias ConvertToFahrenheitClosure = (Temperature) -> Void
    public typealias RetrieveHistoryClosure = ([TemperatureConversion]) -> Void
    
    func convertToFahrenheit(temperature: Temperature, _ handler: @escaping ConvertToFahrenheitClosure) {
        let temperatureConverterEndpoint: String = "https://temperature-converter-rest.herokuapp.com/temperature/conversion/fahrenheit"
        guard let url = URL(string: temperatureConverterEndpoint) else {
            print("Error: cannot create URL")
            return
        }
    
        var urlRequest = URLRequest(url: url)

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let jsonData = try! encoder.encode(temperature)
        urlRequest.httpBody = jsonData
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on /temperature/conversion/fahrenheit")
                print(error!)
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                let convertedTemperature = try decoder.decode(Temperature.self, from: responseData)
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("statusCode: \(httpResponse.statusCode)")
                    print("value: \(convertedTemperature.value)")
                    print("unit: \(convertedTemperature.unit)")
                }
                
                handler(convertedTemperature)
            } catch {
                print("error trying to convert data to JSON")
                return
            }

        }
        task.resume()
  }
    
    func retrieveHistory(_ handler: @escaping RetrieveHistoryClosure) {
            let historyEndpoint: String = "https://temperature-converter-rest.herokuapp.com/temperature/conversion/history"
            guard let url = URL(string: historyEndpoint) else {
                print("Error: cannot create URL")
                return
            }
        
            let urlRequest = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            let decoder = JSONDecoder()
            let task = session.dataTask(with: urlRequest) {
                (data, response, error) in
                guard error == nil else {
                    print("error calling GET on /temperature/conversion/history")
                    print(error!)
                    return
                }
                
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                
                do {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    if let jsonResponse = String(data: responseData, encoding: String.Encoding.utf8) {
                        print("JSON String: \(jsonResponse)")
                    }

                    let history = try decoder.decode([TemperatureConversion].self, from: responseData)
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        print("statusCode: \(httpResponse.statusCode)")
                    }
        
                    handler(history)
                } catch {
                    print("error trying to convert data to JSON")
                    return
                }

            }
            task.resume()
      }
}
