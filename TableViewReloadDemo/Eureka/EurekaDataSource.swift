//
//  EurekaDataSource.swift
//  TableViewReloadDemo
//
//  Created by Daniel Yang on 2021/7/13.
//

import Eureka

class EurekaDataSource {
    private var nameNumber = 0
    private var ageNumber = 0
        
    var infoSection = Section("Info")
    var listSection = Section("List")

    lazy var name = LabelRow() {
        $0.title = "name"
        $0.value = "Eureka"
        $0.disabled = true
    }.cellUpdate {
        self.nameNumber += 1
        $1.title = "name \(self.nameNumber)"
    }.onChange {
        let seq = sequence(first: $0.cell) { $0?.next }
        if let vc = seq.first(where: { $0 is UIViewController }) as? UIViewController {
            vc.title = $0.value
        }
    }

    lazy var age = IntRow() {
        $0.title = "age"
        $0.value = ageNumber
        $0.disabled = true
    }.cellUpdate {
        self.ageNumber += 1
        $1.value = self.ageNumber
    }
    
    lazy var list = LabelRow() {
        $0.title = "list"
        $0.value = "original"
    }

    init(_ form: inout Eureka.Form) {
        infoSection += [name, age]
        listSection += [list]
        form += [infoSection, listSection]
    }
    
    @objc func mockRandomAddMsgUpdate() {
        let row = LabelRow() {
            $0.title = "new list"
            $0.value = randomStr()
        }.cellSetup {
            $1.cell.textLabel?.numberOfLines = 0
        }
        let index = Int.random(in: 0..<listSection.count)
        listSection.insert(row, at: index)
    }

    @objc func mockRandomChangeMsgUpdate() {
        name.value = randomStr()
        name.updateCell()
    }
}

func randomStr() -> String {
    let arr = "mockRandomChangeMsgUpdate".map { "\($0)" }
    let index = Int.random(in: 0..<arr.count)
    return arr[0..<max(index,1)].joined()
}
