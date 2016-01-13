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
        let arguments = Process.arguments
        for argument in arguments[1..<arguments.count] {

            if setParametersValueHandler == nil {
                
                switch argument.lowercaseString {
                case "-path":
                    setParametersValueHandler = {(value) -> Void in
                        self.imagesFolderPath = value
                    }
                    
                case "-text":
                    setParametersValueHandler = {(value) -> Void in
                        self.text = value.stringByReplacingOccurrencesOfString("\\n", withString: "\n")
                    }
                    
                case "-fontName":
                    setParametersValueHandler = {(value) -> Void in
                        self.fontName = value
                    }
                    
                default:
                    break
                }
                
            } else {
                if (setParametersValueHandler != nil) {
                    setParametersValueHandler!(value: argument)
                    setParametersValueHandler = nil
                }
            }
        }
    }
    
    init() {
        self.parseArgument()
    }
}