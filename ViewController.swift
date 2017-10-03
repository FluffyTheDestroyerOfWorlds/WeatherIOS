//
//  ViewController.swift
//  Weather
//
//  Created by David Boesen on 10/1/17.
//  Copyright © 2017 David Boesen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var currentTemp: UILabel!
	@IBOutlet weak var currentSummary: UILabel!
	@IBOutlet weak var currentCity: UILabel!
	@IBOutlet weak var mrSun: UIImageView!
	@IBOutlet weak var dewPoint: UILabel!
	@IBOutlet weak var humidity: UILabel!
	@IBOutlet weak var windSpeed: UILabel!
	@IBOutlet weak var windDirection: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		
		if let url = NSURL(string: "https://api.darksky.net/forecast/bc8b076254e97ff7a44dde5303b54840/42.232554,-88.335331") {
		if let data = NSData(contentsOf: url as URL){
		do {
			let parsed = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)  as! [String:AnyObject] // 1
			
			let newDict = parsed  // 2
			print(newDict["currently"]!["summary"])
			
			var cTemp: Double = Double("\(newDict["currently"]!["temperature"]!!)")!
		
			var sTemp: String = String(format: "%.0f" , cTemp) + " ° F"
				
			self.currentTemp.text = sTemp
			self.currentSummary.text = "\(newDict["currently"]!["summary"]!!)"
			var city = "\(newDict["timezone"])"
			city = city.replacingOccurrences(of: "Optional(America/", with: "")
			city = city.replacingOccurrences(of: ")", with: "")
			
			self.currentCity.text = city
			print(newDict["timezone"])
			
			switch String(describing: self.currentSummary.text) {
				case "clear-day", "clear-night":
				     self.mrSun.image = #imageLiteral(resourceName: "sunny")
				
				case "rain", "sleet":
					self.mrSun.image = #imageLiteral(resourceName: "rainy")
				
				case "wind", "fog", "cloudy":
					self.mrSun.image = #imageLiteral(resourceName: "cloudy")
				
				case "snow":
					self.mrSun.image = #imageLiteral(resourceName: "snowy")
			    default:
				    self.mrSun.image = #imageLiteral(resourceName: "sunny")
			}
			dewPoint.text = "\(newDict["currently"]!["dewPoint"]!!)"
			humidity.text = "\(newDict["currently"]!["humidity"]!!)"
			windSpeed.text = "\(newDict["currently"]!["windSpeed"]!!)" + "  MPH"
			
			var windDirect = newDict["currently"]!["windBearing"] as! Int
			
			
			
			
			switch windDirect {
				case 0...80:
					windDirection.text = "North"
				case 81...179:
					windDirection.text = "East"
				case 180...269:
					windDirection.text = "South"
				default:
				windDirection.text = "West"
			}
		}
		catch let error as NSError {
			print("A JSON parsing error occurred, here are the details:\n \(error)") // 3
			}
		}
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

