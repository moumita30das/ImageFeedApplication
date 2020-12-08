//
//  ViewController.swift
//  ImageFeedApplication
//
//  Created by Moumita Biswas on 29/11/20.
//

import UIKit

protocol DisplayImageFromPresenter:class {
    func displayImage(imageList: [Image])
}

class ViewController: UIViewController {
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!{
        didSet {
            activityIndicator.isHidden = true
        }
    }
    @IBOutlet weak var imageListTableView: UITableView!
    var interactor: FetchImageListInteractor? = nil
    var images:[Image] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadImageList()
        // Do any additional setup after loading the view.
    }

    private func loadImageList(){
        showLoader()
        interactor?.imageFeedFromServer()
    }
    
    private func setup(){
        let viewController = self
        let interactor = ImageFeedInteractor()
        let presenter = ImageFeedPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        imageListTableView.delegate = self
        imageListTableView.dataSource = self
        imageListTableView.tableFooterView = UIView()
    
    }
    
    private func showLoader(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
   
    private func hideLoader(){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}

extension ViewController:DisplayImageFromPresenter {
    func displayImage(imageList: [Image]){
        images = imageList
        DispatchQueue.main.async {
            self.imageListTableView.reloadData()
            self.hideLoader()
        }
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImageTableViewCell
        let imageData = images[indexPath.row]
        imageCell.updateCell(imageInfo:imageData)
        
        
        return imageCell
    }
    
    
}
