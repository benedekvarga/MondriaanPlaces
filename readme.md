# Mondriaan Places

## Schemes
- **MondriaanPlaces**
  - developer, with system language (default is English)
- **MDC Helyek**
  - production, with forced Hungarian language
- **MDC POIs**
  - production, with forced English language
   
All of the schemes have different bundle identifiers, thus they are installed as separate apps. Minimum deployment target is iOS 12.0.

## Architecture and Design
- **MVVM with RXSwift** backed by protocols and dependency injection.
- _ViewModel_ is completely indepentent from the _View_, it does not have a weak reference for the `viewController`.
- All types of views have _ViewModel_, not just the `viewController`s.
- Input can be given to the _ViewModel_ by _InputModel_ if necessary to avoid long list of init arguments.
- _Protocols_ are used every possible place to enforce encapsulation, replacebility and testability.
- _Swinject_ is used for dependency injection, objects are registered and resolved from `MdcContainer` singleton.
- Unit tests validates viewModels' business logic.

## Project Structure
- **Main**: `AppDelegate` and `SceneDelegate`
- **AppModules**:
  - **Groups of features**: PlaceList, PlaceDetails
  - **MondriaanPlacesCore**: Entities, services, app specific extensions...
- **CoreModules**: Collection of extensions, services, utility tools which can be used independently from MondriaanPlaces.
- **Resources**: Fonts, images, localized strings.

## 3rd Party 
- [Closures](https://github.com/vhesener/Closures): tap handling
- [GoogleMaps](https://github.com/googlemaps/maps-sdk-for-ios-samples): map provider
- [Moya/RxSwift](https://github.com/Moya/Moya): reactive networking library
- [Reachability](https://github.com/ashleymills/Reachability.swift): status of network reachability
- [RxSwift and RxCocoa](https://github.com/ReactiveX/RxSwift): supporting reactive programming
- [RxDataSources](https://github.com/RxSwiftCommunity/RxDataSources): bind data to `UITableView` and `UICollectionView`
- [SnapKit](https://github.com/SnapKit/SnapKit): Auto Layout constraints with ease and less typing
- [Swinject](https://github.com/Swinject/Swinject): dependecy injection
- [Then](https://github.com/devxoul/Then): syntactic sugar for initialization with less typing

## Challenges of Assignment
- Image URLs have whitespaces which must be escaped.
- Images are downloaded when first used.
- Acces token is derived from username and password with Base64 Encoding.
- Description of a place has HTML tags, the UI displays the text accordingly.
- Only a rasterized version of the UI was given, thus the app's GUI is not pixel perfect.
- Time of completion: **~15 hours**
