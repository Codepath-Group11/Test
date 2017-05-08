//
//  SettingViewController.swift
//  MyMusic
//
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit


class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FitbitSettingCellDelegate, SpotifySettingCellDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    var headerView: MyMusic!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView(frame: CGRect.zero)
        tableview.estimatedRowHeight = 60
        //tableview.tableHeaderView = headerView
        tableview.rowHeight = UITableViewAutomaticDimension
        headerView = MyMusic(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 70))
        //tableview.tableHeaderView = headerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                let cell = tableview.dequeueReusableCell(withIdentifier: "SpotifySettingCell") as? SpotifySettingCell
                    cell?.delegate = self
                return cell!
                break
            case 1:
                let cell = tableview.dequeueReusableCell(withIdentifier: "FitbitSettingCell") as? FitbitSettingCell
                    cell?.delegate = self
                    return cell!
                 break
            default:
                return UITableViewCell()
                break
        }
    }

    func didChangeSpotifLoginStatus(isOn: Bool) {
        print("change spotify account setting")
    }
    
    func didChangefitbitAccountLoginStatus(isOn: Bool) {
        print("change fit bit account setting")
    }
    
    @IBAction func onTapCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
