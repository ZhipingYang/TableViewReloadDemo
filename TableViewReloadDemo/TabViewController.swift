//
//  ViewController.swift
//  TableViewReloadDemo
//
//  Created by Daniel Yang on 2021/7/6.
//

import UIKit
import SwiftUI

class TabViewController: UITabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let diffVC = UINavigationController(rootViewController:DataSourceDiffTableVC()).then { $0.tabBarItem.title = "DiffDataSource" }
        let swiftVC = UINavigationController(rootViewController:UIHostingController(rootView: SwiftUIView())).then { $0.tabBarItem.title = "SwiftUI" }

        viewControllers? += [diffVC, swiftVC]
        setViewControllers(viewControllers, animated: true)
    }
}
