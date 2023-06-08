# Flutter Home Assessment

This project is a simple Flutter application that allows users to search for an address or retrieve their current location. This app consists of two screens:

## Screens:

1. **Search Screen:**
    - The search screen allows users to input an address and fetch autocomplete suggestions based on their input. The autocomplete suggestions are provided by the Google Geocoder or Places API.
    - It also includes a feature for retrieving the user's current location.
    - After selecting an address from the suggestions or clicking the "Current Location" button, users are directed to the second screen which displays the details of the selected address.

2. **Details Screen:**
    - The details screen displays the selected address details with each address component shown in its corresponding text field.
    - This screen also includes a Google map displaying the selected location.
    - The map updates in real time if any address component is changed in the text fields.

## Getting Started:

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites:

What things you need to install the software:

- Flutter SDK
- Android Studio, VS Code or any IDE with Flutter SDK support.
- An Android or iOS device for testing.

### Installation:

1. Clone the repo
    ```sh
    git clone https://github.com/AlexFox63/pop_test_task.git
    ```
2. Navigate to the project directory
    ```sh
    cd PROJECT_DIRECTORY
    ```
3. Get Flutter packages
    ```sh
    flutter pub get
    ```
4. Run the app
    ```sh
    flutter run
    ```

## Built With:

- [Flutter](https://flutter.dev/)
- [Google Places API](https://developers.google.com/maps/documentation/places/web-service/overview)
- [Google Geocoder API](https://developers.google.com/maps/documentation/geocoding/start)

## Author:

[Your Name](https://github.com/AlexFox63)

## Acknowledgments:

- Thanks to Google for providing their APIs for address search and geocoding.
