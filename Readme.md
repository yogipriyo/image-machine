
# Machine Image

Nowadays, people tend to generate tons of images daily and it becomes harder and harder to group all those images and manage them efficiently. Here comes the image grouping application that will help ease people’s lives.
This is code test is to create a iOS application to help grouping images from your photo gallery and easily access them also.

This iOS application also serves as my take home technical interview for ProSpace.

### Prerequisites
This app is built using macOS Ventura v13.0.1 and XCode v14.1
This app doesn't use any third party library so it doesn't need to install any additional library.

### Building
You just need to tap on build or run button. Alternatively you can use "Command Button + B" or "Command Button + R" to build or run it.

### Highlighted Tech
The special request for this application is that the application needs to be able to retain all the information the next time user reopen the app / restart their phone. So I need to store data locally and here I use the native database for iOS Application Development which is Core Data.

### Approach & Design
As this application has 2 main features (Machine Image Managenement & QR Code Scanner), I decided to use bottom tabbar based structure to navigate between those features.
So the user will know immediately that they have those main features. As for the other features will belong to Machine Management feature.
The whole feature map will look like this :

- Home 
    - QRCode Reader
    - Machine List
        - Add Machine
        - Machine Details
            - Edit Machine
            - Images Picker
            - Image Removal
            - Delete Machine

And here is the features diagram :

![Machine Image Diagram](https://user-images.githubusercontent.com/855407/209255318-87fac512-260c-485f-a282-fc381d7db16f.jpg)



