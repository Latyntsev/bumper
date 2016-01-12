//
//  NSImage+extension.swift
//  bumper
//
//  Created by Aleksandr Latyntsev on 1/5/16.
//  Copyright © 2016 Aleksandr Latyntsev. All rights reserved.
//

import Foundation
import CoreImage
import AppKit

extension NSImage {
    func unscaledBitmapImageRep() -> NSBitmapImageRep {
        
        let rep = NSBitmapImageRep.init(
            bitmapDataPlanes: nil,
            pixelsWide: Int(self.size.width),
            pixelsHigh: Int(self.size.height),
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: NSDeviceRGBColorSpace,
            bytesPerRow: 0,
            bitsPerPixel: 0)!
        
        
        NSGraphicsContext.saveGraphicsState()
        
        NSGraphicsContext.setCurrentContext(NSGraphicsContext(bitmapImageRep: rep))
        self .drawAtPoint(NSMakePoint(0, 0), fromRect: NSZeroRect, operation: .CompositeSourceOver, fraction: 1)
        NSGraphicsContext.restoreGraphicsState()
        return rep
    }
    
    func addText(text: String, intRect:NSRect, attributes: [String:NSObject]) -> NSImage {
        
        let textImage = NSImage.init(size: self.size)
        
        textImage.lockFocus()
        
        self.drawInRect(CGRectMake(0, 0, self.size.width, self.size.height))
        text.drawInRect(intRect, withAttributes: attributes)
        textImage.unlockFocus()
        
        return textImage
    }
    
    func addBlure(radisu: CGFloat)->NSImage {
        
        var drawRect = CGRectMake(0, 0, self.size.width, self.size.height)
        let inputImage = self.unscaledBitmapImageRep()
        
        
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setDefaults()
        filter.setValue(CIImage(bitmapImageRep: inputImage), forKey: kCIInputImageKey)
        filter.setValue(radisu, forKey: "inputRadius")
        let outputImage = filter.valueForKey(kCIOutputImageKey) as! CIImage
        
        
        let blurredImage = NSImage.init(size: self.size)
        
        
        blurredImage.lockFocus()
        inputImage.drawInRect(drawRect)
        
        
        drawRect.size = CGSizeMake(drawRect.size.width, drawRect.size.height / 2)
        outputImage.drawInRect(drawRect, fromRect: drawRect, operation: .CompositeSourceOver, fraction: 1)
        
        blurredImage.unlockFocus()
        
        return blurredImage;
    }
    
    func saveImage(path: String)  {
        
        let bitmapRep = self.unscaledBitmapImageRep()
        let pngData = bitmapRep.representationUsingType(.NSPNGFileType, properties: [:])!
        
        pngData .writeToFile(path, atomically: true)
    }
}