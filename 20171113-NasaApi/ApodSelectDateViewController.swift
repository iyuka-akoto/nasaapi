//
//  ApodSelectDateViewController.swift
//  20171113-NasaApi
//
//  Created by Iyuka on 2017/11/14.
//  Copyright © 2017年 Iyuka. All rights reserved.
//

import UIKit

class ApodSelectDateViewController: UIViewController {

    @IBOutlet weak var selectDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // 日付フォーマット指定
        let selectedDate: DateFormatter = DateFormatter()
        selectedDate.dateFormat = "yyyy-MM-dd"
        
        // ApodShowResultViewControllerの日付代入変数へ渡す
        let apodShowResultVC = segue.destination as! ApodShowResultViewController
        apodShowResultVC.selectedDate = selectedDate.string(from: selectDate.date)
    }
    

}
