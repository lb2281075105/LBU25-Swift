//
//  LBUCommentController.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/14.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit

// 评论
class LBUCommentController: LBUBaseController {

    private var listArray = [LBUCommentViewModel]()
    
    var detailStatic: LBUDetailStaticModel?
    var commentList: LBUCommentListModel? {
        didSet {
            guard let commentList = commentList?.commentList else { return }
            let viewModelArray = commentList.compactMap { (comment) -> LBUCommentViewModel? in
                return LBUCommentViewModel(model: comment)
            }
            listArray.append(contentsOf: viewModelArray)
        }
    }
    
    
    weak var delegate: LBUComicViewWillEndDraggingDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: LBUCommentTVCell.self)
        tableView.uFoot = URefreshFooter { self.loadData() }
        return tableView
        
    }()
    
    func loadData() {
        ApiProvider.request(LBUApi.commentList(object_id: detailStatic?.comic?.comic_id ?? 0,
                                             thread_id: detailStatic?.comic?.thread_id ?? 0,
                                             page: commentList?.serverNextPage ?? 0),
                            model: LBUCommentListModel.self) { (returnData) in
                                if returnData?.hasMore == true {
                                    self.tableView.uFoot.endRefreshing()
                                } else {
                                    self.tableView.uFoot.endRefreshingWithNoMoreData()
                                }
                                self.commentList = returnData
                                self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {make in make.edges.equalTo(self.view.usnp.edges) }
    }
}

extension LBUCommentController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        delegate?.comicWillEndDragging(scrollView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return listArray[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: LBUCommentTVCell.self)
        cell.viewModel = listArray[indexPath.row]
        return cell
    }
}

