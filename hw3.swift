// !!!!!!!!! swift 5.1  !!!!!!! 
import Foundation

struct Node {
    var children : Array<Node?> = {
       var returnArray =  Array<Node?>() ;
       
       for _ in 0...25 {
         returnArray.append(nil)   
       } 
       
       return returnArray;
    }() 
    
    var endWord = false
}

class Trie {
    var root = Node()
    
    func insert (key : String) {
        var parent = root;
        var index : Int;
        for char in key {
        
            if char.asciiValue != nil {
                index = Int((char.asciiValue)! - (Character("A").asciiValue)!) 
            
                if parent.children[index] == nil { // The character not found 
                    parent.children[index] = Node()
                }
                parent = (parent.children[index])!
            
            }
            else{
                print("false input!")
                return
            }
        }
        parent.endWord = true ; // at the end of insertion the word will end
    }
    
    func search (key : String) -> Bool {
        var parent = root
        var index : Int;
        for char in key {
        
            if char.asciiValue != nil {
                index = Int((char.asciiValue)! - (Character("A").asciiValue)!) 
            
                if parent.children[index] == nil { // The character not found 
                    return false;
                }
                parent = (parent.children[index])!
            
            }
            else{
                print("false input!")
                return false
            }
        }
        return parent.endWord == true
    }
}

var words = readLine()!.components(separatedBy: " ") ;

var size = readLine()!.components(separatedBy: " ") ;

var M = Int(size[0])
var N = Int(size[1])

var input = ""

for _ in 0...M!{
    input = (readLine())!;
}
