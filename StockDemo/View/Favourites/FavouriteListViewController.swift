//
//  FavouriteListViewController.swift
//  StockDemo
//
//  Created by Do Trung Dung on 4/10/21.
//

import UIKit

class FavouriteListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var stockViewModel = FavouriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "StockListTableViewCell", bundle: nil), forCellReuseIdentifier: "StockListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 115
        tableView.tableFooterView = UIView()
    }
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.stockViewModel.loadData()
        self.stockViewModel.update = {
            if (self.tableView != nil) {
                self.tableView.reloadData()
            }
        }
    }
}

extension FavouriteListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stockViewModel.stocks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : StockListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StockListTableViewCell", for: indexPath) as! StockListTableViewCell
        if (self.stockViewModel.stocks != nil && self.stockViewModel.stocks?.count ?? 0 > indexPath.row) {
            let stock = self.stockViewModel.stocks![indexPath.row]
            cell.cellModel = CellViewModel(stock: stock)
            cell.cellModel?.bindCellViewModelToCell = {[weak self]  status  in
                if (status) {
                    self?.tableView.reloadData()
                    self?.stockViewModel.removeStockFavFromList(stock: stock)
                }
            }
        }
        cell.selectionStyle = .none
        return cell
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < (self.stockViewModel.stocks?.count ?? 0) {
            if let stock = self.stockViewModel.stocks?[indexPath.row] {
                let details = StockDetailViewController(nibName: "StockDetailViewController", bundle: nil)
                let detailModelView = DetailStockViewModel(stock: stock)
                details.detailViewModel = detailModelView
                details.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(details, animated: true)
            }
        }
    }
    
}
