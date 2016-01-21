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
    
    func addText(text: String, inRect:NSRect, attributes: [String:NSObject]) -> NSImage {
        
        
        let size = text.sizeWithAttributes(attributes)
        let rect = CGRectInset(inRect, (inRect.width - size.width) / 2, (inRect.height - size.height) / 2)
        
        
        let textImage = NSImage.init(size: self.size)
        textImage.lockFocus()
        
        self.drawInRect(CGRectMake(0, 0, self.size.width, self.size.height))
        text.drawInRect(rect, withAttributes: attributes)
        
        textImage.unlockFocus()
        
        return textImage
    }
    
    func addBlure(rect:NSRect, radisu: CGFloat)->NSImage {
        
        let drawRect = CGRectMake(0, 0, self.size.width, self.size.height)
        let inputImage = self.unscaledBitmapImageRep()
        
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setDefaults()
        filter.setValue(CIImage(bitmapImageRep: inputImage), forKey: kCIInputImageKey)
        filter.setValue(radisu, forKey: "inputRadius")
        let outputImage = filter.valueForKey(kCIOutputImageKey) as! CIImage
        
        
        let blurredImage = NSImage.init(size: self.size)
        
        blurredImage.lockFocus()
        
        self.drawInRect(drawRect)
        outputImage.drawInRect(rect, fromRect: rect, operation: .CompositeSourceOver, fraction: 1)
        
        blurredImage.unlockFocus()
        
        return blurredImage;
    }
    
    func saveImage(path: String)  {
        
        let bitmapRep = self.unscaledBitmapImageRep()
        let pngData = bitmapRep.representationUsingType(.NSPNGFileType, properties: [:])!
        
        pngData .writeToFile(path, atomically: true)
    }
}