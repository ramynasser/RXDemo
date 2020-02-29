
`Logger` is a logging framework .

### Usage

#### The basics

- Use `Logger` just as you would use `print`.

```swift
let log = Logger.shared

log.logItem("this is error", level: .error)
log.logItem("this is verbose", level: .verbose)
```
#### Customization

- Create your own `Logger` by changing its `Formatter`.
```swift
extension Formatters {
    public static let `default` = Formatter("[%@] %@ %@: %@", [
        .date("yyyy-MM-dd HH:mm:ss.SSS"),
        .level,
        .location,
        .message
    ]) 
}
```
```swift
log.setup(formatter: .default)
```
- Create your own `Logger` by changing its `Storage` .
 * by implement your storage inhert from Storage and change log to it 
```swift
class ApiStorage: Storage {
  func saveLog(logItem: LogItem) {
    // your implementation for saving logs 
  }
  func getLogs() -> [LogItem] {
   // your implementation for get logs 
  }
  func deleteLogs() {
      // your implement for remove log 
  }
}
// change log stoage 
log.changeStorage(to: ApiStorage())

```

