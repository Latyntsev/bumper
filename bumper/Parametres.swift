//
//  Parametres.swift
//  bumper
//
//  Created by Aleksandr Latyntsev on 1/12/16.
//  Copyright © 2016 Aleksandr Latyntsev. All rights reserved.
//

import Foundation

class Parametres {
    var imagesFolderPath: String!
    var text = ""
    var fontName = "Menlo Regular"
    
    private func parseArgument() {
        var setParametersValueHandler: ((value: String) -> Void)?
        
        for argument in Process.arguments[1..<Process.arguments.count] {
            
            if setParametersValueHandler == nil {
                
                switch argument.lowercaseString {
                case "-path":
                    setParametersValueHandler = {(value) -> Void in
                        self.imagesFolderPath = value
                        setParametersValueHandler = nil
                    }
                    
                case "-text":
                    setParametersValueHandler = {(value) -> Void in
                        self.text = value
                        setParametersValueHandler = nil
                    }
                    
                case "-fontName":
                    setParametersValueHandler = {(value) -> Void in
                        self.fontName = value
                        setParametersValueHandler = nil
                    }
                    
                default:
                    break
                }
                
            } else {
                if (setParametersValueHandler != nil) {
                    setParametersValueHandler!(value: argument)
                }
            }
        }
    }
    
    init() {
        self.parseArgument()
    }
}