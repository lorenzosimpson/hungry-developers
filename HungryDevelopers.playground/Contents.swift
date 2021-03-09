import UIKit

class Spoon {
    var name: String
    var index: Int
    
    init(name: String, index: Int) {
        self.name = name
        self.index = index
    }
    private var lock = NSLock()
    
    func pickUp(_ holder: String) {
        lock.lock()
        print("\(self.name) picked up by \(holder)...")
    }
    
    func putDown(_ holder: String) {
        print("\(self.name) put down by \(holder)...")
        lock.unlock()
    }
}



class Developer {
    var leftSpoon: Spoon
    var rightSpoon: Spoon
    var name: String
    
    init(_ rightSpoon: Spoon, _ leftSpoon: Spoon, _ name: String) {
        self.rightSpoon = rightSpoon
        self.leftSpoon = leftSpoon
        self.name = name
    }
    
    func think() {
        print("\(self.name) is thinking...")
        if rightSpoon.index < leftSpoon.index {
            rightSpoon.pickUp(self.name)
        } else {
            leftSpoon.pickUp(self.name)
        }
        return
    }
    
    func eat() {
        print("\(self.name) is starting to eat..yum using \(self.rightSpoon.name) and \(self.leftSpoon.name)")
        usleep(UInt32.random(in: 10000...1000000))
        rightSpoon.putDown(self.name)
        leftSpoon.putDown(self.name)
        print("\(self.name): Finished eating, I'm full!")
        return
    }
    
    func run() {
        while true {
            think()
            eat()
        }
    }
}

var spoonA = Spoon(name: "SpoonA", index: 1)
var spoonB = Spoon(name: "SpoonB", index: 2)
var spoonC = Spoon(name: "SpoonC", index: 3)
var spoonD = Spoon(name: "SpoonD", index: 4)
var spoonE = Spoon(name: "SpoonE", index: 5)

var developer_1 = Developer(spoonA, spoonB, "Developer 1")
var developer_2 = Developer(spoonB, spoonC, "Developer 2")
var developer_3 = Developer(spoonC, spoonD, "Developer 3")
var developer_4 = Developer(spoonD, spoonE, "Developer 4")
var developer_5 = Developer(spoonE, spoonA, "Developer 5")


let devs: [Developer] =  [developer_1, developer_2, developer_3, developer_4, developer_5]

DispatchQueue.concurrentPerform(iterations: 5) {
    devs[$0].run()
}
