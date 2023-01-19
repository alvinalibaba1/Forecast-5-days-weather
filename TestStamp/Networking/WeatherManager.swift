//
//  WeatherManager.swift
//  TestStamp
//
//  Created by temp on 18/01/23.
//

import Foundation

struct WeatherManager {
    static let baseURL = "https://api.openweathermap.org"
    static let apiKEY = "237de98387befb3db5bb776d301b3683"
}

enum APIError: Error {
    case failedToGetData
}


class APICaller {
    static let shared = APICaller()
    
    func getData(completion: @escaping (Result<[List],Error>) -> Void) {
        guard let url = URL(string: "\(WeatherManager.baseURL)/data/2.5/forecast?lat=-6.20&lon=106.81&appid=\(WeatherManager.apiKEY)&cnt=40&units=metric") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(results.list))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
}
