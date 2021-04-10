//
//  StockDetailViewController.swift
//  StockDemo
//
//  Created by Do Trung Dung on 4/10/21.
//

import UIKit
import SwiftChart
import Kingfisher

class StockDetailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblindustry: UILabel!
    @IBOutlet weak var lblSector: UILabel!
    @IBOutlet weak var lblDiv: UILabel!
    @IBOutlet weak var lblChange: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var mySegment: UISegmentedControl!
    
    @IBOutlet weak var myChart: Chart!
    @IBOutlet weak var btnFav: UIButton!
    var detailViewModel: DetailStockViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayValue()
        getData()
        if (detailViewModel != nil) {
            detailViewModel?.update = { status  in
                self.displayChart()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func displayValue() {
        if (self.detailViewModel != nil) {
            self.lblSymbol.text = self.detailViewModel?.stock?.symbol
            self.lblName.text = self.detailViewModel?.stock?.name
            self.lblPrice.text = "\(self.detailViewModel?.stock?.price ?? 0)"
            self.lblChange.text = "\(self.detailViewModel?.stock?.changes ?? 0)"
            self.lblDiv.text = "\(self.detailViewModel?.stock?.lastDiv ?? 0)"
            self.lblSector.text = self.detailViewModel?.stock?.sector
            self.lblindustry.text = self.detailViewModel?.stock?.industry
            if (detailViewModel?.stock?.image != nil && detailViewModel?.stock?.image.count != 0) {
                image.kf.setImage(with:  URL(string: detailViewModel?.stock?.image ?? ""))
            } else {
                image.image = UIImage(named: "placeHolder")
            }
            
            if detailViewModel?.stock?.isFavourite == true {
                self.btnFav.setImage(UIImage(named: "bookmarkSelected"), for: .normal)
            } else {
                self.btnFav.setImage(UIImage(named: "bookmark"), for: .normal)

            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func displayChart() {
        let chart = Chart()
        var arrays = [Double]()
        switch mySegment.selectedSegmentIndex {
        case 0:
            self.detailViewModel?.stock3Months?.forEach({ (model) in
                arrays.append(model.close ?? 0)
            })
            break
        case 1:
            self.detailViewModel?.stock6Months?.forEach({ (model) in
                arrays.append(model.close ?? 0)
            })
            break
        case 2:
            self.detailViewModel?.stock1Year?.forEach({ (model) in
                arrays.append(model.close ?? 0)
            })
            break
        case 3:
            self.detailViewModel?.stock3Years?.forEach({ (model) in
                arrays.append(model.close ?? 0)
            })
            break
        default:
            break
        }
        
        let series = ChartSeries(arrays)
        series.color = ChartColors.greenColor()
        chart.add(series)
        self.myChart = chart
    }
    
    func getData() {
        switch mySegment.selectedSegmentIndex {
        case 0:
            if detailViewModel?.stock3Months == nil {
                detailViewModel?.fetchStockListForTime(type: 0)
            }
            break
        case 1:
            if detailViewModel?.stock6Months == nil {
                detailViewModel?.fetchStockListForTime(type: 1)
            }
            break
        case 2:
            if detailViewModel?.stock1Year == nil {
                detailViewModel?.fetchStockListForTime(type: 2)
            }
            break
        case 3:
            if detailViewModel?.stock3Years == nil {
                detailViewModel?.fetchStockListForTime(type: 3)
            }
            break
        default:
            break
        }
    }
    
    @IBAction func changeTarget(_ sender: Any) {
        getData()
    }
    
}
