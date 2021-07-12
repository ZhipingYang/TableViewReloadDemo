//
//  DataSourceDiffTableVC.swift
//  TableViewReloadDemo
//
//  Created by Daniel Yang on 2021/7/6.
//

import UIKit
import Then

class DataSourceDiffTableVC: UIViewController {

    static let reuseIdentifier = "reuse-identifier"

    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(UITableViewCell.self, forCellReuseIdentifier: DataSourceDiffTableVC.reuseIdentifier)
    }
    
    lazy var dataSource = UITableViewDiffableDataSource<DiffSection, Message>(tableView: tableView) {
        let cell = $0.dequeueReusableCell(withIdentifier: DataSourceDiffTableVC.reuseIdentifier, for: $1)
        cell.textLabel?.text = "\($2.userName): \($2.msgContent)"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    var currentSnapshot = NSDiffableDataSourceSnapshot<DiffSection, Message>()
    var dataSourceController = DataSourceController()
    var hodler: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Room"
        configureUI()
        configureDataSource()
        updateUI()
    }

    func configureUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let addItem = UIBarButtonItem.init(title: "add", style: .plain, target: dataSourceController, action: #selector(DataSourceController.mockRandomAddMsgUpdate))
        let updateItem = UIBarButtonItem.init(title: "update", style: .plain, target: dataSourceController, action: #selector(DataSourceController.mockRandomChangeMsgUpdate))
        navigationItem.rightBarButtonItems = [addItem, updateItem]
    }

    func configureDataSource() {
        hodler = dataSourceController.didChange.sink { [weak self] value in
            guard let self = self else { return }
            self.updateUI()
        }
        dataSource.defaultRowAnimation = .right
    }

    func updateUI(animated: Bool = true) {
        currentSnapshot = NSDiffableDataSourceSnapshot<DiffSection, Message>()
        
        let items = dataSourceController.displayMsg
        currentSnapshot.appendSections([.socket])
        currentSnapshot.appendItems(items, toSection: .socket)
        
        dataSource.apply(currentSnapshot, animatingDifferences: animated)
        
        let lastIndex = IndexPath(row: currentSnapshot.numberOfItems(inSection: .socket) - 1, section: 0)
        tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
    }
}


