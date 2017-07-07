//
//  UserViewController.swift
//  Whispme
//
//  Created by admin on 7/7/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class UserViewController: UIPageViewController {

    var contentPageViewControllers: [UIViewController] = []
    let pagesCount = 2
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataSource = self
        for page in 1...pagesCount {
            contentPageViewControllers.append(newViewController(forPage: page))
        }
        if let firstViewController = self.contentPageViewControllers.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }

    }

    private func newViewController(forPage page: Int) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnBoardPage\(page)")
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
extension UserViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.contentPageViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < self.contentPageViewControllers.count else {
            return nil
        }
        return self.contentPageViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.contentPageViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        return self.contentPageViewControllers[previousIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return contentPageViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        let firstViewController = viewControllers?.first
        guard let viewControllerIndex = self.contentPageViewControllers.index(of: firstViewController!) else {
            return 0
        }
        return viewControllerIndex
    }
}
