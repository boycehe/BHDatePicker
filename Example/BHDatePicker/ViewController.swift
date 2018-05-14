//
//  ViewController.swift
//  BHDatePicker
//
//  Created by boycehe.com on 05/09/2018.
//  Copyright (c) 2018 boycehe.com. All rights reserved.
//

import UIKit
import BHDatePicker
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      
    
        let dateView = BHDatePickerView.init(dateStyle: .monthDayHourMinute)
        self.view.addSubview(dateView)
        dateView.snp.makeConstraints { (make) in
        make.top.right.left.bottom.equalTo(self.view)
      }
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

