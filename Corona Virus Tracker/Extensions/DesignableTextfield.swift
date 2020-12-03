//
//  DesignableTextfield.swift
//  Images in Textfield
//
//  Created by Adwait Barkale on 30/10/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextfield: UITextField {
    
    @IBInspectable var leftImage: UIImage?{
        didSet{
                updateView()
        }
    }
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet{
            updateView()
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    func updateView()
    {
        if let img = leftImage{
            leftViewMode = .always
            //view.backgroundColor = .red
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.image = img
            var viewWidth = leftPadding + 20
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line{
                viewWidth = viewWidth + 5
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: 20))
            view.addSubview(imageView)
            leftView = view
        }else{
            leftViewMode = .never
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor : tintColor!])
    }

}
