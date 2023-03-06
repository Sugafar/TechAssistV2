//
//  PopUpCalendar.swift
//  TechAssistV2
//
//  Created by Raf on 3/6/23.
//

import Foundation
import UIKit

public class PopUpCalendar: UIViewController {

    public let popUpCalendarView = PopUpCalendarView()
    
    init(title: String, text: String, buttontext: String) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        
        popUpCalendarView.popupTitle.text = title
       // popUpCalendarView.popupText.text = text
        popUpCalendarView.popupButton.setTitle(buttontext, for: .normal)
        popUpCalendarView.popupButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        view = popUpCalendarView
        
        popUpCalendarView.datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
            // Handle value changes here
            print("Selected date: \(sender.date)")
        }
    
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }

}

public class PopUpCalendarView: UIView {
    
    let popupView = UIView(frame: CGRect.zero)
    public var popupTitle = UILabel(frame: CGRect.zero)
   // let popupText = UILabel(frame: CGRect.zero)
    let popupButton = UIButton(frame: CGRect.zero)
    
    let BorderWidth: CGFloat = 2.0
    
    var datePicker: UIDatePicker!
    
    init() {
        super.init(frame: CGRect.zero)
        // Semi-transparent background
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
       datePicker = UIDatePicker()
        // Popup Background
        //popupView.backgroundColor = UIColor.colorFromHex("#BC214B")
        popupView.backgroundColor = UIColor.colorFromHex("#198754").withAlphaComponent(0.7)
        popupView.layer.borderWidth = BorderWidth
        popupView.layer.masksToBounds = true
        popupView.layer.borderColor = UIColor.white.cgColor
        
        // Popup Title
        popupTitle.textColor = UIColor.white
        //popupTitle.backgroundColor = UIColor.colorFromHex("#9E1C40")
        popupTitle.backgroundColor = UIColor.colorFromHex("#198754")
        popupTitle.layer.masksToBounds = true
        popupTitle.adjustsFontSizeToFitWidth = true
        popupTitle.clipsToBounds = true
        popupTitle.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
        popupTitle.numberOfLines = 0
        
        popupTitle.textAlignment = .center
        
        // Popup Text
//        popupText.textColor = UIColor.white
//        popupText.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
//        popupText.numberOfLines = 0
//        popupText.textAlignment = .left
        
        // Popup Button
        popupButton.setTitleColor(UIColor.white, for: .normal)
        popupButton.titleLabel?.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
       // popupButton.backgroundColor = UIColor.colorFromHex("#9E1C40")
        popupButton.backgroundColor = UIColor.colorFromHex("#198754")
        // Set the mode of the date picker to display both date and time
        popupView.addSubview(datePicker)
        
              datePicker.datePickerMode = .dateAndTime

              // Set the minimum date to today's date
              datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())

              // Set the maximum date to one year from today's date
              datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())

              // Add a target action to the date picker to handle value changes
      //  datePicker.addTarget(self, action: #selector(popupCalendar.datePickerValueChanged(_:)), for: .valueChanged)
        
        
        popupView.addSubview(popupTitle)
       // popupView.addSubview(popupText)
        popupView.addSubview(popupButton)
       
        
        // Add the popupView(box) in the PopUpWindowView (semi-transparent background)
        addSubview(popupView)
        
        
        // PopupView constraints
        popupView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupView.widthAnchor.constraint(equalToConstant: 293),
            popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        
        // PopupTitle constraints
        popupTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupTitle.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: BorderWidth),
            popupTitle.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -BorderWidth),
            popupTitle.topAnchor.constraint(equalTo: popupView.topAnchor, constant: BorderWidth),
            popupTitle.heightAnchor.constraint(equalToConstant: 55)
            ])
        
        
        // datePicker constraints
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(greaterThanOrEqualToConstant: 67),
            datePicker.topAnchor.constraint(equalTo: popupTitle.bottomAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15),
            datePicker.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15),
            datePicker.bottomAnchor.constraint(equalTo: popupButton.topAnchor, constant: -8)
            ])

        
        // PopupButton constraints
        popupButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupButton.heightAnchor.constraint(equalToConstant: 44),
            popupButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: BorderWidth),
            popupButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -BorderWidth),
            popupButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -BorderWidth)
            ])
        
      
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//extension UIColor {
//    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
//        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
//    }
//
//    static func colorFromHex(_ hex: String) -> UIColor {
//        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//        if hexString.hasPrefix("#") {
//            hexString.remove(at: hexString.startIndex)
//        }
//        if hexString.count != 6 {
//            return UIColor.magenta
//        }
//
//        var rgb: UInt64 = 0
//        Scanner.init(string: hexString).scanHexInt64(&rgb)
//
//        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16)/255,
//                            green: CGFloat((rgb & 0x00FF00) >> 8)/255,
//                            blue: CGFloat(rgb & 0x0000FF)/255,
//                            alpha: 1.0)
//    }
    
//}

