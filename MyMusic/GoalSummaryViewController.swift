    //
//  GoalSummaryViewController.swift
//  MyMusic
//
//  Created by Arthur Burgin on 5/13/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit
import Charts

class GoalSummaryViewController: UIViewController {

    @IBOutlet var activityTitleLabel: UILabel!
    @IBOutlet var motivationSuggestionTitleLabel: UILabel!
    @IBOutlet var motivationSuggestionSummaryLabel: UILabel!
    @IBOutlet var motivationLabel: UILabel!
    @IBOutlet var motivationalTipTitleLabel: UILabel!
    
    @IBOutlet var barChartView: BarChartView!
    
    weak var axisFormatDelegate: IAxisValueFormatter?

    var caloriePerDay:[CalorieChart]?
    var stepsPerDay:[StepChart]?
    var activeMinPerDay:[ActiveMinutesChart]?
    var goalType:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        axisFormatDelegate = self

        // Do any additional setup after loading the view.
        updateChartWithData()

    }
    
    func updateChartWithData() {
        
        var dataEntries: [BarChartDataEntry] = []
        var dataEntry:BarChartDataEntry?
        
        var i = 0
        var title: String = ""
        if(goalType == "Calories") {
        for calorie in caloriePerDay! {
             title = "Calories"
             dataEntry = BarChartDataEntry(x: Double(i), y: Double(calorie.calorieOut))
            dataEntries.append(dataEntry!)
            i += 1
         }
            motivationLabel.text = "You've accomplished your weekly goals for calories, congrats!!! \n\nBased off your results, it looks like you like to lift weights more than running."
            motivationalTipTitleLabel.textColor = UIColor(red: 255/255, green: 94/255, blue: 61/255, alpha: 1)
        }else if(goalType == "Steps")
        {
            title = "Steps"
            for step in stepsPerDay! {
                dataEntry = BarChartDataEntry(x: Double(i), y: Double(step.steps))
                dataEntries.append(dataEntry!)
                i += 1
            }
            motivationLabel.text = "It looks like you havent quite hit your goal yet but don't worry! \n\nGo for a run while listening to the either the Run or Treadmill playlists."
            motivationalTipTitleLabel.textColor = UIColor(red: 28/255, green: 166/255, blue: 223/255, alpha: 1)
        }else {
            title = "ActiveMinutes"
            for activeMinutes in activeMinPerDay! {
                dataEntry = BarChartDataEntry(x: Double(i), y: Double(activeMinutes.activemin))
                dataEntries.append(dataEntry!)
                i += 1
            }
            motivationLabel.text = "Active Minutes"
            motivationalTipTitleLabel.textColor = UIColor(red: 72/255, green: 164/255, blue: 29/255, alpha: 1)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: goalType)
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.chartDescription?.text = title
        barChartView.chartDescription?.textColor = UIColor.white
        barChartView.chartDescription?.font = UIFont.systemFont(ofSize: 30)
        barChartView.rightAxis.enabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
    
        chartDataSet.colors = [.red, .yellow, .green]
        
        // Or this way. There are also available .liberty,
        // .pastel, .colorful and .vordiplom color sets.
        chartDataSet.colors = ChartColorTemplates.colorful()
      //  chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        chartDataSet.valueTextColor = UIColor.white
        barChartView.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
        barChartView.data = chartData
        
        let xaxis = barChartView.xAxis
        xaxis.valueFormatter = axisFormatDelegate
        barChartView.xAxis.labelTextColor = UIColor.white
        barChartView.leftAxis.labelTextColor = UIColor.white
        barChartView.rightAxis.labelTextColor = UIColor.white
        barChartView.xAxis.labelPosition = .bottom
        
    }
    
    @IBAction func didTapDone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: axisFormatDelegate
extension GoalSummaryViewController: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(String(value))"
    }
}
