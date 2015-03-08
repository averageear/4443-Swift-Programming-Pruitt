//
//  Colors.swift
//  Program_1_Starter
//
//  Created by Terry Griffin on 2/27/15.
//  Copyright (c) 2015 mwsu. All rights reserved.
//

import UIKit

struct RGB{
    var R:Double
    var G:Double
    var B:Double
}

struct HSV{
    var H: Int
    var S: Double
    var V: Double
}

struct HSL{
    var H:Int
    var S:Double
    var L:Double
}

class Colors {
    
    typealias ColorTuple = (colorName:String,hexValue:String,rgb:RGB,hsl:HSL,hsv:HSV)

    var colorsTupleArray:[ColorTuple]
    
    init(){
        colorsTupleArray = [ColorTuple]()
    }
    
    /********************************************************************************************
    * Function:
    *    addColor
    * Params:
    *    color:String,hex:String,red:Double,green:Double,blue:Double,hue1:Int,sat1:Double,hue2:Int,sat2:Double,value:Double,lightness:Double
    * Returns:
    *    Void
    ********************************************************************************************/
    func addColor(color:String,hex:String,red:Double,green:Double,blue:Double,hue1:Int,sat1:Double,hue2:Int,sat2:Double,value:Double,lightness:Double){
        let rgb = RGB(R:red,G:green,B:blue)
        let hsv = HSV(H:hue2,S:sat2,V:value)
        let hsl = HSL(H:hue1,S:sat1,L:lightness)
        let info = ColorTuple(color,hex,rgb,hsl,hsv)
        colorsTupleArray.append(info)
    }
    
    /********************************************************************************************
    * Function:
    *    fetchColorCount
    * Params:
    *    Void
    * Returns:
    *    Number of Colors : Int
    ********************************************************************************************/
    func fetchColorCount()->Int{
        return colorsTupleArray.count
    }
    
    /********************************************************************************************
    * Function:
    *    fetchColorName
    * Params:
    *    hexValue:String => the hex value (with leading #)
    * Returns:
    *    Color Name:String
    ********************************************************************************************/
    func fetchColorName(hexValue:String)->String{
        for t in colorsTupleArray{
            if t.hexValue == hexValue {
                return t.colorName
            }
        }
        return ""
    }
    
    /********************************************************************************************
    * Function:
    *    fetchHexValue
    * Params:
    *    colorName:String => the name of the color
    * Returns:
    *    Hex Value:String
    ********************************************************************************************/
    func fetchHexValue(colorName:String)->String{
        for t in colorsTupleArray{
            if t.colorName == colorName {
                return t.hexValue
            }
        }
        return ""
    }
    
    /********************************************************************************************
    * Function:
    *    fetchHSL
    * Params:
    *    key:String => either the name of the color, or the hex value (with leading #)
    * Returns:
    *    HSL value
    ********************************************************************************************/
    func fetchHSL(key:String)->HSL{
        
        var h:HSL = HSL(H:0,S:0,L:0)
        
        for t in colorsTupleArray{
            if key == t.colorName || key == t.hexValue {
                h = t.hsl
            }
        }
        return h
    }
    
    /********************************************************************************************
    * Function:
    *    fetchHSV
    * Params:
    *    key:String => either the name of the color, or the hex value (with leading #)
    * Returns:
    *    HSV value
    ********************************************************************************************/
    func fetchHSV(key:String)->HSV{
        
        var h:HSV = HSV(H:0,S:0,V:0)
        
        for t in colorsTupleArray{
            if key == t.colorName || key == t.hexValue {
                h = t.hsv
            }
        }
        return h
    }
    
    /********************************************************************************************
    * Function:
    *    fetchRandomColor
    * Params:
    *    Void
    * Returns:
    *    ColorTuple => A random row in the colorsTupleArray
    ********************************************************************************************/
    func fetchRandomColor()->ColorTuple{
        return colorsTupleArray[Int(arc4random_uniform(UInt32(colorsTupleArray.count)))]
    }
 
