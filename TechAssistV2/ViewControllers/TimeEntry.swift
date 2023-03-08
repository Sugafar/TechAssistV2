//
//  TimeEntry.swift
//  TechAssistV2
//
//  Created by Raf on 3/5/23.
//

import UIKit

class TimeEntry:UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    
    let btnTimePU = UIButton()
    let btnSaveTime = UIButton()
    let btnDate = UIButton()
    let lblMyDay = PaddingLabel()
    let lblBuild = UILabel()
    let lblWorkDate = UILabel()
    var lastEntry:String = "Init"
    var popUpWindow: PopUpWindow!
   // var popUpCalendar: PopUpCalendar!
    var pickerView: UIPickerView!
    var datePicker: UIDatePicker!
    var netScreenWidth: CGFloat = 0.0
    var lastDateTimeEntered = Date()
    
    
    //var mySubView: UIView!
    
    var column1Options = ["","1", "2", "3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
    var column2Options = [" ",":00",":15", ":30", ":45"]
    let column1Heading = "Hour"
    let column2Heading = "Min"
    let columnHeadingFont = UIFont.boldSystemFont(ofSize: 18)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.blue
        title = "Time Entry"
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let safeAreaInsets = windowScene.windows.first?.safeAreaInsets ?? UIEdgeInsets.zero
            netScreenWidth = UIScreen.main.bounds.width - safeAreaInsets.left - safeAreaInsets.right
        }
        //subtract out the width of the 2 buttons and the picker to leave netScreenWidth for spacing ie: 50 + 50 + 140
        netScreenWidth = netScreenWidth - 240
        
        lastDateTimeEntered = Calendar.current.date(byAdding: .day, value: -8, to: Date())!
        print(lastDateTimeEntered)
      
        lblMyDay.text = ""
        
        datePicker = UIDatePicker()
        pickerView = UIPickerView()
        // Set the mode of the date picker to display both date and time
                datePicker.datePickerMode = .date

                // Set the minimum date to today's date
                datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())

                // Set the maximum date to one year from today's date
                datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())

                // Add a target action to the date picker to handle value changes
                datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
           
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        
        setBeginningDate()
        setupUI()
        
    }
    
    //set the beginning date to 8 days previous as user can only go back 7 days and the beginning date has to be less than a date they can pick
    // for the logic to work. This func is needed for reset as well as startup
    func setBeginningDate(){
        
        lastDateTimeEntered = Calendar.current.date(byAdding: .day, value: -8, to: Date())!
        
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        // Handle value changes here
        print("Selected date: \(sender.date)")
        // kludgy code to get the calendar to dismiss
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.preferredDatePickerStyle = .automatic
       
        
    }
    //pulls the date component only out of a datetime
    func justDate (aDate:Date)->String{
        
        let dateformatter = DateFormatter()
       
        dateformatter.dateFormat = "MM.dd.yyyy"
        return  dateformatter.string(from: aDate)
        
    }
    
    //Begin the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2
        }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if component == 0 {
                return column1Options.count
            } else {
                return column2Options.count
            }
        }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
           // Return the desired width of each column
           return 55.0
       }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        if component == 0 {
            if row == 0 {
                return column1Heading
            } else {
                return column1Options[row - 1]
            }
        } else {
            if row == 0 {
                return column2Heading
            } else {
                return column2Options[row - 1]
            }
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
           var label: UILabel
           if let view = view as? UILabel {
               label = view
           } else {
               label = UILabel()
           }
           if row == 0 {
               if component == 0 {
                   label.text = column1Heading
               } else {
                   label.text = column2Heading
               }
               label.font = columnHeadingFont
           } else {
               if component == 0 {
                   label.text = column1Options[row]
               } else {
                   label.text = column2Options[row]
               }
           }
           return label
       }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
           let title = "Row \(row)"
           let attributedTitle = NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 16)])
           return attributedTitle
       }
   

    //End the picker
    
    @objc func getTime(){
        //pulls the selected value out of each columns array
        let myLastHour = column1Options[pickerView.selectedRow(inComponent: 0)]
        
        var myStringTime:String = column1Options[pickerView.selectedRow(inComponent: 0)] + column2Options[pickerView.selectedRow(inComponent:1 )]
   
        print("Current selected hour: \(column1Options[pickerView.selectedRow(inComponent: 0)])")
        print("Current selected min: \(column2Options[pickerView.selectedRow(inComponent: 1)])")
        if(!verifyTime(newHour: column1Options[pickerView.selectedRow(inComponent: 0)], newMin: column2Options[pickerView.selectedRow(inComponent: 1)]))
        {
            
                let alertController = UIAlertController(title: "kabloooey", message: "Entry must be equal to or greater than the last entry.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                        print("OK button tapped");
                    }
                //alertController.view.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion:nil)
                
            
        }
        else{
            if(lastEntry == "Init" || lastEntry == "End")
            {
                if(lblMyDay.text == "")
                {
                    lblMyDay.text! = "Start: " + myStringTime
                }
                else{
                    lblMyDay.text! += "Start: " + myStringTime
                }
                lastEntry = "Start"
            }
            else{
                lblMyDay.text! += " End: " + myStringTime + "\n"
                lastEntry = "End"
            }
            
            hourArrayHandler(lastHour: (myLastHour))
        }
            
        
        
        
    }
    
    func verifyTime(newHour:String,newMin:String) ->Bool{
        
        //example
        
        //let myDay = "3/7/2023"
        
        let myHour = newHour
        let myMinute = newMin
        var eDate = Date()

        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MM/dd/yyyy"
        let myDay = (dateFormatter2.string(from:datePicker.date))
        let dateString = "\(myDay) \(myHour)\(myMinute)"
        print("elon's date: \(dateString)")
        dateFormatter2.dateFormat = "MM/dd/yyyy hh:mm"
        eDate = dateFormatter2.date(from: dateString)! //{
           // dateFormatter2.dateFormat = "MM/dd/yyyy hh:mm"
            let formattedDateString = dateFormatter2.string(from: eDate)
            print(formattedDateString)
//        } else {
//            print("Invalid date format")
//        }
        
        //end of example
        
        // clean out the : from the last min
        let myLastMin = String(newMin.filter { !":".contains($0) })
        
        //veify that the last time entered is less than the current entry
        print("last Time: \(lastDateTimeEntered)")
        print("new Time: \(eDate)")
        if(lastDateTimeEntered <= eDate )// it's a valid entry as it's equal to or greater than the last time entered
        {
            lastDateTimeEntered = eDate // lastDateTimeEntered becomes the current entry
            print("lastDateTimeEntered after update: \(lastDateTimeEntered)")
            return true

        }
        else
        {
            // popup an alert that entry is not valid
            return false
        }
        
       
      
    }
    
    func hourArrayHandler(lastHour:String){
        
        column1Options.removeAll()
        var hourNum:UInt8 = UInt8(lastHour)!
        //var stringNum = String()
        //var currentHour:Int = hourNum
        column1Options.append(String("")) // this is to handle the column header
        while hourNum < 25{
           // stringNum = String(hourNum)
            column1Options.append(String(hourNum))
            hourNum += 1
            
        }
        pickerView.reloadComponent(0)
        let componentCount = pickerView.numberOfComponents

        // Loop through each component and select the first row (index 0)
        for component in 0..<componentCount {
            pickerView.selectRow(0, inComponent: component, animated: true)
        }
        
        
    }
    
   @objc func popUpButtonAction(_ sender: UIButton) {
        
        popUpWindow = PopUpWindow(title: "Time Entry Help", text: "Time Entry Help", buttontext: "OK")
        self.present(popUpWindow, animated: true, completion: nil)
       popUpWindow.popUpWindowView.popupText.text = "1. Pick a date by selecting today's date to open a calendar. If you're entering time for today skip this step \n\n2. Pick an hour and a minute \n\n3. Save it \n\nA day might have 4 entries: "
       popUpWindow.popUpWindowView.popupText.text! += "\n\nWork started: 7:00, Ended: 11:00 \nWork started 12:00, Ended 16:00 \n"
        
    }
    

    
    
    func setupUI(){
        
        //Begin the image
        // Get the screen width
        let screenWidth = UIScreen.main.bounds.width
        
        // Set the desired width of the image
        let desiredWidth: CGFloat = screenWidth * 0.9
        
        
        
        // Load the original image
        let image = UIImage(named: "dcleftjpg")
        
        // Calculate the scale factor
        let scaleFactor = image!.size.width / desiredWidth
        
        // Calculate the new size
        let newSize = CGSize(width: image!.size.width / scaleFactor, height: image!.size.height / (scaleFactor * 1.30))
        
        // Create a new image that is scaled
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image!.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let padding2 = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 30)
      //  imageView = UIImageView(image:paddedImage?.withAlignmentRectInsets(padding2))
        
        //******end of add padding
        
        // Display the scaled image in an image view
        let imageView = UIImageView(image:newImage?.withAlignmentRectInsets(padding2))
      //  imageView.contentMode = .scaleAspectFit
        //imageView.center = view.center
        view.addSubview(imageView)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           
           // imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20)
            
        ])
        
        
        
        // datePicker constraints
        view.addSubview(datePicker)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(greaterThanOrEqualToConstant: 67),
            datePicker.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            datePicker.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
           // datePicker.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15),
            //datePicker.bottomAnchor.constraint(equalTo: popupButton.topAnchor, constant: -8)
            ])

        // end of date picker
        
        //let lblWorkDate = UILabel()
              view.addSubview(lblWorkDate)
              
                     lblWorkDate.numberOfLines = 0 // this turns the label into a multi line label
                     lblWorkDate.lineBreakMode = .byWordWrapping
                     lblWorkDate.text = "Work Date"
                     lblWorkDate.textColor = UIColor.black
                    // lblWorkDate.font = .systemFont(ofSize: 20)
                     lblWorkDate.font = .systemFont(ofSize: 12, weight: .medium)
                     
                     view.addSubview(lblWorkDate)
                     
                     lblWorkDate.translatesAutoresizingMaskIntoConstraints = false
                     
                     NSLayoutConstraint.activate([
                    // lblWorkDate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                     lblWorkDate.bottomAnchor.constraint(equalTo: datePicker.topAnchor,constant: 18),
                     lblWorkDate.leadingAnchor.constraint(equalTo: datePicker.leadingAnchor,constant: 10),
                     lblWorkDate.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 1, constant: -20)
                     ])
                     //end of lable
        
        
        //Begin Time Btn Popup
        view.addSubview(btnTimePU)
        
        btnTimePU.configuration = .tinted()
        btnTimePU.configuration?.image = UIImage(systemName: "questionmark.circle.fill")
        btnTimePU.configuration?.imagePadding = 6
        btnTimePU.configuration?.imagePlacement = .leading
        
        btnTimePU.titleLabel?.textColor = UIColor.black
       // btnTimePU.setTitle("Help", for: .normal)
        
        
        btnTimePU.translatesAutoresizingMaskIntoConstraints = false
        btnTimePU.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        btnTimePU.topAnchor.constraint(equalTo:datePicker.bottomAnchor,constant: 10).isActive = true
        btnTimePU.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnTimePU.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnTimePU.addTarget(self,action: #selector(popUpButtonAction),for:.touchUpInside)
        btnTimePU.layer.cornerRadius = 5
        btnTimePU.layer.masksToBounds = true
        // btnTimePU.setTitleColor(UIColor.white, for: .normal)
        btnTimePU.setTitleColor(UIColor.systemBlue, for: .selected)
        btnTimePU.isEnabled = true
        btnTimePU.layer.zPosition = 1
        
        _ = UIButton(type: .system)
        if let hs1Color = UIColor(hex: "#198754") {
            btnTimePU.configuration?.baseBackgroundColor = hs1Color
            btnTimePU.configuration?.baseForegroundColor = hs1Color
        }
        
        //End time popup Button
        
       
        
        //Begin picker
        view.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.dataSource = self
      //  pickerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: pickerView.bounds.height)

        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 90),
            pickerView.widthAnchor.constraint(equalToConstant: 170),
            pickerView.heightAnchor.constraint(equalToConstant: 150),
             //contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

        ])
        pickerView.layer.zPosition = 0
        
       
        //Begin btn save time
                view.addSubview(btnSaveTime)
                
                btnSaveTime.configuration = .tinted()
                btnSaveTime.configuration?.image = UIImage(systemName: "checkmark.seal.fill")
                btnSaveTime.configuration?.imagePadding = 6
                btnSaveTime.configuration?.imagePlacement = .leading
                
                btnSaveTime.titleLabel?.textColor = UIColor.black
               // btnSaveTime.setTitle("Help", for: .normal)
                
                
                btnSaveTime.translatesAutoresizingMaskIntoConstraints = false
        btnSaveTime.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
                btnSaveTime.topAnchor.constraint(equalTo:btnTimePU.topAnchor).isActive = true
                btnSaveTime.widthAnchor.constraint(equalToConstant: 50).isActive = true
                btnSaveTime.heightAnchor.constraint(equalToConstant: 50).isActive = true
                btnSaveTime.addTarget(self,action: #selector(getTime),for:.touchUpInside)
                btnSaveTime.layer.cornerRadius = 5
                btnSaveTime.layer.masksToBounds = true
                // btnSaveTime.setTitleColor(UIColor.white, for: .normal)
                btnSaveTime.setTitleColor(UIColor.systemBlue, for: .selected)
                btnSaveTime.isEnabled = true
                btnSaveTime.layer.zPosition = 1
                
                _ = UIButton(type: .system)
                if let hs1Color = UIColor(hex: "#198754") {
                    btnSaveTime.configuration?.baseBackgroundColor = hs1Color
                    btnSaveTime.configuration?.baseForegroundColor = hs1Color
                }
                
                //End btn save time
        
        //Begin the MyDay label
        view.addSubview(lblMyDay)
        lblMyDay.numberOfLines = 0
        lblMyDay.textColor = UIColor.black
        lblMyDay.layer.borderWidth = 3.0
        lblMyDay.layer.borderColor = UIColor(hex: "#198754")?.cgColor
        lblMyDay.layer.cornerRadius = 19.0 // Optional: To add rounded corners
        
        lblMyDay.font = .systemFont(ofSize: 18, weight: .medium)
        
        
        
        lblMyDay.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // lblMyDay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblMyDay.topAnchor.constraint(equalTo: pickerView.bottomAnchor,constant: 10),
            lblMyDay.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,constant:2),
            lblMyDay.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 1, constant: -2),
            
        ])
        
        
        //end of lblMyDay
        
        //Begin the label build
               //let lblBuild = UILabel()
        view.addSubview(lblBuild)
        
               lblBuild.numberOfLines = 0 // this turns the label into a multi line label
               lblBuild.lineBreakMode = .byWordWrapping
               lblBuild.text = "Build my day results"
               lblBuild.textColor = UIColor.black
              // lblBuild.font = .systemFont(ofSize: 20)
               lblBuild.font = .systemFont(ofSize: 12, weight: .medium)
               
               view.addSubview(lblBuild)
               
               lblBuild.translatesAutoresizingMaskIntoConstraints = false
               
               NSLayoutConstraint.activate([
              // lblBuild.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               lblBuild.bottomAnchor.constraint(equalTo: lblMyDay.topAnchor,constant: 1),
               lblBuild.leadingAnchor.constraint(equalTo: lblMyDay.leadingAnchor,constant: 10),
               lblBuild.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 1, constant: -20)
               ])
               //end of lable
        
        
      
    }
}

class PaddingLabel: UILabel {
    let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
}

//extension UIColor {
//    convenience init(hex: String) {
//        let scanner = Scanner(string: hex)
//        scanner.scanLocation = 0
//
//        var rgbValue: UInt64 = 0
//
//        scanner.scanHexInt64(&rgbValue)
//
//        let r = (rgbValue & 0xff0000) >> 16
//        let g = (rgbValue & 0xff00) >> 8
//        let b = rgbValue & 0xff
//
//        self.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: 1)
//    }
//}

