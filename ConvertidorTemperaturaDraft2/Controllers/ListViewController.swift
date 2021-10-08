//
//  ListViewController.swift
//  ConvertidorTemperaturaDraft2
//
//  Created by user193555 on 9/1/21.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var history : [TemperatureConversion]? {
        didSet {

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ConversionTableViewCell {
            let temperatureConversion = history?[indexPath.row]
            cell.updateCell(conversion: temperatureConversion!)
            return cell
        }

        //cell.textLabel!.text = String(temperatureConversion?.original.value ?? 0) + " " + String(temperatureConversion?.converted.value ?? 0)
        return UITableViewCell()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let controller = (segue.destination as! DetailViewController)
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedConversion = history?[indexPath.row]
                controller.detailItem = selectedConversion
            }
            
        }
    }
}
