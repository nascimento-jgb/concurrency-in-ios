import SwiftUI
import Foundation

//Part1 - Basic Notions
Task {
    print("Doing some work on a unamed task")
    let sum = (1...100000).reduce(0, +)
    print("Unnamed task: 1 + 2 + 3 ... 100000 = \(sum)")
}

print("Doing some work on the main actor")
print("Doing some MORE work on the main actor")

let secondtask = Task {
    print("Doing some work on a named task")
    let sum = (1...100000).reduce(0, +)
    print("Named task: 1 + 2 + 3 ... 111111 = \(sum)")
}

print("Doing antoher type of work on the main actor")


let specificKey = DispatchSpecificKey<String>()
DispatchQueue.main.setSpecific(key: specificKey, value: "main")
if DispatchQueue.getSpecific(key: specificKey) == "main" {
  print("\nPlayground runs on main actor")
}

// Task doesn't run on main actor
Task {
  print("\nDoing some work on a task")
  if DispatchQueue.getSpecific(key: specificKey) == "main" {
    print("Task runs on main actor")
  } else {
    print("Task doesn't run on main actor")
  }
}

//Part 2: async/await
//URLSession

// TODO: async function to download and decode RW domains
func fetchDomains() async throws -> [Domain] {
    let url = URL(string: "https://api.raywenderlich.com/api/domains")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(Domains.self, from: data).data
}
// TODO: Task to run async function
Task {
    do {
        let domains = try await fetchDomains()
        for domain in domains {
           let attributes = domain.attributes
            print("\(attributes.name): \(attributes.description) - \(attributes.level)")
        }
    } catch {
        print (error)
    }
}


//: ### Asynchronous functions
// TODO: Create asynchronous func helloPauseGoodbye()
func helloPauseGoodbye() async throws {
    print("Hello")
    try await Task.sleep(until: .now + .seconds(1), clock: .continuous)
    print("Goodbye")
}
// TODO: Call asynchronous func helloPauseGoodbye()
Task {
    try await helloPauseGoodbye()
}


//: ### Start here
// TODO: Call asynchronous Task.sleep
// sleep(_:) blocks thread
sleep(1)
print("wake up")
