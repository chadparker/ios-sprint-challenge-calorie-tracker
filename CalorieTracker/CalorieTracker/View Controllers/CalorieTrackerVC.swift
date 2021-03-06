//
//  CalorieTrackerVC.swift
//  CalorieTracker
//
//  Created by Chad Parker on 6/12/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import UIKit
import CoreData

class CalorieTrackerVC: UIViewController {
   
   @IBAction func addCalorieEntry(_ sender: Any) {
      CalorieEntry(calories: Int16.random(in: 1...400) * 5)
      do {
         try CoreDataStack.shared.mainContext.save()
         NotificationCenter.default.post(name: .newCalorieEntryAdded, object: self)
      } catch {
         NSLog("Error saving managed object context: \(error)")
      }
   }
}
