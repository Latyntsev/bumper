//
//  main.swift
//  bumper
//
//  Created by Aleksandr Latyntsev on 12/15/15.
//  Copyright © 2015 Aleksandr Latyntsev. All rights reserved.
//

import Foundation

var parametres = Parametres()

let bumper = Bumper(fontName: parametres.fontName)
bumper.make(parametres.imagesFolderPath, text: parametres.text)






