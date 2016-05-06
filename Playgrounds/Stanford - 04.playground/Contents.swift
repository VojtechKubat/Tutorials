//: Playground - noun: a place where people can play

import Foundation
import UIKit

var str = "Hello, playground"

print(str)

// casting

class Box: NSObject {
    var name: String
    var level: Int
    
    init (name inName: String, level inLevel:Int) {
        name = inName
        level = inLevel
        
        // super init needs to be called AFTER all of the properties are initialized
        super.init()
    }
    
    override var description: String {
        return ">>> Box -name:\"\(name)\" -level:\(level)"
    }
    
}

var heap = [AnyObject]()

heap.append(NSString(string: "Hello world"))
heap.append(NSNumber(int: 50))
heap.append(Box(name: "BigBox", level: 3))

heap.last?.description

if (heap.last is Box) {
    print("It's a Box!")
}

var boxStack = Array<Box>()

boxStack.append(Box(name: "first", level: 2))
boxStack.append(Box(name: "second", level: 1))
boxStack.append(Box(name: "third", level: 6))
boxStack.append(Box(name: "fourth", level: 3))

var result = " - "
for current: Box in boxStack {
    result += current.name + " - "
}
result

//boxStack.sort(
//    {($0 as Box).level < ($1 as Box).level}
//)

//var newBoxStack = boxStack.sort({(A, B) -> Bool in
//    return A.level>B.level
//})

var newBoxStack = boxStack.sort({$0.level>$1.level})

result = " - "
for current: Box in newBoxStack {
    result += current.name + " - "
}
result

newBoxStack = newBoxStack.filter({$0.level%2==0})
//newBoxStack = newBoxStack.filter({(A: Box) -> Bool in
//    if A.level%2 == 0 {
//        return true
//    } else {
//        return false
//    }
//})

result = " - "
for current: Box in newBoxStack {
    result += current.name + " - "
}
result


// map - returns a new array of any type and applies the function on each of the element of the original array
let mappedArray = boxStack.map({"\(($0).name)"})
//let mappedArray = boxStack.map({(A: Box) -> String in
//    return A.name + " - "
//})

mappedArray


// reduce - cumulative operation that goes throug the whole array
// reduce (initial-value, type-of-array) -> inital-value type
let sum: Int = boxStack.reduce(0,
                               combine: ({(A: Int, B: Box) -> Int in
                                    return A + B.level
                               })
)

let boxSum: Box = boxStack.reduce(Box(name: "", level: 0),
                                  combine: {(A:Box, B:Box) -> Box in
                                        return Box(name: "LevelSumBox", level: A.level+B.level)
})


// STRING operations

var word = "Překáží tu čárky ę - ū"

var welcome = "Hello world"
let range = welcome.endIndex.advancedBy(-6)..<welcome.endIndex
welcome.removeRange(range)

let substring = word[word.endIndex.advancedBy(-11)..<word.endIndex.advancedBy(-6)]

var anotherStr = welcome + " - " + substring



// insert 1 character
anotherStr.insert("?", atIndex: anotherStr.endIndex.advancedBy(-6))

// insert string
anotherStr.insertContentsOf("???".characters, at: anotherStr.endIndex.advancedBy(-5))

anotherStr.insertContentsOf(substring.characters, at: anotherStr.endIndex.advancedBy(-10))

// remove range
anotherStr.removeRange(anotherStr.startIndex.advancedBy(6)..<anotherStr.endIndex.advancedBy(-5))

// remove character
let result2 = anotherStr.removeAtIndex(anotherStr.startIndex.advancedBy(5))


let num = "45.938"
if let decimalRange = num.rangeOfString(".") {
    print("\(num[num.startIndex..<decimalRange.startIndex])")
}

num.hasPrefix("45")
num.hasSuffix("38")


// Assertions


//assert( !true, "Something happens") // this will cause crash, can be used for debuging