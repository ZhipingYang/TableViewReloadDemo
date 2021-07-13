//
//  EurekaTableVC.swift
//  TableViewReloadDemo
//
//  Created by Daniel Yang on 2021/7/6.
//

import UIKit
import Eureka

class EurekaTableVC: FormViewController {
    
    var dataController: EurekaDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataController = EurekaDataSource(&form)
        configUIElements()
    }

    private func configUIElements() {
        title = "Eureka"

        let addItem = UIBarButtonItem(title: "add",
                                           style: .plain,
                                           target: dataController,
                                           action: #selector(EurekaDataSource.mockRandomAddMsgUpdate))

        let updateItem = UIBarButtonItem(title: "update",
                                              style: .plain,
                                              target: dataController,
                                              action: #selector(EurekaDataSource.mockRandomChangeMsgUpdate))

        navigationItem.rightBarButtonItems = [addItem, updateItem]
    }
}
