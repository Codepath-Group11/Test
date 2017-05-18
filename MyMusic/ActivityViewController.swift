//
//  ActivityViewController.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 5/11/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit
import BubbleTransition

struct CalorieChart {
    
    var day:String
    var calorieOut:Int
}

struct StepChart {
    var day:String
    var steps:Int
}

struct ActiveMinutesChart {
    var day:String
    var activemin:Int
}

class ActivityViewController: UIViewController,UIViewControllerTransitioningDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var activityButton: UIButton!
    @IBOutlet var redProgressBarView: UIView!
    @IBOutlet var blueProgressBarView: UIView!
    @IBOutlet var greenProgressBarView: UIView!
    
    var totalSteps: Int! = 0
    var totalCalories: Int! = 0
    var totalActiveMinutes: Int! = 0
    
    var totalGoalSteps:Int! = 0
    var totalGoalCalories:Int! = 0
    var totalGoalActiveMinutes:Int! = 0
    var calorieChartData = [CalorieChart]()
    var stepChartData=[StepChart]()
    var activeMinChartData=[ActiveMinutesChart]()

    
    let transition = BubbleTransition()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.black
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        animateRedBar()
        animateBlueBar()
        animateGreenBar()
        getActivitySummaryDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //getActivitySummaryDetails()
        
    }

    @IBAction func activityClick(_ sender: Any) {
        let playlistStoryBoard = UIStoryboard(name: "PlayList", bundle: nil)
        let playlistNVC = playlistStoryBoard.instantiateViewController(withIdentifier: "ActivityPlaylistNVC") as! UINavigationController
        
        playlistNVC.transitioningDelegate = self
        playlistNVC.modalPresentationStyle = .custom
        //self.show(playlistNVC, sender: nil)
        dismiss(animated: true, completion: nil)

        
    }
    
    func animateRedBar(){
        redProgressBarView.backgroundColor = .red
        redProgressBarView.frame.size.width = 0
        
        UIView.animate(withDuration: 2) {
            self.redProgressBarView.frame.size.width = 40
        }
    }
    
    func animateBlueBar(){
        blueProgressBarView.backgroundColor = UIColor(red: 48/255, green: 188/255, blue: 255/255, alpha: 1)
        blueProgressBarView.frame.size.width = 0
        
        UIView.animate(withDuration: 2) {
            self.blueProgressBarView.frame.size.width = 90
        }
    }
    
    func animateGreenBar(){
        greenProgressBarView.backgroundColor = UIColor(red: 40/255, green: 214/255, blue: 23/255, alpha: 1)
        greenProgressBarView.frame.size.width = 0
        
        UIView.animate(withDuration: 2) {
            self.greenProgressBarView.frame.size.width = 60
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = activityButton.center
        transition.bubbleColor = activityButton.backgroundColor!
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = activityButton.center
        transition.bubbleColor = activityButton.backgroundColor!
        return transition
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getActivitySummaryDetails()
    {
        let userDefaults = UserDefaults.standard
        
        let activitySummaryGroup = DispatchGroup()
        
        
        let authToken = UserDefaults.standard.object(forKey: "FitbitToken") as! String
        
        FitbitAPI.sharedInstance.authorize(with: authToken)
        
        var dates: Array<String> = ["2017-05-01","2017-05-02","2017-05-03","2017-05-04","2017-05-05"]
        
        for day in dates {
            activitySummaryGroup.enter()
            let _ = FitbitAPI.fetchDailyActivitySummary(for:day){[weak self] dailyActSummary,error in
                self!.totalCalories = (self?.totalCalories!)! + (dailyActSummary?.caloriesOut)!
                
                self!.totalSteps = (self?.totalSteps!)! + (dailyActSummary?.steps)!
                
                self!.totalActiveMinutes = (self?.totalActiveMinutes!)! + (dailyActSummary?.veryActiveMinutes)!
                
            //    print("The totalSteps are:"+"\(self?.totalSteps!)")
                
                self!.totalGoalSteps = (dailyActSummary?.goals?.steps)! * (dates.count)
                self!.totalGoalCalories = (dailyActSummary?.goals?.caloriesOut)! * (dates.count)
                self!.totalGoalActiveMinutes = (dailyActSummary?.goals?.activeMinutes)! * (dates.count)
                let calorieData = CalorieChart(day:day,calorieOut:(dailyActSummary?.caloriesOut)!)
                let stepData = StepChart(day:day,steps:(dailyActSummary?.steps)!)
                let activeMinData = ActiveMinutesChart(day:day,activemin:(dailyActSummary?.veryActiveMinutes)!)

                self?.calorieChartData.append(calorieData)
                self?.stepChartData.append(stepData)
                self?.activeMinChartData.append(activeMinData)

                activitySummaryGroup.leave()
            }
            
            
        }
        
        activitySummaryGroup.notify(queue: DispatchQueue.main) {
            self.tableView.reloadData()
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let goals = ["Calories", "Steps", "Active Minutes"]
        
        
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let goal = goals[(indexPath?.row)!]
            
            let viewController = segue.destination as? GoalSummaryViewController
        
            viewController?.caloriePerDay = calorieChartData
            viewController?.stepsPerDay = stepChartData
            viewController?.activeMinPerDay = activeMinChartData
            viewController?.goalType = goal
//
//        else if segue.identifier == "ShowUserProfileSegue",
//            
//            let userProfileVC = segue.destination as? ProfileViewController {
//            
//            userProfileVC.user = profile
//        }
//        
        
 
        
        
    }

}


extension ActivityViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as! GoalCell
        let goals = ["Calories", "Steps", "Active Minutes"]
    
        cell.activityTitleLabel.text = goals[indexPath.row]
        cell.activityTitleLabel.textColor = .black
        
        if(goals[indexPath.row] == "Calories")
        {
            
            cell.activityResultsLabel.text = "\((self.totalCalories)!) of "+" \((self.totalGoalCalories)!)"
        }else if(goals[indexPath.row] == "Steps") {
            cell.activityResultsLabel.text = "\(self.totalSteps!) of "+" \(self.totalGoalSteps!)"
            
        }else{
            cell.activityResultsLabel.text = "\(self.totalActiveMinutes!) of "+"\(self.totalGoalActiveMinutes!)"
            
        }

       // cell.activityResultsLabel.text = "1000 of 2000"

        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
        cell.backgroundColor = .clear
        
        switch indexPath.row {
            case 0:
                cell.animateRedBar()
            case 1:
                cell.animateBlueBar()
            case 2:
                cell.animateGreenBar()
            default:
                print("none")
        }
    
        return cell
    }
}

