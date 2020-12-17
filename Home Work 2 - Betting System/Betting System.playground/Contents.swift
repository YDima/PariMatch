import UIKit

//Implement a simple betting system with the following features:
//     - When authorized, a regular user should be able to place a new bet
//     - A bet is a simple string which contains description of an event.
//     - An authorized user should be able to print a list of placed bets
//     - An authorized admin user should be able to browse all registered regular users
//     - An admin user should be able to ban a regular user

protocol SystemUser {
     associatedtype Username: Hashable
     associatedtype Password: Hashable
     associatedtype State: Hashable
     associatedtype Role: Hashable
     
     var username: Username { get set }
     var password: Password { get set }
     var role: Role { get set } // regular or admin
     var state: State { get set } // authorized or banned or unauthorized
     
}

enum State: String, Equatable {
     case authorized
     case unauthorized
     case banned
}

enum Role: String {
     case admin
     case regular
}

enum UserError: Error {
     case AccountAlreadyExists
     case AccountIsNotInThisSystem
     case PasswordIsDifferent
     case UserIsBanned
}

class User: SystemUser, Hashable {
     var username: String
     var password: String
     var role: Role
     var state: State
     
     init(username: String, password: String, role: Role, state: State) {
          self.username = username
          self.password = password
          self.role = role
          self.state = state
     }
}

struct Bet {
     var bet: String
}

class Storage {
     var users: [User] = []
     var bets: [User: [Bet]] = [:]
}

class BettingSystem {
     var users = Storage().users
     var bets = Storage().bets
     
     func isNew(user: User) -> Bool {
          guard users.first(where: { $0.username == user.username }) != nil else {
               return true
          }
          return false
     }
     
     func checkPassword(user: User) -> Bool {
          guard users.first(where: { $0.username == user.username && $0.password == user.password }) != nil else {
                    return false
               }
               return true
     }
     
     func editUserState(user: User, newState: State) -> User {
          let user = users.first(where: { $0.username == user.username })
          user!.state = newState
          users.removeAll(where: { $0.username == user!.username })
          users.append(user!)
          return user!
     }
     
     func authorize(user: User) throws -> User{
          if user.state == .unauthorized {
               editUserState(user: user, newState: .authorized)
               return user
          } else if user.state == State.banned {
               throw UserError.UserIsBanned
          } else {
               return user
          }
          
     }
     
     func register(_ user: User) throws -> User{
          guard isNew(user: user) else{
               throw UserError.AccountAlreadyExists
          }
          
          users.append(user)
          
          do {
               try authorize(user: user)
          } catch UserError.UserIsBanned {
               print("This account was banned")
          }
          return user
          
     }

     func login(_ user: User) throws {
          guard !isNew(user: user) else {
               throw UserError.AccountIsNotInThisSystem
          }
          guard checkPassword(user: user) else {
               throw UserError.PasswordIsDifferent
          }
          do {
               try authorize(user: user)
          } catch UserError.UserIsBanned {
               print("This account was banned")
          }
          
     }

     func logout(_ user: User) throws {
          guard !isNew(user: user) else {
               throw UserError.AccountIsNotInThisSystem
          }
          
          if user.state == State.authorized {
               editUserState(user: user, newState: .unauthorized)
          } else if user.state == State.banned {
               throw UserError.UserIsBanned
          } else {
               return
          }
     }
     
     func placeBet() {
          
     }
     
     func printAllBets() {
          
     }
     
     func banRegularUser() {
          
     }

     func browseUsers() {
          let regular = users.filter({$0.role == .regular})
          let allUsers = regular.map{$0.username }.joined(separator: "\n")
          print(allUsers)
     }
     
}

var newUser = User(username: "New", password: "New", role: .regular, state: .unauthorized)
var sys = BettingSystem()

newUser = try sys.register(newUser)
sys.browseUsers()
var users = Storage().users

print(newUser.state)


//
//do {
//     try user.register(&newUser)
//} catch UserError.AccountAlreadyExists{
//     print("This username is already taken, please choose another one")
//}
//print(user.users)
//print(admin.users)
//newAdmin.browseUsers()
//
//do {
//     try user.login(&newUser)
//} catch UserError.AccountIsNotInThisSystem {
//     print("This account is not in the system, create a new one")
//} catch UserError.PasswordIsDifferent {
//     print("Password is different")
//} catch UserError.UserIsBanned {
//     print("This account was banned")
//}
//
//do {
//     try user.logout(&newUser)
//} catch UserError.AccountIsNotInThisSystem {
//     print("This account is not in the system, create a new one")
//} catch UserError.UserIsBanned {
//     print("This account was banned")
//}

