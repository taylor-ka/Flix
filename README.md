# Project 2 - *Flix*

**Flix** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **18** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] User sees an error message when there's a networking error.
- [x] Movies are displayed using a CollectionView instead of a TableView.
- [x] User can search for a movie.
- [x] All images fade in as they are loading.
- [x] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [ ] Customize the selection effect of the cell.
- [x] Customize the navigation bar.
- [ ] Customize the UI.

The following **additional** features are implemented:

- [x] Tab bar.
- [x] View movies by genre.
- [x] Generic images for movies without poster/backdrop.
- [x] User can search all movies using collection view

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Separation of each view controller - what information shoudl be passed along, who should be loading what, etc.
2. How to reduce redundancy between view controllers

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/2G2wo7JxsP.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

- Learning how to debug using xcode and understand the stack trace
- Understanding how create the search bar was difficult, especially in conjuction with the collection view

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [Movie Theater Image](http://www.premierecinemas.net/images/GenericMovieTheater.jpg)
- [Generic Movie Poster](http://www.rgbstock.com/cache1nToqD/users/g/gr/greekgod/300/mlns11c.jpg)
- [Movie Ticket](http://absolutebookmarking.net/wp-content/uploads/ticket-printing-templates-meloin-tandemco-blank-tickets-for-printing.png)

## License

    Copyright [2019] [Taylor Ka]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
