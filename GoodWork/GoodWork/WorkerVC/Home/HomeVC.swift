//
//  HomeVC.swift
//  GoodWork
//
//  Created by Gaurav Jani on 29/03/23.
//

import UIKit
import SwiftyAttributes
import NotificationBannerSwift

class HomeVC: BaseVC {
    
    static let storyBoardIdentifier = "HomeVC"
    
    @IBOutlet weak var rightSideTopImageView: UIImageView!
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var notificationImageView: UIImageView!
    @IBOutlet weak var exploreLatestJobLabel: UILabel!
    @IBOutlet weak var notificationBGView: UIView!
    
    @IBOutlet weak var latestJobBGView: UIView!
    @IBOutlet weak var latestJobShadowView: UIView!
    @IBOutlet weak var latestJobImageView: UIImageView!
    @IBOutlet weak var latestJobTitle: UILabel!
    
    @IBOutlet weak var popularJobsLable: UILabel!
    
    @IBOutlet weak var popularJobsCollectionView: UICollectionView!
    @IBOutlet weak var recommendedForYouTableView: UITableView!
    
    @IBOutlet weak var recommendedForYouTableViewHeight: NSLayoutConstraint!
    
    //     var exploreNEW = try? JSONDecoder().decode(Json4Swift_Base.self, from: Data())
    
    @IBOutlet weak var noDataLabel: UILabel!
    
    var exploreNEW : Json4Swift_Base?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.latestJobBGView.addBorderWidthColour(2, GoodWorkAppColor.appDarkPurple, 20)
        self.latestJobShadowView.shadow(20)
        self.latestJobImageView.image = UIImage(named: "demoLatestJob")
        self.latestJobImageView.cornerRadius(20)
        
