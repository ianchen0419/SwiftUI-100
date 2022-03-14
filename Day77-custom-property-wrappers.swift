import Foundation

@propertyWrapper
struct NonNegative<Value: BinaryInteger> {
    var value: Value
    
    init(wrappedValue: Value) {
        if wrappedValue < 0 {
            value = 0
        } else {
            value = wrappedValue
        }
    }
    
    var wrappedValue: Value {
        get { value }
        set {
            if newValue < 0 {
                value = 0
            } else {
                value = newValue
            }
        }
    }
}

var example = NonNegative(wrappedValue: 5)
example.wrappedValue -= 10
print(example.wrappedValue)

struct User {
    @NonNegative var score = 0
}
var user = User()
user.score += 10
print(user.score)

user.score -= 20
print(user.score)
