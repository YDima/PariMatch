import UIKit

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

enum State: Hashable {
     case authorized
     case unauthorized
     case banned
}

enum Role: Hashable {
     case admin
     case regular
}

enum UserError: Error {
     case AccountAlreadyExists
     case AccountIsNotInThisSystem
     case PasswordIsDifferent
     case UserIsBanned
     case AnotherUserInTheSystem
     case CantBanAdmin
     case ThereIsNoBetsPlaced
}

class User: SystemUser {
     var username: String
     var password: String
     var role: Role
     var state: State
     
     init() {
          self.username = ""
          self.password = ""
          self.role = .regular
          self.state = .unauthorized
     }
     
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

struct Storage {
     var users: [User] = []
     var bets: [Bet] = []
     var userBets: [User.Username: [Bet]] = [:]
}

class BettingSystem {
     var users = Storage().users
     var userBets = Storage().userBets
     var bets = Storage().bets
     var currentSystemUser = User()
     
     func isNew(username: User.Username) -> Bool {
          guard users.first(where: { $0.username == username }) != nil else {
               return true
          }
          return false
     }
     
     func checkPassword(user: User, password: User.Password) -> Bool {
          guard users.first(where: { $0.username == user.username && $0.password == password}) != nil else {
               return false
          }
          return true
     }
     
     func editUserState(user: User, newState: State) -> User {
          let user = users.first(where: { $0.username == user.username })
          user!.state = newState
          
          return user!
     }
     
     func authorize(user: User) throws {
          if user.state == .unauthorized {
               currentSystemUser = editUserState(user: user, newState: .authorized)
          } else if user.state == State.banned {
               throw UserError.UserIsBanned
          } else {
               currentSystemUser = user
          }
          
     }
     
     func register(_ username: User.Username, _ password: User.Password, _ role: User.Role) throws {
          guard !otherUserInTheSystem() else {
               throw UserError.AnotherUserInTheSystem
          }
          guard isNew(username: username) else{
               throw UserError.AccountAlreadyExists
          }
          
          let user = User(username: username, password: password, role: role, state: .unauthorized)
          
          users.append(user)
          
          do {
               try authorize(user: user)
          } catch UserError.UserIsBanned {
               print("This account was banned")
          }
          
     }

     func login(_ username: User.Username, _ password: User.Password) throws {
          guard !otherUserInTheSystem() else {
               throw UserError.AnotherUserInTheSystem
          }
          guard !isNew(username: username) else {
               throw UserError.AccountIsNotInThisSystem
          }
          let user = users.first(where: {$0.username == username})
          
          guard checkPassword(user: user!, password: password) else {
               throw UserError.PasswordIsDifferent
          }
          do {
               try authorize(user: user!)
          } catch UserError.UserIsBanned {
               print("This account was banned")
          }
     }

     func logout() {
          currentSystemUser = User()
          bets = []
     }
     
     func otherUserInTheSystem() -> Bool{
          guard currentSystemUser.state == .unauthorized else {
               return true
          }
          return false
     }
     
     func placeBet(bet: Bet) {
          guard currentSystemUser.state == .authorized else {
               return
          }
          guard currentSystemUser.role == .regular else {
               return
          }
          bets.append(bet)
          userBets.updateValue(bets, forKey: currentSystemUser.username)
     }
     
     func printAllBets() throws {
          guard currentSystemUser.state == .authorized else {
               return
          }
          guard currentSystemUser.role == .regular else {
               return
          }
          let allBets = userBets[currentSystemUser.username]
          guard allBets != nil else {
               throw UserError.ThereIsNoBetsPlaced
          }
          let list = allBets!.map{$0.bet}.joined(separator: ";\n")
          print(list)
     }
     
     func banRegularUser(username: User.Username) throws {
          guard currentSystemUser.state == .authorized else {
               return
          }
          guard currentSystemUser.role == .admin else {
               return
          }
          let user = users.first(where: {$0.username == username})
          guard user != nil else {
               throw UserError.AccountIsNotInThisSystem
          }
          guard user!.role != Role.admin else {
               throw UserError.CantBanAdmin
          }
          users.first(where: {$0.username == username})?.state = .banned
          print("User was banned.")
     }

     func browseUsers() {
          guard currentSystemUser.state == .authorized else {
               return
          }
          guard currentSystemUser.role == .admin else {
               return
          }
          let regular = users.filter({$0.role == .regular})
          let allUsers = regular.map{ $0.username }.joined(separator: "\n")
          print(allUsers)
     }
     
}

var s = BettingSystem()
var users = Storage().users

do {
     try s.register("New", "New", .admin)
} catch UserError.AccountAlreadyExists {
     print("This username is already taken, please choose another one")
} catch UserError.AnotherUserInTheSystem {
     print("There is another user in the system")
}

s.logout()

do {
     try s.register("regular", "New", .regular)
} catch UserError.AccountAlreadyExists {
     print("This username is already taken, please choose another one")
} catch UserError.AnotherUserInTheSystem {
     print("There is another user in the system")
}
//
//s.logout()
//
//do {
//     try s.login("New", "New")
//} catch UserError.AccountIsNotInThisSystem {
//     print("This account is not in the system, create a new one")
//} catch UserError.PasswordIsDifferent {
//     print("Password is different")
//} catch UserError.UserIsBanned {
//     print("This account was banned")
//} catch UserError.AnotherUserInTheSystem {
//     print("There is another user in the system")
//} catch {
//     print("Something")
//}
//
//do {
//     try s.banRegularUser(username: "regular")
//} catch UserError.AccountIsNotInThisSystem {
//     print("This account is not in the system, create a new one")
//} catch UserError.CantBanAdmin {
//     print("You can't ban other admins!")
//}
//

var bet = Bet(bet: "TampaBay Lightnings vs. Pittsburg Penguins")
s.placeBet(bet: bet)

do {
     try s.printAllBets()
} catch UserError.ThereIsNoBetsPlaced {
     print("You don't have placed bets.")
}

