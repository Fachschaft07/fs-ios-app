//
//  MarkdownParser.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 06.07.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

struct Fonts {
    static let header: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 28.0)!
    static let headerItalic: UIFont = UIFont(name: "Helvetica-BoldOblique", size: 28.0)!
    static let normalText: UIFont = UIFont(name: "HelveticaNeue", size: 12.0)!
    static let boldText: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 12.0)!
    static let italicText: UIFont = UIFont(name: "HelveticaNeue-Italic", size: 12.0)!
    static let boldItalicText: UIFont = UIFont(name: "Helvetica-BoldOblique", size: 12.0)!
}


class MarkdownParser{
    
    private enum State {
        case NormalText
        case Header
        case Italic
        case HeaderItalic
        case Newline
        case List
        
        
        case err
        
        func changeState(newChar: Character) -> State {
            var newState = State.err
            switch self {
            case NormalText:
                newState = State.NormalText
                switch newChar{
                case "#":
                    newState = State.Header
                case "*":
                    newState = State.Italic
                case "\n":
                    newState = State.Newline
                default:
                    break
                }
            case .Italic:
                newState = State.Italic
                switch newChar {
                case "*":
                    newState = State.NormalText
                default:
                    break
                }
            case .Header:
                newState = State.Header
                switch newChar {
                case "\n":
                    newState = State.Newline
                case "*":
                    newState = State.HeaderItalic
                default:
                    break
                }
            case .HeaderItalic:
                newState = State.HeaderItalic
                switch newChar {
                case "*":
                    newState = State.Header
                default:
                    break
                }
            case .Newline:
                switch newChar {
                case ".":
                    newState = State.List
                case "*":
                    newState = State.Italic
                case "#":
                    newState = State.Header
                case "\n":
                    newState = State.Newline
                default:
                    newState = State.NormalText
                }
                break
            case .List:
                newState = State.NormalText
                
            default:
                break
            }
            return newState
        }
        
    }
    
    private let bulletPoint: Character = "•"
    func calc(source: String) -> NSAttributedString {
        var completeString = NSMutableAttributedString()
        var currentState = State.NormalText
        var currentText: String = ""
        for char in source {
            var newState = currentState.changeState(char)
            if(currentState != newState){
                if newState == State.Newline {
                    currentText += "\n"
                }
                //print(currentText)
                switch currentState{
                case State.NormalText:
                    completeString.appendAttributedString(NSAttributedString(string: currentText, attributes: NSDictionary(object: Fonts.normalText,forKey: NSFontAttributeName) as [NSObject : AnyObject]))
                    currentText = ""
                case State.Newline:
                    switch newState {
                    case State.List:
                        currentText = "\(bulletPoint) "
                        newState = State.NormalText
                    case State.NormalText:
                        currentText = "\n\(char)"
                    default:
                        completeString.appendAttributedString(NSAttributedString(string: currentText, attributes: NSDictionary(object: Fonts.normalText,forKey: NSFontAttributeName) as [NSObject : AnyObject]))
                        currentText = ""
                    }
                    break
                case State.Header:
                    completeString.appendAttributedString(NSAttributedString(string: currentText, attributes: NSDictionary(object: Fonts.header,forKey: NSFontAttributeName) as [NSObject : AnyObject]))
                    currentText = ""
                case State.HeaderItalic:
                    completeString.appendAttributedString(NSAttributedString(string: currentText, attributes: NSDictionary(object: Fonts.headerItalic,forKey: NSFontAttributeName) as [NSObject : AnyObject]))
                    currentText = ""
                case State.Italic:
                    completeString.appendAttributedString(NSAttributedString(string: currentText, attributes: NSDictionary(object: Fonts.italicText,forKey: NSFontAttributeName) as [NSObject : AnyObject]))
                    currentText = ""
                case State.List:
                    break
                default:
                    break
                }
                
            } else {
                currentText.append(char)
            }
            currentState = newState
        }
        return completeString
        
    }    
}