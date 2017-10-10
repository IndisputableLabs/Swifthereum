# Swifthereum

[![CI Status](http://img.shields.io/travis/git/Swifthereum.svg?style=flat)](https://travis-ci.org/git/Swifthereum)
[![Version](https://img.shields.io/cocoapods/v/Swifthereum.svg?style=flat)](http://cocoapods.org/pods/Swifthereum)
[![License](https://img.shields.io/cocoapods/l/Swifthereum.svg?style=flat)](http://cocoapods.org/pods/Swifthereum)
[![Platform](https://img.shields.io/cocoapods/p/Swifthereum.svg?style=flat)](http://cocoapods.org/pods/Swifthereum)

Swifthereum is a native Swift iOS and MacOS library to use [Go Ethereum](https://github.com/ethereum/go-ethereum/) (Geth). Swifthereum wraps the Go interface into a Swift-friendly framework for easy and fast development of Swift-native dApps.

Swifthereum includes support for ERC-20 tokens and provides a download option to download a list of the latest tokens.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9 and later
- MacOS 10.10 and later (coming soon)
- Swift 4.0 and later

## Installation

Swifthereum is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Swifthereum'
```

## Usage

### Basics

Start an Ethereum node as part of the main network and synchronize with the Ethereum network:

````swift
do {
	let node = try Node(networkID: .main)
	try node.start()
	let client = try node.ethereumClient()
} catch {
	// Handle error
}
````

A node on the Rinkeby test network can be easily created by invoking ````let node = try Node(networkID: .rinkeby)````.

To the balance of an account

````swift
do {
	let address = try Address(hex:"0x548429264DAcf79e7c96aC00D3d12760922d4c31")
	let balance = try client.balance(for: address)
	print("Balance: \(balance.formattedBalance(.Ether)")
} catch {
	// Handle errors
}
````

## Known Limitations

Swifthereum was developed as part of Indisputable Lab's entry for the Consensys BSIC hackathon. The current version is a pre-release and should not be used in production.

- The Swifthereum API will change radically. A major refactoring of the code is planned.
- As of Geth 1.7.1, Geth passes variables as implicitly unwrapped optionals (e.g. ````GethAddress!````) by default. Swifthereum does not check for nil pointers and will crash if Geth passes a nil pointer as an implicitly unwrapped optional, which can happen. This issue is tracked as Geth issue [#15240](https://github.com/ethereum/go-ethereum/issues/15240).
- The Geth API is not fully implemented yet.
- 
- 


## Contribution

Thank you for your interest in the project. We appreciate contributions.

Make sure to read our guides first:

- Code of Conduct (TODO)
- Contribution Guidelines (TODO)

## Author

Swifthereum is written and maintained by Ronald Mannak and Indisputable Labs. Find me on [Twitter](https://twitter.com/ronaldmannak). 

## License

Swifthereum is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
