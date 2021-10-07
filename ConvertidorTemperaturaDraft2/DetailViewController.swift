//
//  File.swift
//  ConvertidorTemperaturaDraft2
//
//  Created by user193555 on 10/7/21.
//

import UIKit

class DetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        //navigationController?.popToRootViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
}
