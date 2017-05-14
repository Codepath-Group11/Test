//
//  ActivityLogViewController.swift
//  MyMusic
//
//  Created by kathy yin on 5/12/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

class ActivityLogViewController: UIViewController , iCarouselDataSource, iCarouselDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var categoryDescription: UILabel!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var carouselView: iCarousel!
    @IBOutlet weak var closeBtn: UIButton!
    var firstload: Bool = true
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
         let item = CategoryView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
         item.categoryImg.contentMode = .scaleAspectFit
        if index == 0 {
          let img = UIImage(named: "generalActivity")
          item.categoryImg.image = img
          item.categoryLabel.text = "Activity Categories"
        } else {
          let img = UIImage(named: "sumary")
          item.categoryImg.image = img
          item.categoryLabel.text = "Weekly Review"
        }
        return item
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        print("select")
        displayDiscription(index)
        let nib = UIStoryboard(name: "Main", bundle: nil)
        if index == 0 {
            //present activityies view
            let activityVC = nib.instantiateViewController(withIdentifier: "ActivityCollectionViewController")
            self.navigationController?.pushViewController(activityVC, animated: true)
        } else if index == 1 {
            print(index)
        }
    }

    func displayDiscription(_ index: Int) {
        
        if(index == 0) {
            self.categoryTitle.text = "Activity Categories"
            self.categoryDescription.text = ""
            
        } else {
            self.categoryTitle.text = "Weekly Review"
            self.categoryDescription.text = ""
        }
    }

    func carouselDidEndScrollingAnimation(_ carousel: iCarousel) {
        print("did end scroll")
        let index = carousel.currentItemIndex
        displayDiscription(index)
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 2
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      self.contentView.isHidden = true
      carouselView.type = .invertedCylinder
      self.closeBtn.layer.cornerRadius = closeBtn.frame.width/2
        // Do any additional setup after loading the view.
    }

    func showContent() {
       contentView.isHidden = false
       contentView.alpha = 0
       UIView.animate(withDuration: 0.2, animations: {
        self.contentView.alpha = 1
       }) { (finished) in
         self.firstload = false
       }
    }

    func hideContent() {
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.alpha = 0
        }) { (finished) in
            self.contentView.isHidden = true
            self.dismiss(animated: true, completion: nil)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if firstload {
          showContent()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTapClose(_ sender: UIButton) {
        hideContent()
        //self.dismiss(animated: true, completion: nil)
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
