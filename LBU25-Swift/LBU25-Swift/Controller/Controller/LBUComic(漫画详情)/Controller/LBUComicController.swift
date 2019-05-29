//
//  LBUComicController.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/14.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit

protocol LBUComicViewWillEndDraggingDelegate: class {
    func comicWillEndDragging(_ scrollView: UIScrollView)
}

class LBUComicController: LBUBaseController {
    
    private var comicid: Int = 0
    
    private lazy var mainScrollView: UIScrollView = {
        let mainScrollView = UIScrollView()
        mainScrollView.delegate = self
        return mainScrollView
    }()
    
    private lazy var detailVC: LBUContentDetailController = {
        let detailVC = LBUContentDetailController()
        detailVC.delegate = self
        return detailVC
    }()

    private lazy var chapterVC: LBUChapterController = {
        let chapterVC = LBUChapterController()
        chapterVC.delegate = self
        return chapterVC
    }()
    
    private lazy var navigationBarY: CGFloat = {
        return navigationController?.navigationBar.frame.maxY ?? 0
    }()
    
    private lazy var commentVC: LBUCommentController = {
        let commentVC = LBUCommentController()
        commentVC.delegate = self
        return commentVC
    }()
    
    private lazy var pageVC: LBUPageController = {
        return LBUPageController(titles: ["详情", "目录", "评论"],
                                   vcs: [detailVC, chapterVC, commentVC],
                                   pageStyle: .topTabBar)
    }()
    
    private lazy var headView: LBUComicHeadView = {
        return LBUComicHeadView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: navigationBarY + 150))
    }()
    
    private var detailStatic: LBUDetailStaticModel?
    private var detailRealtime: LBUDetailRealtimeModel?
    
    
    convenience init(comicid: Int) {
        self.init()
        self.comicid = comicid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .top
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.changeOrientationTo(landscapeRight: false)
        loadData()
    }
    
    
    private func loadData() {
        
        let grpup = DispatchGroup()
        
        grpup.enter()
        ApiLoadingProvider.request(LBUApi.detailStatic(comicid: comicid),
                                   model: LBUDetailStaticModel.self) { [weak self] (detailStatic) in
                                    self?.detailStatic = detailStatic
                                    self?.headView.detailStatic = detailStatic?.comic
                                    
                                    self?.detailVC.detailStatic = detailStatic
                                    self?.chapterVC.detailStatic = detailStatic
                                    self?.commentVC.detailStatic = detailStatic

                                    ApiProvider.request(LBUApi.commentList(object_id: detailStatic?.comic?.comic_id ?? 0,
                                                                         thread_id: detailStatic?.comic?.thread_id ?? 0,
                                                                         page: -1),
                                                        model: LBUCommentListModel.self,
                                                        completion: { [weak self] (commentList) in
                                                            self?.commentVC.commentList = commentList
                                                            grpup.leave()
                                    })
        }
        
        grpup.enter()
        ApiProvider.request(LBUApi.detailRealtime(comicid: comicid),
                            model: LBUDetailRealtimeModel.self) { [weak self] (returnData) in
                                self?.detailRealtime = returnData
                                self?.headView.detailRealtime = returnData?.comic
                                
                                self?.detailVC.detailRealtime = returnData
                                self?.chapterVC.detailRealtime = returnData
                                
                                grpup.leave()
        }
        
        grpup.enter()
        ApiProvider.request(LBUApi.guessLike, model: LBUGuessLikeModel.self) { (returnData) in
            self.detailVC.guessLike = returnData
            grpup.leave()
        }
        
        grpup.notify(queue: DispatchQueue.main) {
            self.detailVC.reloadData()
            self.chapterVC.reloadData()
            self.commentVC.reloadData()
        }
    }
    
    override func setupLayout(){
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.usnp.edges).priority(.low)
            make.top.equalToSuperview()
        }
        
        let contentView = UIView()
        mainScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(-navigationBarY)
        }
        
        addChild(pageVC)
        contentView.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { make in make.edges.equalToSuperview() }
        
        mainScrollView.parallaxHeader.view = headView
        mainScrollView.parallaxHeader.height = navigationBarY + 150
        mainScrollView.parallaxHeader.minimumHeight = navigationBarY
        mainScrollView.parallaxHeader.mode = .fill
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationController?.barStyle(.clear)
        mainScrollView.contentOffset = CGPoint(x: 0, y: -mainScrollView.parallaxHeader.height)
    }
}

extension LBUComicController: UIScrollViewDelegate, LBUComicViewWillEndDraggingDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= -scrollView.parallaxHeader.minimumHeight {
            navigationController?.barStyle(.theme)
            navigationItem.title = detailStatic?.comic?.name
        } else {
            navigationController?.barStyle(.clear)
            navigationItem.title = ""
        }
    }
    
    func comicWillEndDragging(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            mainScrollView.setContentOffset(CGPoint(x: 0,
                                                    y: -self.mainScrollView.parallaxHeader.minimumHeight),
                                            animated: true)
        } else if scrollView.contentOffset.y < 0 {
            mainScrollView.setContentOffset(CGPoint(x: 0,
                                                    y: -self.mainScrollView.parallaxHeader.height),
                                            animated: true)
        }
    }
}