    /********************************************************************************************
    * Function:
    *    fetchRGB
    * Params:
    *    key:String => either the name of the color, or the hex value (with leading #)
    * Returns:
    *    rgb value
    ********************************************************************************************/
    func fetchRGB(key:String)->RGB{
        
        var r:RGB = RGB(R:0,G:0,B:0)
        
        for t in colorsTupleArray{
            if key == t.colorName || key == t.hexValue {
                r = t.rgb
            }
        }
        return r
    }
    
    
    /********************************************************************************************
    * Function:
    *    hexStringToUIColor
    * Params:
    *    hex:String => String Hex value (with or without the leading #)
    * Returns:
    *    UIColor
    ********************************************************************************************/
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(advance(cString.startIndex, 1))
        }
        
        if (countElements(cString) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    /********************************************************************************************
    * Function:
    *    fetchColorFromArray
    * Params:
    *    index:Int => Integer value as an index to colorsTupleArray
    * Returns:
    *    String
    ********************************************************************************************/
    func fetchColorFromIndex (index:Int) -> String {
        
        return colorsTupleArray[index].colorName
    }
    
    /********************************************************************************************
    * Function:
    *    findSimilarColor
    * Params:
    *    color:UIColor => UIColor for red, green, blue breakdown
    * Returns:
    *    String
    ********************************************************************************************/

    func findSimilarColor (colorName:String, upperLower:String) -> String {
        var bestMatch:String = colorsTupleArray[0].colorName
        var randColor:ColorTuple = fetchRandomColor()
        
        var distance:Double = findColorDifference(colorName, color2: colorsTupleArray[0].colorName)
        
        var color:RGB = fetchRGB(colorName)
        
        for var i = 0; i < colorsTupleArray.count; i++ {
            var prevDistance:Double = distance
            distance = findColorDifference(colorName, color2: colorsTupleArray[i].colorName)
            var ctaR:Double = colorsTupleArray[i].rgb.R;
            var ctaG:Double = colorsTupleArray[i].rgb.G;
            var ctaB:Double = colorsTupleArray[i].rgb.B;
            
            if  (upperLower == "lower")
                && (ctaR < color.R) && (color.R > ctaR - distance)
                && (ctaR < color.G) && (color.G > ctaG - distance)
                && (ctaR < color.B) && (color.B > ctaB - distance){
                 
                if prevDistance > distance {
                    bestMatch = colorsTupleArray[i].colorName
                }
                    
            }else if (upperLower == "upper")
                && (ctaR > color.R) && (color.R < ctaR + distance)
                && (ctaR > color.G) && (color.G < ctaG + distance)
                && (ctaR > color.B) && (color.B < ctaR + distance){
                    
                if prevDistance > distance {
                    bestMatch = colorsTupleArray[i].colorName
                }
                    
            }
        }
        
        return bestMatch
    }
    
    func findColorDifference (color1:String, color2:String) ->Double {
        var distance:Double
        var e1:RGB = fetchRGB(color1)
        var e2:RGB = fetchRGB(color2)
        
        var rDiff:Double = (e2.R-e1.R) * 0.3
        var gDiff:Double = (e2.G-e1.G) * 0.59
        var bDiff:Double = (e2.B-e1.B) * 0.11
        
        rDiff = rDiff*rDiff
        gDiff = gDiff*gDiff
        bDiff = bDiff*bDiff
        
        return rDiff + gDiff + bDiff
        
    }
    
    /********************************************************************************************
    * Function:
    *    printColors - Debug helper function
    * Params:
    *    Void
    * Returns:
    *    Void
    ********************************************************************************************/
    func printColors(){
        //println(colorsTupleArray.count)
        for var i = 0; i < colorsTupleArray.count; i++ {
            println("\(colorsTupleArray[i].hexValue) : \(colorsTupleArray[i].colorName)")
        }
    }

}

