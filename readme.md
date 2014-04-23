
### CercaPix  (NearPix)  

## Find Instagram photos near me

### README 

This sample app retrieves a list of images within a search radius around the user's location, using the Instagram media search api. The results are displayed on a map,
which you can then touch to view the photos in a separate view controller.
If there is a map annotation selected, some details about the photo are shown.
Swipe left and right on a photo (in detail mode) to page through the photos.
Tap the detail photo to return to the grid view of the list.

The app tries to lazy-load all image assets, using a category on UIImageView which asynchronously downloads an image while setting a placeholder..
It will attempt one retry before giving up, if the image donwload fails..

The api ingestion method is to serialize the api response as JSON using the built-in json serialzation library, which returns an NSDictionary. Since this app only uses a small portion of the Instagram api, the entries are then retrieved with accessor convenience methods which are added to NSDictionary via a category, `NSDictionary+instagram_api`.
When I started doing that I thought maybe I could use `typedef`s to hide this better,
but you can't write a category on a typedef'd object. Next time I will subclass NSDictionary!


### Prerequisites

- XCode 5.x
- ios 7.1

### Running the app

To use this app set the Instagram Client ID  in `constants.m`
You can get one of these by signing up for Instagram and going to their developer
pages at http://instagram.com/developer/

In `constants.m`, update: 

        
         NSString* const kInstagramClientId              = @"YOUR_CLIENT_ID";


After that, load it up in xcode and give it a while
Please file an issue if it doesn't work.

### Universal app

This app will run on both iPhone and iPad.  (mainly tested on iphone though)

### Known issues:
- There is no network check --  no network, no results, no error message
- If the GPS does not have a good fix, the map region zoom level is wonky
- iPad UI needs work
- If left running for a long time, images fail to download. This probably has something to do with the not-very-robust ImageView category running out of retries.
- Sometimes results appear outside of the user-defined search radius.  Without getting out my cartography tools, I am guessing this is on istagram's side ;-)


