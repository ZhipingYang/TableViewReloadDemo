//
//  DataSourceController.swift
//  TableViewReloadDemo
//
//  Created by Daniel Yang on 2021/7/12.
//

import Foundation
import Combine

enum DiffSection: CaseIterable {
    case history, socket
}

struct Message: Hashable {
    var userName: String
    let msgContent: String
    let identifier = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

class DataSourceController {
    typealias UpdateHandler = (DataSourceController) -> Void
    
    private let updateInterval = 100
    
    private let allMockMsg = (0...10).map {
        Message(userName: "name:\($0)", msgContent: "content message:\($0)")
    }

    var didChange: AnyPublisher<[Message], Never>
    private let _didChange = PassthroughSubject<[Message], Never>()
    
    lazy var displayMsg = self.allMockMsg
    
    init() {
        self.didChange = _didChange.eraseToAnyPublisher()
        mockRandomChangeMsgUpdate()
    }

    @objc func mockRandomAddMsgUpdate() {
        let newIndex = Int.random(in: 0..<allMockMsg.count)
        let item = Message(userName: "name:\(newIndex)", msgContent: "content message:\(newIndex)")

        displayMsg.append(item)
        _didChange.send(displayMsg)
    }

    @objc func mockRandomChangeMsgUpdate() {
        let newIndex = Int.random(in: 0..<displayMsg.count)
        let contentIndex = Int.random(in: 0..<displayMsg.count)
        displayMsg[newIndex] = Message(userName: "newName:\(contentIndex)", msgContent: "new content message:\(contentIndex)")
        _didChange.send(displayMsg)
    }
}
