//
//  Bumper.swift
//  bumper
//
//  Created by Aleksandr Latyntsev on 1/12/16.
//  Copyright © 2016 Aleksandr Latyntsev. All rights reserved.
//

import Foundation
import AppKit

class Bumper {
    private var fontName:String
    
    init(fontName:String) {
        self.fontName = fontName
    }
    
    func makeOnImage(image:NSImage, text: String) -> NSImage {

        let blureConst: CGFloat = 0.03
        let source = CGImageSourceCreateWithData(image.TIFFRepresentation!, [:])
        let maskRef = CGImageSourceCreateImageAtIndex(source!, 0, [:])!
        var inputImage = NSImage(CGImage: maskRef, size: CGSizeMake(0,0))
        
        let fontSize = inputImage.size.width * 0.17
        let textRect = CGRectMake(0, 0, inputImage.size.width, inputImage.size.height / 2)
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .Center
        paragraph.maximumLineHeight = fontSize
        
        let backgroundTextFontAttributes = [
            NSFontAttributeName:NSFont(name: fontName, size: fontSize)!,
            NSForegroundColorAttributeName: NSColor.blackColor(),
            NSParagraphStyleAttributeName:paragraph
        ]
        
        let textFontAttributes = [
            NSFontAttributeName: NSFont(name: fontName, size: fontSize)!,
            NSForegroundColorAttributeName: NSColor.whiteColor(),
            NSParagraphStyleAttributeName:paragraph
        ]
        
        let radisuLow = inputImage.size.width * (blureConst * 0.2)
        let radisu = inputImage.size.width *  (blureConst * 0.8)
    
        inputImage = inputImage.addBlure(textRect, radisu:radisu)
        inputImage = inputImage.addText(text, inRect: textRect , attributes: backgroundTextFontAttributes)
        inputImage = inputImage.addBlure(textRect, radisu: radisuLow)
        inputImage = inputImage.addText(text, inRect: textRect, attributes: textFontAttributes)
        
        return inputImage
    }
    
    func make(imagesFolderPath:String, text: String) {
        let fileManager = NSFileManager.defaultManager()
        let enumerator = fileManager.enumeratorAtPath(imagesFolderPath)
        
        while let element = enumerator?.nextObject() as? String {
            if (element.hasSuffix("png") && element.componentsSeparatedByString("/").count == 1) {
                
                let pathToImage = "\(imagesFolderPath)/\(element)"
                
                if let inputImage = NSImage.init(contentsOfFile: pathToImage) {
                    let outputImage = makeOnImage(inputImage, text:text)
                    outputImage.saveImage(pathToImage)
                }
            }
        }
    }
}

