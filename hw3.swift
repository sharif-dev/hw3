// !!!!!!!!! swift 5.1  !!!!!!! 
import Foundation

class Node {
    var children = [Node?](repeating: nil, count: 26);
    var endWord = false
}

class Trie {
    var root = Node()

    func insert (key : String) {
        var parent = self.root;
        var index : Int;
        for char in key {
            if char.asciiValue != nil {
                index = Int((char.asciiValue)! - (Character("a").asciiValue)!) ;
                if char.isUppercase {
                  index = Int((char.asciiValue)! - (Character("A").asciiValue)!);
                }
                if parent.children[index] == nil { // The character not found 
                    parent.children[index] = Node();
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
                
                index = Int((char.asciiValue)! - (Character("a").asciiValue)!) ;
                if char.isUppercase {
                  index = Int((char.asciiValue)! - (Character("A").asciiValue)!);
                }
                // print(index);
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

    func getInt (char: Character) -> Int {
        var index = Int((char.asciiValue)! - (Character("a").asciiValue)!) ;
        if char.isUppercase {
            index = Int((char.asciiValue)! - (Character("A").asciiValue)!);
        }
        return index;
    }
}

class Table {
  var trie = Trie()
  var tableContent : Array<Array<String>> = Array(); 
  var rows = 0;
  var cols = 0;
  var found = Set<String>();

  // recursive search
  func search(row: Int, col: Int, node: Node!, word: Array<Character>) -> Bool {
      var char = Array(tableContent[row][col])[0];
    
      // not found
      if node == nil{
        return false;
      }
      // found
      if node.endWord {
        found.insert(String(word));
        return true;
      }

      // go to neighboors
      for i in -1...1{
        for j in -1...1{
          if(isNeighboor(row: (row+i), col: (col+j))) {
            char =  Array(tableContent[row+i][col+j])[0];

            if ((node.children[trie.getInt(char: char)] != nil) 
              && search(row: (row+i), col: (col+j), 
              node: node.children[trie.getInt(char: char)], word: word + [char])){
              return true;
            }
          }
        }
      }
      return false;
  }

  // verify row and col
  func isNeighboor (row: Int, col: Int) -> Bool {
      if row < 0 || row >= rows{
        return false;
      }
      if col < 0 || col >= cols{
        return false;
      } 
      return true;
  }
}


// get inputs
var words = readLine()!.lowercased().components(separatedBy: " ") ;
var size = readLine()!.components(separatedBy: " ");
var M = Int(size[0])
var N = Int(size[1])

// create Table
var table = Table();
table.rows = M!;
table.cols = N!;
// insert words into Trie
for word in words{
  table.trie.insert(key: word);
}

// create table cells
var row : Array<String> = Array();
for _ in 1...M!{
    row = readLine()!.components(separatedBy: " ");
    table.tableContent.append(row);
}

// search for words in table
for i in 0...(M!-1){
  for j in 0...(N!-1){
     table.search(row: i, col:j, node: table.trie.root, word: []);
  }
}

// print found words
for foundWord in table.found{
  print(foundWord);
}
