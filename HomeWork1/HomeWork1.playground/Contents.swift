import UIKit
import PlaygroundSupport

class ViewController : UIViewController, UITextFieldDelegate {
     
     let calculate = UIButton(frame: CGRect(x: 90, y: 200, width: 200, height: 33))
     let input = UITextField(frame: CGRect(x: 160, y: 150, width: 200, height: 24))
     let label = UILabel()
     let info = UILabel()
     let fibonacci = UILabel()
     let factorial = UILabel()
     let pi = UILabel()
     
     override func viewDidLoad() {
          super.viewDidLoad()
          
          let view = UIView()
          view.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
          
          view.addSubview(info)
          info.frame = CGRect(x: 15, y: 33, width: 333, height: 500)
          info.text = "Here you can calculate: factorial of chosen number, fibonacci sequence till specified N and N digit of PI number fraction"
          info.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
          info.numberOfLines = 0
          info.lineBreakMode = .byWordWrapping
          info.sizeToFit()
          info.textAlignment = .center
          
          view.addSubview(label)
          label.frame = CGRect(x: 15, y: 150, width: 200, height: 20)
          label.text = "Enter the number:"
          label.textColor = .white
          
          view.addSubview(input)
          input.backgroundColor = .white
          input.delegate = self
          
          view.addSubview(calculate)
          calculate.backgroundColor = .white
          calculate.setTitle("Calculate", for: .normal)
          calculate.setTitleColor(#colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), for: .normal)
          calculate.addTarget(self, action: #selector(calculatePressed(sender:)), for: UIControl.Event.touchUpInside)
          
          view.addSubview(fibonacci)
          fibonacci.frame = CGRect(x: 15, y: 300, width: 333, height: 100)
          fibonacci.text = ""
          fibonacci.textColor = .white
          fibonacci.numberOfLines = 0
          fibonacci.lineBreakMode = .byWordWrapping
          
          view.addSubview(factorial)
          factorial.frame = CGRect(x: 15, y: 375, width: 333, height: 100)
          factorial.text = ""
          factorial.textColor = .white
          factorial.numberOfLines = 0
          factorial.lineBreakMode = .byWordWrapping
          
          view.addSubview(pi)
          pi.frame = CGRect(x: 15, y: 450, width: 333, height: 100)
          pi.text = ""
          pi.textColor = .white
          pi.numberOfLines = 0
          pi.lineBreakMode = .byWordWrapping
          
          self.view = view
    }
     
     @objc func calculatePressed(sender: UIButton) {
          input.endEditing(true)
     }

     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          input.endEditing(true)
         return true
     }

     func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
         if textField.text != "" {
             return true
         } else {
             textField.placeholder = "Enter the number"
             return false
         }
     }

     func textFieldDidEndEditing(_ textField: UITextField) {
          if let number = input.text {
               let num = Int(number)
               
               guard num != nil else {
                    input.text = ""
                    textField.placeholder = "Input must be a number"
                    return
               }
               let n = num!
               
               guard n >= 0 else {
                    input.text = ""
                    textField.placeholder = "Input must be a positive number"
                    return
               }
               
               let fact = Factorial(n)
               let fib = Fibonacci(n)
               let piNumber = Pi(n)
               
               fibonacci.text = "Fibonacci sequence till \(n) is: \(fib.fibonacci(n))"
               factorial.text = """
Factorial of number \(n) is:
-iteration \(fact.iterationFactorial(n))
-recursive version: \(fact.recursiveFactorial(n))
"""
               pi.text = "\(n) digit of Pi number fraction is: \(piNumber.pi(to: n))"
               
          }
          input.text = ""
          textField.placeholder = "For example: 3"
     }
     
}

PlaygroundPage.current.liveView = ViewController()

class Factorial {
     var n: Int

     init(_ n: Int) {
          self.n = n
     }

     func recursiveFactorial(_ n: Int) -> Int {
          var result: Int = 1
          
          if n == 0 {
               return 1
          }
          result = n * recursiveFactorial(n-1)
          return result
     }

     func iterationFactorial(_ n: Int) -> String {
          if n == 0 {
               return "1"
          }
          
          var result: Int = 1
          
          for i in 2...n {
               result *= i
          }
          return "\(result)"
     }
}

class Fibonacci {
     var n: Int

     init(_ n: Int) {
          self.n = n
     }

     func fibonacci(_ n: Int) -> String {
          var a = 0
          var b = 1
          var c: Int
          guard n >= 1 else { return "\(a)" }
          
          var s: [Int] = [a]
          
          for i in 2...n+1 {
               c = a + b
               a = b
               b = c
               s.append(a)
          }
//          (2...n).forEach { _ in
//              (a, b) = (a + b, a)
//          }
          return "\(s)"
     }
}

class Pi {
     var n: Int

     init(_ n: Int) {
          self.n = n
     }
     
     func pi(to n: Int) -> String {
          
          guard n >= 0 && n <= 16 else {
               return "Please input range from 0 to 16"
          }
          
          let factor = (pow(10, n) as NSDecimalNumber).doubleValue
          let piResult: Double = Double(round(Double.pi * factor) / factor)
          return "\(piResult)"
     }
}

