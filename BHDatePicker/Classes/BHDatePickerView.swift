//
//  BHDatePickerView.swift
//  BHDatePicker
//
//  Created by heboyce on 2018/5/9.
//

import UIKit
import SnapKit

public enum BHDateStyle{
 case yearMonthDayHourMinute  //年月日时分
 case monthDayHourMinute      //月日时分
 case yearMonthDay            //年月日
 case yearMonth               //年月
 case monthDay                //月日
 case hourMinute              //时分
}

let kMaxYear = 2099
let kMinYear = 1900

public class BHDatePickerView: UIView {
  
    var datePicker:UIPickerView?
    var bottomView:UIView?
    var yearView:UILabel?
    var doneButton:UIButton?
    var dateStyle:BHDateStyle = .yearMonthDayHourMinute
    var yearArray:Array<String>   = Array()
    var monthArray:Array<String>  = Array()
    var dayArray:Array<String>    = Array()
    var hourArray:Array<String>   = Array()
    var minuteArray:Array<String> = Array()
  
  
 
  convenience public init(dateStyle: BHDateStyle) {
    self.init(dateStyle: dateStyle, scrollToDate: Date.init())
   }
  
  public init(dateStyle: BHDateStyle,scrollToDate:Date){
      super.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
      self.setUpUI()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func configData(){
    
    self.yearArray.removeAll()
    for index in kMinYear ... kMaxYear {
      self.yearArray.append(String(index))
    }
    
    self.monthArray.removeAll()
    self.minuteArray.removeAll()
    self.hourArray.removeAll()
    
    for index in 0 ... 59 {
      
      self.minuteArray.append(String(index))
      
      if index < 24 {
        self.hourArray.append(String(index))
      }
      
      if index > 0 && index <= 12 {
        self.monthArray.append(String(index))
      }
      
    }
    
    for index in 1 ... 12 {
      self.monthArray.append(String(index))
    }
    
    
  }
  
  func setUpUI(){
    
    self.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
    self.bottomView = UIView.init()
    self.bottomView?.backgroundColor = UIColor.red
    self.addSubview(self.bottomView!)
    
    self.bottomView?.snp.makeConstraints({ (make) in
        make.height.equalTo(200)
        make.right.equalTo(self).offset(-10)
        make.left.equalTo(self).offset(10)
        make.bottom.equalTo(self).offset(-10)
    })
    
    self.doneButton = UIButton.init()
    self.bottomView?.addSubview(self.doneButton!)
    self.doneButton?.snp.makeConstraints({ (make) in
      
      make.left.equalTo(self.bottomView!)
      make.right.equalTo(self.bottomView!)
      make.height.equalTo(50)
      make.bottom.equalTo(self.bottomView!)
      
    })
    
    self.yearView = UILabel.init()
    self.bottomView?.addSubview(self.yearView!)
    self.yearView?.backgroundColor = UIColor.blue
    self.yearView?.snp.makeConstraints({ (make) in
    
      make.height.equalTo(200)
      make.right.equalTo(self).offset(-10)
      make.left.equalTo(self).offset(10)
      make.bottom.equalTo(self.doneButton!.snp.top)
      
      
    })
    
    self.datePicker = UIPickerView.init()
    self.datePicker!.showsSelectionIndicator = true
    self.datePicker!.delegate = self
    self.datePicker!.dataSource = self
    self.yearView?.addSubview(self.datePicker!)
   
    
  }
  /*
  func numOfRowsInComponent()->Int{
    
    
  }
 */
  
  func daysOfMonth(month:Int,year:Int)->Int{
    
    let numMonth = month
    let numYear  = year
    let isLeapYear = numYear%4==0 ? ((numYear%100==0) ? (numYear%400==0 ? true:false):true):false;
    
    switch numMonth {
    case 1,3,5,7,8,10,12:
      return 31
    case 4,6,9,11:
      return 30
    case 2:
      if isLeapYear {
        return 29
      }else{
        return 28
      }
    default:
      return 0
    }
    
  }

}

extension BHDatePickerView:UIPickerViewDelegate,UIPickerViewDataSource{
  
  public func numberOfComponents(in pickerView: UIPickerView) -> Int{
    
    switch self.dateStyle {
    
      case .yearMonthDayHourMinute:
        return 5
      case .monthDayHourMinute:
        return 4
      case .yearMonthDay:
        return 3
      case .yearMonth:
        return 2
      case .monthDay:
        return 2
      case .hourMinute:
        return 2
      
  }
    
 }
  

  
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
    return 1
  }
  
  public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
    return 10
  }
  
  public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
    
    let view = UIView.init()
    return view
  }
  
  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
    
  }

}
