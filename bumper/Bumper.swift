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
        
        let source = CGImageSourceCreateWithData(image.TIFFRepresentation!, [:])
        let maskRef = CGImageSourceCreateImageAtIndex(source!, 0, [:])!
        var inputImage = NSImage(CGImage: maskRef, size: CGSizeMake(0,0))
        
        let radisuLow = inputImage.size.width *  0.01
        let radisu = inputImage.size.width *  0.03
        
        let textRect = CGRectMake(0, 0, inputImage.size.width, inputImage.size.height / 2.2)
        let font = NSFont(name: fontName, size: inputImage.size.width * 0.18)!
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .Center
        paragraph.maximumLineHeight = font.pointSize
        
        
        inputImage = inputImage.addBlure(radisu)
        
        var textFontAttributes = [
            NSFontAttributeName:font,
            NSForegroundColorAttributeName: NSColor.blackColor(),
            NSParagraphStyleAttributeName:paragraph
        ]
        inputImage = inputImage.addText(text, intRect: textRect , attributes: textFontAttributes)
        inputImage = inputImage.addBlure(radisuLow)
        
        
        textFontAttributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: NSColor.whiteColor(),
            NSParagraphStyleAttributeName:paragraph
        ]
        
        inputImage = inputImage.addText(text, intRect: textRect, attributes: textFontAttributes)
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

