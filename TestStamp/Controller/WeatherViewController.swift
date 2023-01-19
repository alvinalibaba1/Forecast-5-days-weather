//
//  ViewController.swift
//  TestStamp
//
//  Created by temp on 18/01/23.
//

import UIKit

class WeatherViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataWeather()
    }
    
}

func getDataWeather() {
    APICaller.shared.getData { result in
        switch result {
        case .success(let list):
            var data: [List] = []
            for item in list {
                if item.jam == 13 {
                    data.append(item)
                }
            }
            print("Weather Forecast:")
            for datum in data {
                print(datum.output)
            }
        case .failure(let error):
            print(error)
        }
    }
}
