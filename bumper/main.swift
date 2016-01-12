//
//  main.swift
//  bumper
//
//  Created by Aleksandr Latyntsev on 12/15/15.
//  Copyright © 2015 Aleksandr Latyntsev. All rights reserved.
//

import Foundation
import AppKit


var i = 0
var path: String?
var text: String?

for argument in Process.arguments {
    i++
    switch i {
    case 2:
        path = argument
        break
    case 3:
        text = argument.stringByReplacingOccurrencesOfString("\\n", withString: "\n")
        break
    default:
        break
    }
}

let fileManager = NSFileManager.defaultManager()
let enumerator = fileManager.enumeratorAtPath(path!)

while let element = enumerator?.nextObject() as? String {
    if (element.hasSuffix("png") && element.componentsSeparatedByString("/").count == 1) {
        
        let pathToImage = "\(path!)/\(element)"
        let url = NSURL.init(fileURLWithPath: pathToImage)
        var image = NSImage.init(contentsOfFile: pathToImage)!
        
        let source = CGImageSourceCreateWithData(image.TIFFRepresentation!, [:]);
        let maskRef = CGImageSourceCreateImageAtIndex(source!, 0, [:])!
        image = NSImage(CGImage: maskRef, size: CGSizeMake(0,0))
        
        let radisuLow = image.size.width *  0.01
        let radisu = image.size.width *  0.03
        
        let textRect = CGRectMake(0, 0, image.size.width, image.size.height / 2.2)
        let font = NSFont(name: "Menlo Regular", size: image.size.width * 0.18)!
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .Center
        paragraph.maximumLineHeight = font.pointSize;
        
        
        image = image.addBlure(radisu)
        
        var textFontAttributes = [
            NSFontAttributeName:font,
            NSForegroundColorAttributeName: NSColor.blackColor(),
            NSParagraphStyleAttributeName:paragraph
        ]
        image = image.addText(text!, intRect: textRect , attributes: textFontAttributes)
        image = image.addBlure(radisuLow)
        
        
        textFontAttributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: NSColor.whiteColor(),
            NSParagraphStyleAttributeName:paragraph
        ]
        
        image = image.addText(text!, intRect: textRect, attributes: textFontAttributes)
        
        image.saveImage(pathToImage)
    }
}



