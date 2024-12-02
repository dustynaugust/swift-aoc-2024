import Algorithms
import Parsing



struct Day01: AdventDay {
  struct Model {
    let lines: [(left: Int, right: Int)]
  }

  struct Line {
    let left: Int
    let right: Int
  }

  struct LineParser: Parser {
    var body: some Parser<Substring, Line> {
      Parse(Line.init) {
        Int.parser()
        Whitespace()
        Int.parser()
      }
    }
  }

  struct LinesParser: Parser {
    var body: some Parser<Substring, [Line]> {
      Many {
        LineParser()
      } separator: {
        Whitespace()
      } terminator: {
        Whitespace()
      }
    }
  }




  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: Zip2Sequence<[Int], [Int]> {
    do {
      let lines = try LinesParser().parse(data)
      var left = [Int]()
      var right = [Int]()

      for line in lines {
        left.append(line.left)
        right.append(line.right)
      }

      left.sort()
      right.sort()

      return zip(left, right)

    } catch {
      print(error)
      return zip([Int](), [Int]())
    }

//    data
//      .split(separator: "\n")
//      .compactMap(String.init)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    // Calculate the sum of the first set of input data
    entities.reduce(into: 0) { partialResult, line in
      partialResult += abs(line.0 - line.1)
    }
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var rightMap = [Int: Int]()

    for (_, right) in entities {
      let current = rightMap[right, default: 0]
      rightMap[right] = current + 1
    }

    var sum = 0
    for (left, _ ) in entities {
      let frequency = rightMap[left, default: 0]
      let value = left * frequency
      sum += value
    }
    // Sum the maximum entries in each set of data
//    entities.map { $0.max() ?? 0 }.reduce(0, +)
    return sum
  }
}
