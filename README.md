# LeboncoinTest

## Project Overview
This project is a classified ads browser application built with:

- Xcode 16.2
- iOS 16+ support
- Swift 5.9
- Hybrid architecture: UIKit (project base and ad list) + SwiftUI (ad details view)

The architecture follows an MVVM-C pattern with additional components such as Interactors and ApiServices to enforce the Single Responsibility Pattern, making the codebase easier to refactor and test.

## Package Structure
The project is divided into several packages:

- **Pandora**: Contains base classes and utility helpers
- **LeboncoinUIKit**: Design system package holding UI-related components such as colors, UI extensions, and subviews
- **Network**: Contains all network-related code
- **Ads**: Feature module containing everything related to the display of `Ads`. Imports `Pandora`, `Network`, and `LeboncoinUIKit`, serving as a template for other feature modules

## Testing
The project uses the new Swift Testing framework throughout all test suites, moving away from XCTest for a more modern testing approach.

### Test Coverage
Most components of the app are tested, including:
- View models
- Services
- Interactors
- Network package

### Testing Infrastructure
- Created extensive sample data and mock objects to facilitate testing
- Implemented mocks for various services and dependencies
- In a future iteration, would create dedicated Mock packages (`PandoraMock`, `NetworkMock`, `AdsMock`) that other packages could import for testing purposes

Some areas like extensions were not tested due to time constraints but would be included in future iterations.

## Features Implementation

### Ad List
- Currently loads all data at once as the service doesn't offer pagination
- Uses an efficient image loading system with thumbnail-to-full-image progression

### Image Loading
- Implemented a custom `ImageLoader` that caches up to 1000 images or 5GB
- These limits are configurable and could be exposed to user settings in a full implementation
- Images load in two stages: thumbnail first, then full image with a smooth transition

### Ad Details
- Implemented in SwiftUI while maintaining design consistency with the UIKit components
- Reuses the same image loading logic, ensuring consistent behavior

## Potential Improvements
With additional time, these enhancements would be implemented:

1. **Caching**:
   - Add an `AdListRepository` for data persistence
   - Implement offline support with cached data
   - Display cached data first while fetching fresh data

2. **User Experience**:
   - Add loading indicators to the ad list
   - Implement better error handling with user-friendly messages
   - Improve animations and transitions

3. **Additional Features**:
   - Filtering and sorting options
   - Search functionality
   - Favorite/bookmark system

## Screenshots

### Ad List

| iPhone Light Mode | iPhone Dark Mode | iPad Light Mode | iPad Dark Mode |
|-------------------|------------------|-----------------|----------------|
| <img src="https://github.com/user-attachments/assets/b064fa3e-b9db-4fc2-9470-04d14f6d8ed4" width=420>      | <img src="https://github.com/user-attachments/assets/506fd378-be2f-4f3c-852e-f570651cbc5f" width=420>    | <img src="https://github.com/user-attachments/assets/fa051b8f-1382-4d99-8a2b-dc2864ed7f13" width=840>    | <img src="https://github.com/user-attachments/assets/4cb46578-9c87-425c-b220-55062a43dfdd" width=840>   |


### Ad Details

| iPhone Light Mode | iPhone Dark Mode | iPad Light Mode | iPad Dark Mode |
|-------------------|------------------|-----------------|----------------|
| <img src="https://github.com/user-attachments/assets/96d47afb-28f2-48c6-bec6-db3f65a08ef0" width=420>      | <img src="https://github.com/user-attachments/assets/7689359e-b481-448f-b53b-4c9c2a433ea9" width=420>    | <img src="https://github.com/user-attachments/assets/c5153ac6-5dd4-4032-8c77-c40dff80d6ca" width=840>    | <img src="https://github.com/user-attachments/assets/8129c489-3b0c-4be5-8e7d-861124de878e" width=840>   |

## Conclusion
I found this project to be a nice balance between simplicity and depth. While the core functionality wasn't overly complex, I wanted to take the time to build something I'd be proud to work on in a real-world setting.

I'm happy with how the image loading system turned out, but there are definitely areas I'd love to improve with more time. The error handling is functional but minimal, and I'd definitely want to add proper caching to make the app more resilient to connectivity issues.

Overall, I think this represents a solid foundation that demonstrates good architecture principles while remaining adaptable to future changes and expansions.
