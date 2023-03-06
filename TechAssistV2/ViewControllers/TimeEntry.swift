//
//  TimeEntry.swift
//  TechAssistV2
//
//  Created by Raf on 3/5/23.
//

import UIKit

class TimeEntry:UIViewController{
    
    let btnTimePU = UIButton()
    var popUpWindow: PopUpWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.blue
        title = "Time Entry"
        
        setupUI()
        
    }
    
   @objc func popUpButtonAction(_ sender: UIButton) {
        
        popUpWindow = PopUpWindow(title: "Error", text: "Sorry, that email address is already used!", buttontext: "OK")
        self.present(popUpWindow, animated: true, completion: nil)
       popUpWindow.popUpWindowView.popupTitle.text = "Hello from down here"
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
        
        
        //Begin Time Btn
        
        
        view.addSubview(btnTimePU)
        
        btnTimePU.configuration = .tinted()
        btnTimePU.configuration?.image = UIImage(systemName: "clock.fill")
        btnTimePU.configuration?.imagePadding = 6
        btnTimePU.configuration?.imagePlacement = .leading
        
        btnTimePU.titleLabel?.textColor = UIColor.black
        btnTimePU.setTitle("Enter Time", for: .normal)
        
        
        btnTimePU.translatesAutoresizingMaskIntoConstraints = false
        btnTimePU.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        btnTimePU.topAnchor.constraint(equalTo:imageView.bottomAnchor,constant: 45).isActive = true
        btnTimePU.widthAnchor.constraint(equalToConstant: 200).isActive = true
        btnTimePU.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnTimePU.addTarget(self,action: #selector(popUpButtonAction),for:.touchUpInside)
        btnTimePU.layer.cornerRadius = 5
        btnTimePU.layer.masksToBounds = true
        // btnTimePU.setTitleColor(UIColor.white, for: .normal)
        btnTimePU.setTitleColor(UIColor.systemBlue, for: .selected)
        btnTimePU.isEnabled = true
        
        _ = UIButton(type: .system)
        if let hs1Color = UIColor(hex: "#198754") {
            btnTimePU.configuration?.baseBackgroundColor = hs1Color
            btnTimePU.configuration?.baseForegroundColor = hs1Color
        }
        
        //End time Button
        
        
    }
}
