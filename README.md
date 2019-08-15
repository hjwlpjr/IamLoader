# IamLoader
A lightweight swift library for loading images and JSON

# How to use IamLoader Image

<img align="right" src="https://github.com/hjwlpjr/IamLoader/blob/master/rounded.png" width="360"/>

Load image using IamLoader is very easy with only one single line
```swift
IamLoaderImage.loadImage(urlString: url)
```

# Image Cache

Don't worry, Image Cache is handled automatically so no heavy request image data repeatly. By default IamLoader can cache up to 50 image 
and will start deleting old cache that is least used.

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br /><br /><br /><br /><br /><br /><br /><br /><br />
<br />

# What other Feature IamLoaderImage support?

<img align="right" src="https://github.com/hjwlpjr/IamLoader/blob/master/circle.png" width="360"/>

IamLoader has built-in multiple image shape option, just pass the parameter and ready to go
```swift
.resize(withSize: imageSize)
.makeShape(withShape: .round, radiusForRound: 8) // for rounded
.makeShape(withShape: .circle) // for circle
```

# Fetch JSON Data

Under the hood IamLoaderRequest use built-in NSURLSession and Decodable protocol to fetch and decode JSON data with Swift 5 
Result Type as completion handler

```swift
IamLoaderRequest.fetchData(apiUrl: apiUrl, type: .json) { (res: Result<T, RequestError>) in ... }
```

# string interpolation for query string? = NO

IamLoader support for constructing query string using class/struct with decodable

```swift
struct Pagination: Decodable {
  let pageSize: Int
  let currentPage: Int
}

...

let params = Pagination(...)

IamLoaderRequest.fetchDataWithParams(apiUrl: apiUrl, parameter: params, type: .json) { (res: Result<T, RequestError>) in ... }
```
