//
//  Application.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

struct Event {
  let name: String
  let markets: [Markets]
  let scores: [Score]
}

struct Markets {
  let name: String
  let handicapValue: Int
  let selections: [Selections]
}

struct Selections {
  let name: String
  let selectionCode: String
}

struct Score {
  let home: Int
  let away: Int
}

class Application: UIApplication, UIApplicationDelegate {
  
  // MARK: - Properties
  
  var window: UIWindow?
  
  // MARK: - UIApplicationDelegate
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    let window = UIWindow()
    self.window = window
    let service = servicesFactory.createFirstScreenService(window: window)
    service.showFirstScreen()
    
//    var input = [1, 1, 0, 1, 1]
//    var input = [0, 1, 1, 0]
    var input = [1, 0, 0, 1, 0, 1, 0, 0, 0]
//  var input = [1, 0, 1, 0, 1, 0, 1, 0, 1]
    //          [1, 1, 0, 0, 0, 0, 0, 1, 0]
    
//  var input = [0, 1, 0, 1, 0, 1, 0, 1, 0]
    //          [0, 0, 1, 1, 1, 1, 1, 0, 1]
    print(solution(&input))
    
    print(generateMask(startFrom: 0, count: 10))
    
    return true
  }
  
  public func solution(_ A : inout [Int]) -> Int {
    let mask1 = [1, 0, 1, 0, 1, 0, 1, 0, 1]
    let mask2 = [0, 1, 0, 1, 0, 1, 0, 1, 0]
    
    let xorMask1 = xorArray(array1: A, array2: mask1)
    let xorMask2 = xorArray(array1: A, array2: mask2)
    
    var numberOf1Mask1 = 0
    for element in xorMask1 {
      if element == 1 {
        numberOf1Mask1 += 1
      }
    }
    var numberOf1Mask2 = 0
    for element in xorMask2 {
      if element == 1 {
        numberOf1Mask2 += 1
      }
    }
    return min(numberOf1Mask1, numberOf1Mask2)
  }
  
  func xorArray(array1: [Int], array2: [Int]) -> [Int] {
    var result: [Int] = []
    for index in 0..<array1.count {
      result.append(xor(number1: array1[index], number2: array2[index]))
    }
    return result
  }
  
  func xor(number1: Int, number2: Int) -> Int {
    return number1 == number2 ? 1 : 0
  }

  func generateMask(startFrom: Int, count: Int) -> [Int] {
    var result: [Int] = []
    
    for index in 0..<count {
      if startFrom == 0 {
        if index % 2 == 0 {
          result.append(0)
        } else {
          result.append(1)
        }
      } else {
        if index % 2 == 1 {
          result.append(0)
        } else {
          result.append(1)
        }
      }
    }
    
    return result
  }
  
  func flipTheCoin(_ coin: Int) -> Int {
      return coin == 0 ? 1 : 0
  }
  
  public func solution2(_ blocks : [Int]) -> Int {
      var maxFirstFrogSteps = 0
      var maxSecondFrogSteps = 0

      for indexI in 0..<blocks.count {
          var firstFrogSteps = 0
          var secondFrogSteps = 0
          for indexJ in stride(from:indexI, through:0, by:-1) {
              if indexJ != indexI {
                  if blocks[indexJ] >= blocks[indexI] {
                      firstFrogSteps += 1
                  }
              }
          }
          for indexJ in indexI+1..<blocks.count {
              if blocks[indexJ] >= blocks[indexJ - 1] {
                  secondFrogSteps += 1
              }
          }
          if firstFrogSteps >= maxFirstFrogSteps && secondFrogSteps >= maxSecondFrogSteps {
              maxFirstFrogSteps = firstFrogSteps
              maxSecondFrogSteps = secondFrogSteps
          }
      }
      return maxFirstFrogSteps + maxSecondFrogSteps + 1
  }
  
  func printOutcomeSelections(event: Event) {
    let homeScores = getTotalHomeScores(event.scores)
    let awayScores = getTotalAwayScores(event.scores)
    
    for market in event.markets {
      if market.name == "Total Goals Over/Under" {
        let totalScores = getTotalScores(event.scores)
        if totalScores >= market.handicapValue {
          print("selection with code H winning")
        } else {
          print("selection with code L winning")
        }
      } else if market.name == "Half Goal" {
        let difference = homeScores - awayScores + market.handicapValue
        if difference > 0 {
          print("selection with code H winning")
        } else if difference < 0 {
          print("selection with code A winning")
        } else {
          print("selection with code L winning")
        }
      } else if market.name == "Asian Handicap" {
        let correctedHandicap = Double(market.handicapValue) / 4
        let handicapFloatPart = correctedHandicap.truncatingRemainder(dividingBy: 1)
        if handicapFloatPart == 0.75 || handicapFloatPart == 0.25 {
          let handicapPart1 = correctedHandicap - 0.25
          let handicapPart2 = correctedHandicap + 0.25
          
          print(handicapPart1)
          print(handicapPart2)
          // don't know what to compare, selections doesn't have any float values
          
        } else {
          let difference = homeScores - awayScores + market.handicapValue
          
          if difference > 0 {
            print("selection with code H winning")
          } else if difference < 0 {
            print("selection with code A winning")
          } else {
            print("draw")
          }
        }
      }
    }
  }
  
  private func getTotalScores(_ scores: [Score]) -> Int {
    var result = 0
    for score in scores {
      result += score.home + score.away
    }
    return result
  }
  
  private func getTotalHomeScores(_ scores: [Score]) -> Int {
    var result = 0
    for score in scores {
      result += score.home
    }
    return result
  }
  
  private func getTotalAwayScores(_ scores: [Score]) -> Int {
    var result = 0
    for score in scores {
      result += score.away
    }
    return result
  }
  
  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    
    return true
  }
  
  // MARK: - Layers
  
  private lazy var userDefaultsStorage: UserDefaultsStorage = {
    return UserDefaultsStorage(storage: .standard)
  }()
  private lazy var coreDataStorage: CoreDataStorage = {
    return CoreDataStorage(storageName: "CVApp", storeURL: nil)
  }()
  private lazy var referenceStorage = ReferenceStorage()
  
  // MARK: - Factories
  
  private lazy var servicesFactory: ServicesFactory = {
    return ServicesFactory(
      application: self,
      userDefaultsStorage: userDefaultsStorage,
      coreDataStorage: coreDataStorage,
      referenceStorage: referenceStorage,
      session: .shared)
  }()
}
