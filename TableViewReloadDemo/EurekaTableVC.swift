//
//  EurekaTableVC.swift
//  TableViewReloadDemo
//
//  Created by Daniel Yang on 2021/7/6.
//

import UIKit
import Eureka

class EurekaTableVC: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section("Number formatters")
            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Currency style"
                $0.value = 2015
            }
            <<< DecimalRow(){
                $0.title = "Scientific style"
                $0.value = 2015
                let formatter = NumberFormatter()
                formatter.locale = .current
                formatter.numberStyle = .scientific
                $0.formatter = formatter
            }
            <<< IntRow(){
                $0.title = "Spell out style"
                $0.value = 2015
                let formatter = NumberFormatter()
                formatter.locale = .current
                formatter.numberStyle = .spellOut
                $0.formatter = formatter
            }
            +++ Section("Date formatters")
            <<< DateRow(){
                $0.title = "Short style"
                $0.value = Date()
                let formatter = DateFormatter()
                formatter.locale = .current
                formatter.dateStyle = .short
                $0.dateFormatter = formatter
            }
            <<< DateRow(){
                $0.title = "Long style"
                $0.value = Date()
                let formatter = DateFormatter()
                formatter.locale = .current
                formatter.dateStyle = .long
                $0.dateFormatter = formatter
            }
            +++ Section("Other formatters")
            <<< DecimalRow(){
                $0.title = "Energy: Jules to calories"
                $0.value = 100.0
                let formatter = EnergyFormatter()
                $0.formatter = formatter
            }
            <<< IntRow(){
                $0.title = "Weight: Kg to lb"
                $0.value = 1000
                $0.formatter = MassFormatter()
        }
    }
}
