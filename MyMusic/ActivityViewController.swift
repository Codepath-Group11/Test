//
//  ActivityViewController.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 5/11/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit
import BubbleTransition


class ActivityViewController: UIViewController,UIViewControllerTransitioningDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var activityButton: UIButton!
    @IBOutlet var redProgressBarView: UIView!
    @IBOutlet var blueProgressBarView: UIView!
    @IBOutlet var greenProgressBarView: UIView!
    
    let transition = BubbleTransition()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        animateRedBar()
        animateBlueBar()
        animateGreenBar()
    }

    @IBAction func activityClick(_ sender: Any) {
        let playlistStoryBoard = UIStoryboard(name: "PlayList", bundle: nil)
        let playlistNVC = playlistStoryBoard.instantiateViewController(withIdentifier: "PlaylistNVC") as! UINavigationController
        
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
        cell.activityResultsLabel.text = "1000 of 2000"

        cell.layer.cornerRadius = 10
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

