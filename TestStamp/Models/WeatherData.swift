//
//  Data.swift
//  TestStamp
//
//  Created by temp on 19/01/23.
//

import Foundation


struct WeatherData: Codable{
    let list: [List]
}

struct List: Codable {
    let dt: Int?
    let date: Date
    let tanggal: String
    let jam: Int
    let main : Main
    var output: String
    
    enum Keys: String, CodingKey {
        case dt, main
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.dt = try container.decodeIfPresent(Int.self, forKey: .dt) ?? 0
        self.main = try container.decodeIfPresent(Main.self, forKey: .main) ?? Main(temp: 99)
        
        self.date = Date(timeIntervalSince1970: Double(self.dt ?? 0))
        
        
        let dateFormatTime = DateFormatter()
        dateFormatTime.timeZone = TimeZone.current
        dateFormatTime.dateFormat = "HH"
        jam = Int(dateFormatTime.string(from: self.date)) ?? 0
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy"
        tanggal = String(dateFormatter.string(from: self.date))
        
        output = tanggal + ": \(main.temp)°C"
        
        
    }
    
}

struct Main: Codable {
    let temp: Float
}
