//
//  main.swift
//  bumper
//
//  Created by Aleksandr Latyntsev on 12/15/15.
//  Copyright © 2015 Aleksandr Latyntsev. All rights reserved.
//

import Foundation

let version = "0.0.2"

let parametres = Parametres()

func printHelp() {
    let help = [
        "Bumper \(version)",
        "'bumper' - command line tool for adding two short lines of text over the icon",
        "",
        "Options:",
        "  -path \tPath to a folder with images. All *.png files there will be updated, exept of subfolders",
        "  -text \tThe text that should be added on the icon, You can use '\\n' as a line separator. You can use maximum 2 lines and no more then 9 characters per line",
        "  -help --h\tShow this information",
        "  -version --v\tShow version number"
    ]
    
    
    for line in help {
        print(line)
    }
}


if (parametres.help) {
    
    printHelp()
    
} else if (parametres.showVersion) {
    
    print("bumper \(version)")
    
} else if (parametres.imagesFolderPath != nil) {
    
    let bumper = Bumper(fontName: parametres.fontName)
    bumper.make(parametres.imagesFolderPath!, text: parametres.text)
} else {
    printHelp()
}
