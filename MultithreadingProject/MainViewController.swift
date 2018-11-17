//
//  MainViewController.swift
//  TableViewLesson2
//
//  Created by Ильдар Залялов on 01/10/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import UIKit

//MARK: - working with table
class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    /// Идентификатор ячейки
    fileprivate let cellIdentifier = "cell"
    
    /// массив постов
    var postsArray = [PostModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///заполняем массив постами
       postsArray = DataManager.sharedInstance.postsArray
        /// Делаем размер ячейки динамичным
        tableView.estimatedRowHeight = 400
        /// Добавляю рефрешер в таблице
        tableView.addSubview(refreshControl)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CustomTableViewCell
        cell.configureCell(post: postsArray[indexPath.row],index: indexPath.row, delegate: self)
        
        return cell
    }
    
    // MARK: - Refreshing
    /// обаботчик свайпа таблицы
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(MainViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.gray
        
        return refreshControl
    }()
    
    /// метод вызывающийся при свайпе таблицы
    ///
    /// - Parameter refreshControl: UIRefreshControl
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        showToast(message: "Обновлено!")
        refreshControl.endRefreshing()
    }
    
    /// Отображение сообщения
    ///
    /// - Parameter message: String text
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

    // MARK: - Navigation
    /// обработчик нажатия на элемент таблицы
    ///
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: postsArray[indexPath.row])
        
    }
    
    /// Обработка нажатия на шэринг кнопку
    ///
    /// - Parameter index: индекс элемента
    func didPressInfoButton(index: Int) {
          performSegue(withIdentifier: "shareSegue", sender: postsArray[index])
    }
    
    /// подктовка объектов класса для отправки
    ///
    /// - Parameters:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue", let post = sender as? PostModel {
            let destinationController = segue.destination as! PostViewController
            destinationController.post = post
        }
        
        if segue.identifier == "shareSegue", let post = sender as? PostModel {
            let destinationController = segue.destination as! ShareViewController
            destinationController.post = post
        }
    }
}
