//
//  LBUSpecialController.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/30.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit

class LBUSpecialController: LBUBaseController {

    private var page: Int = 1
    private var argCon: Int = 0
    
    private var specialList = [LBUComicModel]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.background
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(cellType: LBUSpecialTVCell.self)
        tableView.uHead = URefreshHeader { [weak self] in self?.loadData(more: false) }
        tableView.uFoot = URefreshFooter { [weak self] in self?.loadData(more: true) }
        tableView.uempty = UEmptyView { [weak self] in self?.loadData(more: false) }
        return tableView
    }()
    
    convenience init(argCon: Int = 0) {
        self.init()
        self.argCon = argCon
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(more: false)
    }
    
    @objc private func loadData(more: Bool) {
        page = (more ? ( page + 1) : 1)
        ApiLoadingProvider.request(LBUApi.special(argCon: argCon, page: page), model: LBUComicListModel.self) { [weak self] (returnData) in
            
            self?.tableView.uHead.endRefreshing()
            if returnData?.hasMore == false {
                self?.tableView.uFoot.endRefreshingWithNoMoreData()
            } else {
                self?.tableView.uFoot.endRefreshing()
            }
            self?.tableView.uempty?.allowShow = true
            
            if !more { self?.specialList.removeAll() }
            self?.specialList.append(contentsOf: returnData?.comics ?? [])
            self?.tableView.reloadData()
            
            
            guard let defaultParameters = returnData?.defaultParameters else { return }
            self?.argCon = defaultParameters.defaultArgCon
        }
    }
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in make.edges.equalTo(self.view.usnp.edges) }
    }
    
}

extension LBUSpecialController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specialList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: LBUSpecialTVCell.self)
        cell.model = specialList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = specialList[indexPath.row]
        var html: String?
        if item.specialType == 1 {
            html = "http://www.u17.com/z/zt/appspecial/special_comic_list_v3.html"
        } else if item.specialType == 2{
            html = "http://www.u17.com/z/zt/appspecial/special_comic_list_new.html"
        }
        guard let host = html else { return }
        let path = "special_id=\(item.specialId)&is_comment=\(item.isComment)"
        let url = [host, path].joined(separator: "?")
        let vc = LBUWebController(url: url)
        navigationController?.pushViewController(vc, animated: true)
    }
}
