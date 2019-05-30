//
//  LBUUpdateListController.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/30.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit

class LBUUpdateListController: LBUBaseController {

    private var argCon: Int = 0
    private var argName: String?
    private var argValue: Int = 0
    private var page: Int = 1
    
    private var comicList = [LBUComicModel]()
    private var spinnerName: String = ""
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.background
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: LBUUpdateTVCell.self)
        tableView.uHead = URefreshHeader { [weak self] in self?.loadData(more: false) }
        tableView.uFoot = URefreshFooter { [weak self] in self?.loadData(more: true) }
        tableView.uempty = UEmptyView { [weak self] in self?.loadData(more: false) }
        return tableView
    }()
    
    convenience init(argCon: Int = 0, argName: String?, argValue: Int = 0) {
        self.init()
        self.argCon = argCon
        self.argName = argName
        self.argValue = argValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(more: false)
    }
    
    @objc private func loadData(more: Bool) {
        page = (more ? ( page + 1) : 1)
        ApiLoadingProvider.request(LBUApi.comicList(argCon: argCon, argName: argName ?? "", argValue: argValue, page: page),
                                   model: LBUComicListModel.self) { [weak self] (returnData) in
                                    self?.tableView.uHead.endRefreshing()
                                    if returnData?.hasMore == false {
                                        self?.tableView.uFoot.endRefreshingWithNoMoreData()
                                    } else {
                                        self?.tableView.uFoot.endRefreshing()
                                    }
                                    self?.tableView.uempty?.allowShow = true
                                    
                                    if more == false { self?.comicList.removeAll() }
                                    self?.comicList.append(contentsOf: returnData?.comics ?? [])
                                    self?.tableView.reloadData()
                                    
                                    guard let defaultParameters = returnData?.defaultParameters else { return }
                                    self?.argCon = defaultParameters.defaultArgCon
                                    guard let defaultConTagType = defaultParameters.defaultConTagType else { return }
                                    self?.spinnerName = defaultConTagType
        }
    }
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }
    }
}

extension LBUUpdateListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: LBUUpdateTVCell.self)
        cell.model = comicList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LBUBaseController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

