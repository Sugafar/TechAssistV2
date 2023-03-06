//
//  TimeEntry.swift
//  TechAssistV2
//
//  Created by Raf on 3/5/23.
//

import UIKit

class TimeEntry:UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    
    let btnTimePU = UIButton()
    let btnDate = UIButton()
    var popUpWindow: PopUpWindow!
   // var popUpCalendar: PopUpCalendar!
    var pickerView: UIPickerView!
    var datePicker: UIDatePicker!

        let column1Options = ["1", "2", "3","4","5","6","7","8","9","10","11","12","13","14"]
    let column2Options = [":00",":15", ":30", ":45"]
    let column1Heading = "Hour"
        let column2Heading = "Min"
    let columnHeadingFont = UIFont.boldSystemFont(ofSize: 12)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.blue
        title = "Time Entry"
        
        datePicker = UIDatePicker()
        pickerView = UIPickerView()
        // Set the mode of the date picker to display both date and time
                datePicker.datePickerMode = .dateAndTime

                // Set the minimum date to today's date
                datePicker.minimumDate = Date()

                // Set the maximum date to one year from today's date
                datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())

                // Add a target action to the date picker to handle value changes
                datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
           
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        
        setupUI()
        
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        // Handle value changes here
        print("Selected date: \(sender.date)")
        // kludgy code to get the calendar to dismiss
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.preferredDatePickerStyle = .automatic
        
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
        //            if component == 0 {
        //                return column1Options[row]
        //            } else {
        //                return column2Options[row]
        //            }
        
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
   

    //End the picker
    
   @objc func popUpButtonAction(_ sender: UIButton) {
        
        popUpWindow = PopUpWindow(title: "Time Entry Help", text: "Time Entry Help", buttontext: "OK")
        self.present(popUpWindow, animated: true, completion: nil)
       popUpWindow.popUpWindowView.popupText.text = "1. Pick a date by selecting today's date to open a calendar. If you're entering time for today skip this step \n\n2. Pick an hour and a minute \n\n3. Save it \n\nA day might have 4 entries: "
       popUpWindow.popUpWindowView.popupText.text! += "\n\nWork started: 7:00, Ended: 11:00 \nWork started 12:00, Ended 16:00 \n"
        
    }
    
//    @objc func popUpCalendarButtonAction(_ sender: UIButton) {
//
//        popUpCalendar = PopUpCalendar(title: "Pick a Date",text:"wtf", buttontext: "OK")
//         self.present(popUpCalendar, animated: true, completion: nil)
//       // popUpWindow.popUpWindowView.popupText.text = "1. Pick a date \n2. Pick an hour and a minute \n3. Save it \nA day might have 4 entries: "
//       // popUpWindow.popUpWindowView.popupText.text! += "\nWork started: 7:00, Ended: 11:00 \nWork started 12:00, Ended 16:00"
//
//     }
    
    
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
        
        //Begin Time Btn
        
        
        view.addSubview(btnTimePU)
        
        btnTimePU.configuration = .tinted()
        btnTimePU.configuration?.image = UIImage(systemName: "questionmark.circle.fill")
        btnTimePU.configuration?.imagePadding = 6
        btnTimePU.configuration?.imagePlacement = .leading
        
        btnTimePU.titleLabel?.textColor = UIColor.black
       // btnTimePU.setTitle("Help", for: .normal)
        
        
        btnTimePU.translatesAutoresizingMaskIntoConstraints = false
        btnTimePU.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        btnTimePU.topAnchor.constraint(equalTo:imageView.bottomAnchor,constant: 10).isActive = true
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
        
        //End time Button
        
        //Begin Date Btn
              
              
        // datePicker constraints
        view.addSubview(datePicker)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(greaterThanOrEqualToConstant: 67),
            datePicker.topAnchor.constraint(equalTo: btnTimePU.bottomAnchor, constant: 1),
            datePicker.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
           // datePicker.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15),
            //datePicker.bottomAnchor.constraint(equalTo: popupButton.topAnchor, constant: -8)
            ])

        
        
       
        
        
        view.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.dataSource = self
      //  pickerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: pickerView.bounds.height)

        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: btnTimePU.trailingAnchor,constant: 75),
            pickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 35),
            pickerView.widthAnchor.constraint(equalToConstant: 110),
            pickerView.heightAnchor.constraint(equalToConstant: 150),
             //contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

        ])
        pickerView.layer.zPosition = 0
        
       
        
    }
}
