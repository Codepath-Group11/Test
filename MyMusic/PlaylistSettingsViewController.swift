//
//  PlaylistSettingsViewController.swift
//  MyMusic
//
//  Created by Arthur Burgin on 5/10/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

//protocol PlaylistSettingsViewControllerDelegate {
//    func playlistSettingsViewController(PlaylistSettingsViewController: PlaylistSettingsViewController, )
//}

class PlaylistSettingsViewController: UIViewController {
    @IBOutlet var moodSegmentedControl: UISegmentedControl!
    @IBOutlet var energySegmentedControl: UISegmentedControl!
    @IBOutlet var danceSegmentedControl: UISegmentedControl!
    @IBOutlet var tempoSegmentedControl: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveSettingsTapped(_ sender: UIButton) {
        let parseObj = saveSelectedSettings()
        for (k, v) in parseObj.enumerated(){
            print("\(k): \(v)")
        }
        //save into parse database
        MusicClient.getCustomizedPlaylist(tempo: 0.0, mood: 0.0, dance: 0.0, energy: 0.0)
        dismiss(animated: true, completion: {
            MusicClient.getTracksFromId()
        })
    }
    
    @IBAction func dismissSettingsTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveSelectedSettings()->[String: Int]{
        var selectedSettings: [String: Int] = [:]
        
        selectedSettings["mood"] = moodSegmentedControl.selectedSegmentIndex
        selectedSettings["energy"] = energySegmentedControl.selectedSegmentIndex
        selectedSettings["dance"] = danceSegmentedControl.selectedSegmentIndex
        selectedSettings["tempo"] = tempoSegmentedControl.selectedSegmentIndex
        
        return selectedSettings
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
