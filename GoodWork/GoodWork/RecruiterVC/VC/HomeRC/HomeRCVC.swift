//
//  HomeRCVC.swift
//  GoodWork
//
//  Created by Gaurav Jani on 24/04/23.
//

import UIKit
import NotificationBannerSwift
import SwiftyAttributes
import Charts

class HomeRCVC: DemoBaseViewController {
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var notificationImageView: UIImageView!
    @IBOutlet weak var notificationBGView: UIView!
    
    @IBOutlet weak var startPostingBGView: UIView!
    @IBOutlet weak var startPostLabel: UILabel!
    @IBOutlet weak var jobRequestLabel: UILabel!
    @IBOutlet weak var startPostingImageView: UIImageView!
    @IBOutlet weak var pluseBgView: UIView!
    
    @IBOutlet weak var jobTypeCollectionView: UICollectionView!
    
    @IBOutlet weak var latestNotiesTableView: UITableView!
    @IBOutlet weak var latestNotiesLabel: UILabel!
    
    @IBOutlet weak var notiesBgView: UIView!
    @IBOutlet weak var notiesShadowView: UIView!
    
    @IBOutlet weak var jobStatusBgView: UIView!
    @IBOutlet weak var jobStatusShadowView: UIView!
    @IBOutlet weak var jobStatusTitleLabel: UILabel!
    
    @IBOutlet var chartView: BarChartView!
    
    @IBOutlet weak var latestNotiesBgViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var ShadowViewHeightCons: NSLayoutConstraint!
    
    let jobTypeArray = ["Permanent", "Travel", "Per Diem", "Local"]
    
    var isNewUserLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GoodWorkAppColor.appBGPink
        self.setUPUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.graphInit()
        self.homeScreenAPI()
        self.isNewUserLogin = true
    }
    
    func setUPUI(){
        
        self.view.backgroundColor =  GoodWorkAppColor.appBGPink
        
        self.profileImageView.image = UIImage(named: "profile")
        
        self.userNameLabel.addTitleColorAndFont(title: "Emma Watson", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 18, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.notificationImageView.image = UIImage(named: "notification")
        self.notificationBGView.addRadiusAndBGColour((self.notificationBGView.frame.height / 2), GoodWorkAppColor.appDarkPurple)
        
        self.startPostingBGView.cornerRadiusWithBgColour(18, bgColour: GoodWorkAppColor.appRaisinBlack)
        
        self.startPostLabel.addTitleColorAndFont(title: "Start Posting", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 24, tintColor: GoodWorkAppColor.appWhite)
        
        self.jobRequestLabel.addTitleColorAndFont(title: "Your Job Request", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 24, tintColor: GoodWorkAppColor.appWhite)
        
        self.latestNotiesLabel.addTitleColorAndFont(title: "Latest Noties", fontName: GoodWorkAppFontName.NeueKabelRegular, fontSize: 14, tintColor: GoodWorkAppColor.appCharade)
        
        
        self.pluseBgView.addRadiusAndBGColour((self.pluseBgView.frame.height / 2), GoodWorkAppColor.appGre)
        self.startPostingImageView.image = UIImage(named: "pluseDark")
        
        
        self.notiesBgView.addBorderWidthColour(1, GoodWorkAppColor.appDarkPurple, 6)
        
        self.notiesShadowView.shadowWithRadiusAndColour(6, GoodWorkAppColor.appDavysGrey)
        
        self.jobStatusBgView.addBorderWidthColour(1, GoodWorkAppColor.appDarkPurple, 6)
        
        self.jobStatusShadowView.shadowWithRadiusAndColour(6, GoodWorkAppColor.appDavysGrey)
        
        self.jobStatusTitleLabel.addTitleColorAndFont(title: "Job Status", fontName: GoodWorkAppFontName.NeueKabelBold, fontSize: 20, tintColor: GoodWorkAppColor.appLightPink)
        
        
        self.loadCollectionview()
        self.loadTableView()
        self.buttonActions()
    }
    
}

extension HomeRCVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func loadCollectionview(){
        self.jobTypeCollectionView.register(UINib(nibName: JobTypeCollectionViewCell.reuseCellIdentifier, bundle: nil), forCellWithReuseIdentifier: JobTypeCollectionViewCell.reuseCellIdentifier)
        self.jobTypeCollectionView.delegate = self
        self.jobTypeCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.jobTypeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobTypeCollectionViewCell.reuseCellIdentifier, for: indexPath) as! JobTypeCollectionViewCell
        
        cell.jobTypeLable.text = self.jobTypeArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let leftAndRightPaddings: CGFloat = 0
        let numberOfItemsPerRow: CGFloat = 2.0
        
        let width = (collectionView.frame.width - leftAndRightPaddings)/numberOfItemsPerRow
        
        return CGSize(width: width , height: 140)
    }
}

//MARK:- Button Actions
extension HomeRCVC {
    
