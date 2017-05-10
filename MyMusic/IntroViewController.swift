//
//  IntroPageController.swift
//  MyMusic
//
//  Created by kathy yin on 5/10/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, IntroPageViewControllerDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? IntroPageViewController {
           vc.introPageViewControllerDelegate = self
        }
    }
    
    func introPageViewController(_ vc: IntroPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func introPageViewController(_ vc: IntroPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
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
