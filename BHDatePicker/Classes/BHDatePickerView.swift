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
    var dateStyle:BHDateStyle     = .yearMonthDayHourMinute
    var yearArray:Array<String>   = Array()
    var monthArray:Array<String>  = Array()
    var dayArray:Array<String>    = Array()
    var hourArray:Array<String>   = Array()
    var minuteArray:Array<String> = Array()
    var yearIndex                 = 0
    var monthIndex                = 1
    var dayIndex                  = 1
    var hourIndex                 = 0
    var minuteIndex               = 0
  
  
 
  convenience public init(dateStyle: BHDateStyle) {
    self.init(dateStyle: dateStyle, scrollToDate: Date.init())
   }
  
  public init(dateStyle: BHDateStyle,scrollToDate:Date){
      super.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
      self.setUpUI()
      self.configData()
      var arr:Array<String> = Array.init()
      arr.append("年")
      arr.append("月")
      arr.append("日")
      arr.append("时")
      arr.append("分")
      self.addLabel(titleArray: arr)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func addLabel(titleArray:Array<String>){
    
    for index in 0 ... titleArray.count - 1 {
      
      let label = UILabel.init()
      label.textAlignment = .center
      label.text = titleArray[index]
      label.font = UIFont.systemFont(ofSize: 16)
      label.textColor       = UIColor.black
      label.backgroundColor = UIColor.clear
      self.yearView?.addSubview(label)
      let sepWidth = CGFloat((UIScreen.main.bounds.size.width-20.0)/CGFloat(titleArray.count))
      label.snp.makeConstraints { (make) in
        make.width.equalTo(15)
        make.height.equalTo(15)
        if index == titleArray.count - 1{
          make.left.equalTo(self.yearView!).offset(sepWidth*CGFloat(index+1) - 17.0)
        }else{
          make.left.equalTo(self.yearView!).offset(sepWidth*CGFloat(index+1) - 15.0/2.0)
        }
        make.centerY.equalTo(self.yearView!)
        
      }
      
    }
    
   
    
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
    self.bottomView?.layer.cornerRadius  = 10.0
    self.bottomView?.layer.masksToBounds = true
    self.bottomView?.backgroundColor     = UIColor.red
    self.addSubview(self.bottomView!)
    
    self.bottomView?.snp.makeConstraints({ (make) in
        make.height.equalTo(250)
        make.right.equalTo(self).offset(-10)
        make.left.equalTo(self).offset(10)
        make.bottom.equalTo(self).offset(-10)
    })
    
    self.doneButton = UIButton.init()
    self.doneButton?.backgroundColor = UIColor.init(red: 65.0/255.0, green: 188.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    self.doneButton?.setTitle("确 定", for: .normal)
    self.bottomView?.addSubview(self.doneButton!)
    self.doneButton?.snp.makeConstraints({ (make) in
      
      make.left.equalTo(self.bottomView!)
      make.right.equalTo(self.bottomView!)
      make.height.equalTo(50)
      make.bottom.equalTo(self.bottomView!)
      
    })
    
    self.yearView = UILabel.init()
    self.yearView?.isUserInteractionEnabled = true
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
    self.datePicker!.delegate   = self
    self.datePicker!.dataSource = self
    
    self.datePicker!.backgroundColor = UIColor.green
    self.yearView?.addSubview(self.datePicker!)
    self.datePicker?.snp.makeConstraints({ (make) in
      make.left.right.top.bottom.equalTo(self.yearView!)
    })
   
    
  }

  func numOfRowsInComponent()->Array<Int>{
    
    let yearNum      = self.yearArray.count
    let monthNum     = self.monthArray.count
    let dayNum       = self.daysOfMonth(month: Int(self.monthArray[self.monthIndex])!, year: Int(self.yearArray[self.yearIndex])!)
    let hourNum      = self.hourArray.count
    let minuteNum    = self.minuteArray.count
    let yearInterval = kMaxYear - kMinYear
  
    var array:Array<Int> = Array.init()
    
    switch self.dateStyle {
      case .yearMonthDayHourMinute:
        array.append(yearNum)
        array.append(monthNum)
        array.append(dayNum)
        array.append(hourNum)
        array.append(minuteNum)
      case .monthDayHourMinute:
        array.append(monthNum*yearInterval)
        array.append(dayNum)
        array.append(hourNum)
        array.append(minuteNum)
      case .yearMonthDay:
        array.append(yearNum)
        array.append(monthNum)
        array.append(dayNum)
      case .yearMonth:
        array.append(yearNum)
        array.append(monthNum)
      case .monthDay:
        array.append(monthNum*yearInterval)
        array.append(dayNum)
      case .hourMinute:
        array.append(hourNum)
        array.append(minuteNum)
   
    }
    
    
    return array
    
  }
 
  
  func daysOfMonth(month:Int,year:Int)->Int{
    
    let numMonth   = month
    let numYear    = year
    let isLeapYear = numYear%4==0 ? ((numYear%100==0) ? (numYear%400==0 ? true:false):true):false;
    
    print("yearIndex:"+String(year))
    print("monthIndex:"+String(month))
    
    switch numMonth {
    case 1,3,5,7,8,10,12:
      self.dayArray(day: 31)
      return 31
    case 4,6,9,11:
       self.dayArray(day: 30)
      return 30
    case 2:
      if isLeapYear {
        self.dayArray(day: 29)
        return 29
      }else{
        self.dayArray(day: 28)
        return 28
      }
    default:
      return 0
    }
    
  }
  
  func dayArray(day:Int){
    self.dayArray.removeAll()
    
    for index in 1 ... day {
      self.dayArray.append(String(format: "%02d", index))
    }
    
  }
  
  
  func titleForComponentAndRow(component:Int,row:Int)->String{
    
  
    var title = ""
    
    switch self.dateStyle {
      
    case .yearMonthDayHourMinute:
      if component == 0 {
         title = self.yearArray[row]
      }
      
      if component == 1 {
        title = self.monthArray[row]
      }
      
      if component == 2 {
        title = self.dayArray[row]
      }
      
      if component == 3 {
        title = self.hourArray[row]
      }
      
      if component == 4 {
        title = self.minuteArray[row]
      }
      
    case .monthDayHourMinute:
      if component == 0 {
         title = self.yearArray[row%12]
      }
      
      if component == 1 {
        title = self.monthArray[row]
      }
      
      if component == 2{
        title = self.dayArray[row]
      }
      
    case .yearMonthDay:
      
      if component == 0 {
        title = self.yearArray[row]
      }
      
      if component == 1 {
        title = self.monthArray[row]
      }
      
      if component == 2 {
        title = self.hourArray[row]
      }
      
      if component == 3 {
        title = self.minuteArray[row]
      }
    
    case .yearMonth:
      
      if component == 0 {
        title = self.yearArray[row]
      }
      
      if component == 1 {
        title = self.monthArray[row]
      }
    
    
    case .monthDay:
      if component == 0 {
        title = self.monthArray[row%12]
      }
      
      if component == 1 {
        title = self.dayArray[row]
      }
      
    case .hourMinute:
      
      if component == 0 {
          title = self.hourArray[row]
      }
      
      if component == 1 {
         title = self.minuteArray[row]
      }
  
    
    }
    
    return title
    
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
    return self.numOfRowsInComponent()[component]
  }
  
  public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
    return 40
  }
  
  public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
   
    var  label = view as? UILabel
    
    if label == nil {
      label = UILabel.init()
      label?.textAlignment = .center
      label?.font = UIFont.systemFont(ofSize: 17)
    }
    
    label?.text = self.titleForComponentAndRow(component: component, row: row)
 
    return label!
   
  }
  
  
  
  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
    
    switch self.dateStyle {
      
    case .yearMonthDayHourMinute:
      if component == 0 {
       self.yearIndex = row
       self.daysOfMonth(month: Int(self.monthArray[self.monthIndex])!, year: Int(self.yearArray[self.yearIndex])!)
        
      }
      
      if component == 1 {
       self.monthIndex = row
       self.daysOfMonth(month: Int(self.monthArray[self.monthIndex])!, year: Int(self.yearArray[self.yearIndex])!)
      }
      
      if component == 2 {
      self.dayIndex = row
      }
      
      if component == 3 {
      self.hourIndex = row
      }
      
      if component == 4 {
       self.minuteIndex = row
      }
      
      
      
    case .monthDayHourMinute:
      if component == 0 {
       self.monthIndex = row
      }
      
      if component == 1 {
       self.dayIndex = row
      }
      
      if component == 2{
       self.hourIndex = row
      }
      
    case .yearMonthDay:
      
      if component == 0 {
      
      }
      
      if component == 1 {
     
      }
      
      if component == 2 {
       
      }
      
      if component == 3 {
        
      }
      
    case .yearMonth:
      
      if component == 0 {
      
      }
      
      if component == 1 {
      
      }
      
      
    case .monthDay:
      if component == 0 {
      
      }
      
      if component == 1 {
       
      }
      
    case .hourMinute:
      
      if component == 0 {
      
      }
      
      if component == 1 {
      
      }
      
      
    }
    
    pickerView.reloadAllComponents()
    
  }

}