        self.setUPUI()
        //self.nurseProfileAPI()
        self.exploreAPI(false)
    }
    
    func setUPUI(){
        
        self.view.backgroundColor =  GoodWorkAppColor.appBGPink
        
        self.rightSideTopImageView.image = UIImage(named: "homeRightSideTop")
        self.profileImageView.image = UIImage(named: "profileDemo")
        self.profileImageView.addBorderCornerRadius(Int(self.profileImageView.frame.height) / 2, 0, .clear)
        
        
        self.userNameLabel.addTitleColorAndFont(title: "Hi,", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 18, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.notificationImageView.image = UIImage(named: "notification")
        self.notificationBGView.addRadiusAndBGColour((self.notificationBGView.frame.height / 2), GoodWorkAppColor.appDarkPurple)
        
        self.latestJobTitle.addTitleColorAndFont(title: "New Job Opportunities", fontName: GoodWorkAppFontName.NeueKabelRegular, fontSize: 16, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.popularJobsLable.isHidden = true
        self.popularJobsLable.addTitleColorAndFont(title: "Popular jobs", fontName: GoodWorkAppFontName.NeueKabelBold, fontSize: 20, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.noDataLabel.addTitleColorAndFont(title: "No data", fontName: GoodWorkAppFontName.NeueKabelMedium, fontSize: 18, tintColor: GoodWorkAppColor.appDarkPurple)
        
        self.loadCollectionview()
        self.buttonActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.noDataLabel.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.exploreLatestJobLabel.text = ""
        
        let log = "Explore the ".withAttributes([
            .textColor(GoodWorkAppColor.appDarkPurple),
            .font(GoodWorkApp.goodWorkAppFont(GoodWorkAppFontName.NeueKabelMedium, 34))
        ])
        
        let inn = "latest jobs!".withAttributes([
            .textColor(GoodWorkAppColor.appLightPink),
            .font(GoodWorkApp.goodWorkAppFont(GoodWorkAppFontName.NeueKabelMedium, 34))
        ])
        
        let finalString = (log + inn)
        
        self.exploreLatestJobLabel.attributedText = finalString
        self.nurseProfileAPI()
        
        if appDelegate.isFromApplyJob{
            self.appliedJobAlertView()
            appDelegate.isFromApplyJob = false
            self.exploreAPI(true)
        }else{
            self.exploreAPI(false)
        }
     }
}

extension HomeVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func loadCollectionview(){
        self.popularJobsCollectionView.register(UINib(nibName: PopularJobsCollectionCell.reuseCellIdentifier, bundle: nil), forCellWithReuseIdentifier: PopularJobsCollectionCell.reuseCellIdentifier)
        self.popularJobsCollectionView.delegate = self
        self.popularJobsCollectionView.dataSource = self
        
        self.loadTableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //        return self.exploreNEW?.data.popularJobs.count ?? 0
        
        return self.exploreNEW?.data?.popular_jobs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularJobsCollectionCell.reuseCellIdentifier, for: indexPath) as! PopularJobsCollectionCell
        
        cell.updateCellData(self.exploreNEW?.data?.popular_jobs?[indexPath.row])
        cell.appliedNumberLable.isHidden = true
        cell.saveJobButton.tag = indexPath.row
        cell.saveJobButton.addTarget(self, action: #selector(self.saveJobButtonPress), for: .touchUpInside)
        
        cell.applyButton.tag = indexPath.row
        cell.applyButton.addTarget(self, action: #selector(self.learnMoreButtonPress), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewWidth = (self.popularJobsCollectionView.frame.width * 0.8)
        print("self.popularJobsCollectionView.frame.width \(self.popularJobsCollectionView.frame.width)")
        return CGSize(width: collectionViewWidth, height: 178)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("indexPath.row\(indexPath.row)")
    }
    
    @objc func learnMoreButtonPress(_ sender: UIButton){
        print("learnMoreButtonPress")
        if self.exploreNEW?.data?.popular_jobs?[sender.tag].is_applied ?? "" == "1" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: AppliedJobDetailsVC.storyBoardIdentifier) as! AppliedJobDetailsVC
            vc.isFromExplore = true
            vc.selectedJobTypeNo = 1
            vc.selectedJobID = self.exploreNEW?.data?.popular_jobs?[sender.tag].job_id ?? ""
            vc.exploreJobOBJ = self.exploreNEW?.data?.popular_jobs?[sender.tag]
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: JobDetailsVC.storyBoardIdentifier) as? JobDetailsVC else { return }
            vc.selectedJobID = self.exploreNEW?.data?.popular_jobs?[sender.tag].job_id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func saveJobButtonPress(_ sender: UIButton){
        
        var obj = self.exploreNEW?.data?.popular_jobs?[sender.tag]
        
        var isSaved = 0
        
        if obj?.is_saved ?? 0 == 0{
            isSaved = 1
        }else{
            isSaved = 0
        }
        
        self.saveJobAPI(obj?.job_id ?? "", isSaved: isSaved, tagNo: sender.tag)
    }
}

extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func loadTableView(){
        
        self.recommendedForYouTableView.register(UINib(nibName: RecommendedTableViewCell.reuseCellIdentifier, bundle: nil), forCellReuseIdentifier: RecommendedTableViewCell.reuseCellIdentifier)
        self.recommendedForYouTableView.delegate = self
        self.recommendedForYouTableView.dataSource = self
        
        self.recommendedForYouTableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.recommendedForYouTableViewHeight.constant = self.recommendedForYouTableView.contentSize.height + 130
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if self.exploreNEW?.data?.recommended_jobs?.count ?? 0 == 0 {
            
            return UIView()
        }
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        
        let  headerTitleLabel = UILabel()
        headerTitleLabel.frame = CGRect.init(x: 5, y: 0, width: headerView.frame.width-10, height: 30)
        
        headerTitleLabel.addTitleColorAndFont(title: "Recommended for you", fontName: GoodWorkAppFontName.NeueKabelBold, fontSize: 20, tintColor: GoodWorkAppColor.appDarkPurple)
        headerView.backgroundColor = .clear
        headerView.addSubview(headerTitleLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.exploreNEW?.data?.recommended_jobs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RecommendedTableViewCell.reuseCellIdentifier, for: indexPath) as! RecommendedTableViewCell
        
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        print("didSelectRowAt \(indexPath.row)")
    }
}


//MARK:- Button Actions
extension HomeVC {
    
