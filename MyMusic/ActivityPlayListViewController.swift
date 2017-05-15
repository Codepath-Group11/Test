//
//  ActivityPlayListViewController.swift
//  MyMusic
//
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit
import UIKit
import Spartan
import AFNetworking
import BubbleTransition

private let reuseIdentifier = "PlaylistCollectionCell"
private let reuseHeaderIdentifier = "ActivityPlaylistReusableView"
class ActivityPlayListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var activitylogButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var activities: [(title: String,name: String?)]! = [("Treadmill","treadmill"),("Run","run"),("Weights","weights"),("Elliptical","elliptical")]
    var playlists: [SimplifiedPlaylist] = []
    var player: SPTAudioStreamingController?
    let transition = BubbleTransition()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        //For the quick equal spacing
        /* basic padding will be 15 */
        let padding: CGFloat = 15
        let rowPerCol: CGFloat = 2
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = self.collectionView.bounds.size.width
        let paddingNum: CGFloat = (rowPerCol + 1)
        let paddingWidth: CGFloat = (paddingNum * padding)
        let cellwidth = (width - paddingWidth)/rowPerCol
        flow.sectionInset = UIEdgeInsetsMake(40, padding ,20 , padding)
        flow.itemSize = CGSize(width: cellwidth, height: cellwidth)
        flow.minimumInteritemSpacing = padding
        flow.minimumLineSpacing = padding
        
        //player set up 
        // Do any additional setup after loading the view.
        MusicClient.getUserPlayLists(userId: "", musicServiceType: "", success: { (myPlaylists:[SimplifiedPlaylist]) in
            self.playlists = myPlaylists
        }) { (error:Error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        //return activities.count
        return activities.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PlaylistCollectionCell
        let item =  activities[indexPath.row]
        cell.title = item.title
        cell.imageName = item.name
        return cell
        //Configure the cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)

        //show the player
        let storyBoard = UIStoryboard(name: "PlayList", bundle: nil)
        let musicPlayerVC = storyBoard.instantiateViewController(withIdentifier: "MusicPlayer") as! MusicPlayerViewController
        present(musicPlayerVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseHeaderIdentifier, for: indexPath)
            return headerView
        }
        return UICollectionReusableView(frame: CGRect.zero)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func switch2Activity(_ sender: UIButton) {
        let activityStoryBoard = UIStoryboard(name: "Activity", bundle: nil)
        let activityNVC = activityStoryBoard.instantiateViewController(withIdentifier: "ActivityNVC") as! UINavigationController
        activityNVC.transitioningDelegate = self
        activityNVC.modalPresentationStyle = .custom
        self.show(activityNVC, sender: nil)
    }
}


extension ActivityPlayListViewController: UIViewControllerTransitioningDelegate{
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = activitylogButton.center
        //transition.bubbleColor = bubbleSwtich.backgroundColor!
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = activitylogButton.center
        //transition.bubbleColor = bubbleSwtich.backgroundColor!
        return transition
    }
}
