//
//  LabelFoldViewController.swift
//  RZColorfulSwift_Example
//
//  Created by rztime on 2022/1/11.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class LabelFoldViewController: UIViewController {
    let tableView = UITableView.init(frame: .zero, style: .plain)
    var items: [LabelFoldModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        
        var i = 100
        while i > 0 {
            items.append(.init())
            i -= 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension LabelFoldViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LabelFoldCell = (tableView.dequeueReusableCell(withIdentifier: "cell") as? LabelFoldCell) ?? LabelFoldCell.init(style: .value1, reuseIdentifier: "cell")
        let item = items[indexPath.row]
        cell.label.rz.set(attributedString: item.attributedString,
                          maxLine: 4,
                          maxWidth: self.view.frame.size.width - 20,
                          isFold: item.isFold,
                          showAllText: item.showAll,
                          showFoldText: item.showFold)
        cell.label.rz.tapAction { [weak self] (label, tapActionId, range) in
            let item = self?.items[label.tag]
            if tapActionId == "all" {
                item?.isFold = false
            } else if tapActionId == "fold" {
                item?.isFold = true
            }
            self?.tableView.reloadData()
        }
        cell.label.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
}

class LabelFoldModel {
    var isFold = true
    let attributedString = NSAttributedString.rz.colorfulConfer { confer in
        let text = "<p>测试文本</p><p>测试文本</p>"
        confer.htmlString("<p>测试文本</p><p>测试文本</p>")?.font(.systemFont(ofSize: 20)).textColor(.red)
    }
    let showAll = NSAttributedString.rz.colorfulConfer { confer in
        confer.text("...全部")?.textColor(.red).font(.systemFont(ofSize: 16)).tapActionByLable("all")
    }
    let showFold = NSAttributedString.rz.colorfulConfer { confer in
        confer.text("...折叠")?.textColor(.red).font(.systemFont(ofSize: 16)).tapActionByLable("fold")
    }
}

class LabelFoldCell: UITableViewCell {
    var label = UILabel.init()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