    func buttonActions(){
        self.profileButton.addTarget(self, action: #selector(self.profileButtonPressed(_:)), for: .touchUpInside)
        
        self.notificationButton.addTarget(self, action: #selector(self.notificationButtonPressed(_:)), for: .touchUpInside)
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton){
        print("profileButtonPressed")
        guard let vc = recruiterStoryboard.instantiateViewController(withIdentifier: ProfileRCVC.storyBoardIdentifier) as? ProfileRCVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func notificationButtonPressed(_ sender: UIButton){
        print("notificationButtonPressed")
        self.notificationBanner(AlertMassage.comingSoon.rawValue)
    }
}

extension HomeRCVC : shoTabBarVC{
    
    func shoTabBarVC() {
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension HomeRCVC : UITableViewDelegate, UITableViewDataSource {
    
    func loadTableView(){
        
        self.latestNotiesTableView.register(UINib(nibName: LatestNotiesTableViewCell.reuseCellIdentifier, bundle: nil), forCellReuseIdentifier: LatestNotiesTableViewCell.reuseCellIdentifier)
        
        self.latestNotiesTableView.delegate = self
        self.latestNotiesTableView.dataSource = self
        
        
        self.latestNotiesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LatestNotiesTableViewCell.reuseCellIdentifier, for: indexPath) as! LatestNotiesTableViewCell
        cell.dotLineView.isHidden = false
        if indexPath.row == 0{
            cell.dateLable.text = "Monday, 6th April 2023"
            cell.descriptionLable.text = "Alex Beth has successfully accepted job request"
            cell.statusBGView.backgroundColor = GoodWorkAppColor.appDeYork
            cell.statusLable.text = "Accepted"
            
            cell.alertImageView.image = UIImage(named: "Approval")
            cell.alertImgHeightConstrain.constant = 24
            cell.statusLable.addTitleColorAndFont(title: "Accepted", fontName: GoodWorkAppFontName.PoppinsSemiBold, fontSize: 11, tintColor: GoodWorkAppColor.appDarkPurple)
        }else if indexPath.row == 1{
            cell.dateLable.text = "Thursday, 24th April 2023"
            cell.descriptionLable.text = "Update your Profile"
            cell.statusBGView.backgroundColor =  GoodWorkAppColor.appRed
            cell.statusLable.addTitleColorAndFont(title: "Pending", fontName: GoodWorkAppFontName.PoppinsSemiBold, fontSize: 11, tintColor: GoodWorkAppColor.appWhite)
            
            cell.alertImageView.image = UIImage(named: "redAlert")
            cell.alertImgHeightConstrain.constant = 17
        }else if indexPath.row == 2{
            cell.dateLable.text = "Monday, 13th April  2013"
            cell.descriptionLable.text = "13+ Applicants applied to your  posted job"
            cell.statusBGView.backgroundColor = GoodWorkAppColor.appPorcelain
            cell.dotLineView.isHidden = true
            cell.statusLable.addTitleColorAndFont(title: "New Application", fontName: GoodWorkAppFontName.PoppinsSemiBold, fontSize: 11, tintColor: GoodWorkAppColor.appCharade)
            
            cell.alertImageView.image = UIImage(named: "Terms")
            cell.alertImgHeightConstrain.constant = 24
        }
        
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        print("didSelectRowAt \(indexPath.row)")
        
    }
}

extension HomeRCVC {
    
    
    func graphInit(){
        
        self.setup(barLineChartView: chartView)
        
        chartView.delegate = self
        
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = false
        
        chartView.maxVisibleCount = 60
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        xAxis.labelCount = 7
        xAxis.valueFormatter = DayAxisValueFormatter(chart: chartView)
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.negativeSuffix = ""
        leftAxisFormatter.positiveSuffix = ""
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.labelCount = 6
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelPosition = .outsideChart
        leftAxis.spaceTop = 0.15
        leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
        
        let rightAxis = chartView.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.labelCount = 6
        rightAxis.valueFormatter = leftAxis.valueFormatter
        rightAxis.spaceTop = 0.15
        rightAxis.axisMinimum = 0
        
        let l = chartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .circle
        l.formSize = 9
        l.font = UIFont(name: GoodWorkAppFontName.PoppinsRegular.rawValue, size: 12)!
        l.xEntrySpace = 4
        
        self.setDataCount(4, range: 20)
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let start = 0
        
        let vly = [12.0,8.0,24.0,15.0,21.0]
        
        let yVals = (start..<start+count+1).map { (i) -> BarChartDataEntry in
            
            //            let mult = range + 1
            
            //            let val = Double(arc4random_uniform(mult))
            
            if arc4random_uniform(100) < 25 {
                return BarChartDataEntry(x: Double(i), y: vly[Int(i)], icon: UIImage(named: "icon"))
            } else {
                return BarChartDataEntry(x: Double(i), y: vly[Int(i)])
            }
        }
        
        var set1: BarChartDataSet! = nil
        if let set = chartView.data?.first as? BarChartDataSet {
            set1 = set
            set1.replaceEntries(yVals)
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        } else {
            set1 = BarChartDataSet(entries: yVals, label: "")
            set1.colors = [GoodWorkAppColor.appBlizzardBlue,GoodWorkAppColor.appSail,GoodWorkAppColor.appBlue,GoodWorkAppColor.appHalfBaked,GoodWorkAppColor.appMalibu]
            
            set1.drawValuesEnabled = false
            
            let data = BarChartData(dataSet: set1)
            data.setValueFont(UIFont(name: GoodWorkAppFontName.PoppinsRegular.rawValue, size: 12)!)
            data.barWidth = 0.5
            
            chartView.rightAxis.enabled = false
            chartView.legend.enabled = false
            chartView.xAxis.gridColor = .clear
            
            chartView.data = data
        }
    }
}

extension HomeRCVC{
    
    func homeScreenAPI(){
        
        var mdl = HomeInfoRequestRC()
        mdl.user_id = _userDefault.string(forKey: UserDefaultKeys.user_id.rawValue) ?? ""
        
        print("mdl: \(mdl)")
        
        self.startLoading()
        
        LoginDataManager.shared.homeInfoRequestRequestRCAPI(rqst: mdl) { (dict, error) in
            
            DispatchQueue.main.async {
                
                let response = dict as? [String : Any] ??  [String : Any]()
                
                if response["api_status"] as? String ?? "" == "1" {
                    print("response:: \(response)")
                    
                }else{
                    print("False")
                    self.notificationBanner(response["message"] as? String ?? "")
                }
                self.stopLoading()
            }
        }
    }
}
