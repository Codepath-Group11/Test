//
//  IntroPageViewController.swift
//  MyMusic
//
//  Created by kathy yin on 5/10/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

protocol IntroPageViewControllerDelegate: class {
    func introPageViewController(_ vc: IntroPageViewController, didUpdatePageCount count: Int)
    
     func introPageViewController(_ vc: IntroPageViewController, didUpdatePageIndex index: Int)
}

class IntroPageViewController: UIPageViewController , UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    weak var introPageViewControllerDelegate: IntroPageViewControllerDelegate?
    private(set) lazy var orderViewControllers: [UIViewController] = {
        return [self.loadViewControllerBy("WelcomeController"), self.loadViewControllerBy("SpotifyOauthController"),self.loadViewControllerBy("FitBitOauthController")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        if let firstVc = orderViewControllers.first {
           setViewControllers([firstVc], direction: .forward, animated: true, completion: nil)
        }
        
        introPageViewControllerDelegate?.introPageViewController(self, didUpdatePageCount: orderViewControllers.count)
        // Do any additional setup after loading the view.
    }
    
    private func loadViewControllerBy(_ viewControllerIdentifier: String) -> UIViewController {
        let nib = UIStoryboard(name: "Login", bundle: nil)
        return nib.instantiateViewController(withIdentifier: viewControllerIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = orderViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = vcIndex + 1
        
        guard orderViewControllers.count != nextIndex else {
            return orderViewControllers.first
        }
        
        return orderViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
       
        guard let vcIndex = orderViewControllers.index(of: viewController) else {
            return nil
        }
        
        let prevIndex = vcIndex - 1
        
        guard orderViewControllers.count > prevIndex else
        {
            return nil
        }
        
        guard prevIndex >= 0 else {
            return orderViewControllers.last
        }
        
        return orderViewControllers[prevIndex]
      
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let firstvc = viewControllers?.first,
            let index = orderViewControllers.index(of: firstvc) {
            introPageViewControllerDelegate?.introPageViewController(self, didUpdatePageIndex: index)
        }
    }
    /*func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
