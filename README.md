# Group Project 4 - *MyMusic*

The app is a music playlist location based aggregator. A user downloads the app, signs in to any one
of the popular music services and the user is then asked to categorize their location. Any category
can be entered such as work, home or the gym then a playlist of music is displayed and played through the app.

## Team

- Kathy Yin
- Arthur Burgin Jr
- Naresh Yerneni

## Parse server setting reference
on ParseServer index.js

var databaseUri = 'mongodb://dbadmin:contnet#2017@ds033116.mlab.com:33116/codepath_mymusic'

if (!databaseUri) {
console.log('DATABASE_URI not specified, falling back to localhost.');
}

var api = new ParseServer({
databaseURI: databaseUri || 'mongodb://localhost:27017/dev',
cloud: process.env.CLOUD_CODE_MAIN || __dirname + '/cloud/main.js',
appId: process.env.APP_ID || 'com.yerneni.MyMusic',
masterKey: process.env.MASTER_KEY || 'BABCACF1095628409D2801FD7B2D1C8A2794AD0C727B34CA', //Add your master key here. Keep it secret!
serverURL: process.env.SERVER_URL || 'https://mymusic2017.herokuapp.com/parse',//'http://localhost:1337/parse',  // Don't forget to change to https if needed
clientKey: 'client key',
liveQuery: {
classNames: ["Posts", "Comments"] // List of classes to support for query subscriptions
},
auth: {
facebook: {
appIds: "fb app id"
},
twitter: { consumer_key: "consumer key", 
consumer_secret: "consumer secret"
}

}
});

## client Parse configure reference 
Appdelegate.m 


let configuration = ParseClientConfiguration {
    $0.applicationId = "bundle id"
    $0.server = "https://mymusic2017.herokuapp.com/parse"
    $0.clientKey = "client key"
}

Parse.initialize(with: configuration)
FBSDKSettings.setAppID("fbAppId") //on the fb develper account
PFFacebookUtils.initializeFacebook(applicationLaunchOptions: launchOptions)
PFTwitterUtils.initialize(withConsumerKey: "consumer key", consumerSecret: "consumer secrect")

Also need to change the url type in the info plist

## dependancy

parse set up on client side with cocopods  
pod 'Parse'
pod 'ParseFacebookUtilsV4'
pod ‘ParseTwitterUtils’
pod ‘ParseUI’	

parse setup on serveral side 
parse sever with mlab + heroku
server url : 

## Video Walkthrough

Here's a walkthrough of implemented parse login with twitter and fb. 
Note # need to review the flow since login with social media still require to log in with spotify
and also spotiy allow to login with fb. might causing user confusion.

<img src='https://media.giphy.com/media/3o7buaxpLP5LU4qeBy/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
1) This week has a lot freedom but actually also feel much harder since there are no hint and instructions to follow.
2) configuration sdk and environment taking lots of time and stilly a littly buggy to using the built in function with parse server. Will either find a solution or change to the firebase really soon after more reasearch.
3) was able to using google sign in sdk on ios only to get access token but having hard time to combine with parse server.

## License

    Copyright [2017] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
