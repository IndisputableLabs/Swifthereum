//
//  TypeAlias.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
    
    import UIKit
    
    public typealias ViewController =               UIViewController
    public typealias View =                         UIView
    public typealias Label =                        UILabel
    public typealias TextField =                    UITextField
    public typealias TextView =                     UITextView
    public typealias Image =                        UIImage
    
    public typealias GestureRecognizerStateType =   UIGestureRecognizerState
    public typealias Font =                         UIFont
    public typealias Color =                        UIColor
    public typealias EdgeInsets =                   UIEdgeInsets
    public typealias Responder =                    UIResponder
    public typealias StackView =                    UIStackView
    
    public protocol PasteboardReading { }
    public protocol PasteboardWriting { }
    
#elseif os(OSX)
    
    import AppKit
    
    public typealias ViewController =               NSViewController
    public typealias View =                         NSView
    public typealias Label =                        NSLabel
    public typealias TextField =                    NSTextField
    public typealias TextView =                     NSTextView
    public typealias Image =                        NSImage
    
    public typealias GestureRecognizerStateType =   NSGestureRecognizerState
    public typealias Font =                         NSFont
    public typealias Color =                        NSColor
    public typealias EdgeInsets =                   NSEdgeInsets
    public typealias Responder =                    NSResponder
    public typealias StackView =                    NSStackView
    
    public typealias PasteboardReading =            NSPasteboardReading
    public typealias PasteboardWriting =            NSPasteboardWriting
    
    extension NSView {
        public var alpha: CGFloat {
            get {
                return alphaValue
            }
            set {
                alphaValue = newValue
            }
        }
    }
    
#endif
