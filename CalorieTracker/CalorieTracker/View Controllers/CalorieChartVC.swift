//
//  CalorieChartVC.swift
//  CalorieTracker
//
//  Created by Chad Parker on 6/12/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import UIKit
import SwiftChart
import CoreData

class CalorieChartVC: UIViewController {
   
   @IBOutlet private weak var chart: Chart!
   
   private var calorieEntries: [CalorieEntry] {
      let fetchRequest: NSFetchRequest<CalorieEntry> = CalorieEntry.fetchRequest()
      fetchRequest.sortDescriptors = [
         NSSortDescriptor(key: "date", ascending: true)
      ]
      let context = CoreDataStack.shared.mainContext
      do {
         return try context.fetch(fetchRequest)
      } catch {
         NSLog("Error fetching entries: \(error)")
         return []
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      updateChart()
      
      NotificationCenter.default.addObserver(
         self,
         selector: #selector(updateChart),
         name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
         object: CoreDataStack.shared.mainContext
      )
   }
   
   @objc func updateChart() {
      let calorieNumbers = calorieEntries.map { Double($0.calories) }
      let series = ChartSeries(calorieNumbers)
      chart.removeAllSeries()
      chart.add(series)
   }
}
