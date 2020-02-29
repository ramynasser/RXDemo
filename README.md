
`Logger` is a powerful logging framework that provides built-in themes and formatters, and a nice API to define your owns.

### Usage

#### The basics

- Use `Logger` just as you would use `print`.

```swift
let log = Logger.shared

log.logItem("this is error in AppDelegate", level: .error)
log.logItem("this is error in AppDelegate", level: .verbose)
```


- Disable `Logger` by setting `enabled` to `false`:

```swift
log.enabled = false
```

- Define a minimum level of severity to only print the messages with a greater or equal severity:

```swift
Log.minLevel = .warning
```

> The severity levels are `trace`, `debug`, `info`, `warning`, and `error`.

#### Customization

- Create your own `Logger` by changing its `Theme` and/or `Formatter`.

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
let log = Logger(formatter: .detailed, theme: .tomorrowNight)
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

