# MovieAppCaseStudy
Teknasyon Case Study - Movie application

An iOS application which users may discover popular movies, explore detailed information about specific films, and view the cast members.

## Screenshots
<div style="display: flex; flex-direction: row;">
  <img src="https://github.com/elanuryoktan/MovieAppCaseStudy/assets/155082508/ff1d5065-16d5-4a99-9f86-d34b066c509b" alt="Screenshot 1" width="400">
  <img src="https://github.com/elanuryoktan/MovieAppCaseStudy/assets/155082508/3f46196f-d370-4234-babf-6bf03cf0c149" alt="Screenshot 2" width="400">
</div>

## Installation

This project uses CocoaPods for framework management.

   ```
   $ pod install 
   ```
## Development Details

- MVVM design pattern is used.
- RxSwift is used to handle asyncronous operations.
- `UICollectionViewDiffableDataSource` is used to manage list data and manage different movie detail views.
- Sourcery was used to automatically generate mock files, streamlining the process of writing tests.