    func buttonActions(){
        self.profileButton.addTarget(self, action: #selector(self.profileButtonPressed(_:)), for: .touchUpInside)
        
        self.notificationButton.addTarget(self, action: #selector(self.notificationButtonPressed(_:)), for: .touchUpInside)
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton){
        print("profileButtonPressed")
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: MyProfileVC.storyBoardIdentifier) as? MyProfileVC else { return }
        vc.obj = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func notificationButtonPressed(_ sender: UIButton){
        print("notificationButtonPressed")
        self.notificationBanner(AlertMassage.comingSoon.rawValue)
    }
}


extension HomeVC{
    
    func exploreAPI(_ isFromApplyJob : Bool){
        self.noDataLabel.isHidden = true
        var mdl = HomeRequest()
        mdl.user_id = _userDefault.string(forKey: UserDefaultKeys.user_id.rawValue) ?? ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if !isFromApplyJob{
                self.startLoading()
            }
            
        }
        
        LoginDataManager.shared.explore(rqst: mdl) { (dict, error) in
            
            DispatchQueue.main.async {
                
                let response = dict as? [String : Any] ??  [String : Any]()
                
                if response["api_status"] as? String ?? "" == "1" {
                    
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                        
                        let exploreResp = try JSONDecoder().decode(Json4Swift_Base.self, from: jsonData)
                        
                        self.exploreNEW = exploreResp
                        
                        print("do self.exploreNEW: \(self.exploreNEW)")
                        
                        if self.exploreNEW?.data?.popular_jobs?.count ?? 0 == 0 {
                            self.noDataLabel.isHidden = false
                        }else{
                            self.noDataLabel.isHidden = true
                        }
                        
                        if self.exploreNEW?.api_status == "1"{
                            print("if self.exploreNEW?.api_status")
                        }else{
                            print("falsee")
                        }
                        
                        if self.exploreNEW?.data?.popular_jobs?.count ?? 0 == 0 {
                            self.popularJobsLable.isHidden = true
                        }else{
                            self.popularJobsLable.isHidden = false
                        }
                        
                    }catch{
                        
                        print("error \(error)")
                        print("catch \(error.localizedDescription)")
                    }
                }else{
                    print("False")
                    self.notificationBanner(response["message"] as? String ?? "")
                }
                
                self.popularJobsCollectionView.reloadData()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.stopLoading()
                }
            }
        }
    }
    
    func saveJobAPI(_ jobID : String, isSaved : Int, tagNo : Int){
        
        var mdl = SaveNewJobRequest()
        mdl.nurse_id = appDelegate.nurseProfile?.data?.nurse_id ?? ""
        mdl.job_id = jobID
        
        print("mdl: \(mdl)")
        
        self.startLoading()
        
        LoginDataManager.shared.saveNewJob(rqst: mdl) { (dict, error) in
            
            DispatchQueue.main.async {
                
                let response = dict as? [String : Any] ??  [String : Any]()
                
                if response["api_status"] as? String ?? "" == "1" {
                    
                    self.exploreNEW?.data?.popular_jobs?[tagNo].is_saved = isSaved
                    
                    print("isSaved: \(isSaved)")
//                    self.notificationBanner(response["message"] as? String ?? "")
                    self.popularJobsCollectionView.reloadData()
                    
                    if isSaved == 1{
                        self.saveJobAlertView()
                    }else{
                        self.notificationBanner(response["message"] as? String ?? "")
                    }
                 }else{
                    print("False")
                    self.notificationBanner(response["message"] as? String ?? "")
                }
                
                self.popularJobsCollectionView.reloadData()
                self.stopLoading()
            }
        }
    }
    
    func nurseProfileAPI(){
        
        var mdl = NurseProfileRequest()
        mdl.user_id = _userDefault.string(forKey: UserDefaultKeys.user_id.rawValue) ?? ""
        
        print("mdl: \(mdl)")
        
        LoginDataManager.shared.nurseProfileDetails(rqst: mdl) { (dict, error) in
            
            DispatchQueue.main.async {
                
                let response = dict as? [String : Any] ??  [String : Any]()
                
                if response["api_status"] as? String ?? "" == "1" {
                    print("response:: \(response)")
                    
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                        
                        let nurseProfileResp = try JSONDecoder().decode(NurseProfile.self, from: jsonData)
                        
                        appDelegate.nurseProfile = nurseProfileResp
                        
                        print("do nurseProfile: \(appDelegate.nurseProfile)")
                        
                        if appDelegate.nurseProfile?.api_status == "1"{
                            
                            self.userNameLabel.text = "Hi, \(appDelegate.nurseProfile?.data?.first_name ?? "")!"
                            
                            if appDelegate.nurseProfile?.data?.image ?? "" != ""{
                                
                                self.profileImageView.sd_setImage(with: URL(string: appDelegate.nurseProfile?.data?.image ?? ""), placeholderImage: UIImage(named: ""))
                            }else{
                                self.profileImageView.image = UIImage(named: "profileDemo")
                            }
                            
                        }else{
                            print("falsee")
                        }
                        
                    }catch{
                        print("catch")
                    }
                    
                }else{
                    print("False")
                    self.notificationBanner(response["message"] as? String ?? "")
                }
            }
        }
    }
}

extension HomeVC : updateProfilePhotoPro{
    
    func updateProfilePhotoPro(){
        self.nurseProfileAPI()
        print("updateProfilePhotoPro")
    }
}

protocol updateProfilePhotoPro {
    func updateProfilePhotoPro()
}
