# ERA Infotech Ltd. Github Repos Task

# About

A simple Flutter app that displays List of the Github Users, The users repo list and the repo details coming from Github API using Clean Architecture pattern and Bloc State Management.

#### Installation

In the command terminal, run the following commands:

    $ git clone https://gitlab.com/rieadaits21/branstation_github_task.git
    $ cd branstation_github_task
    $ flutter run

# Features 🎯

- The 'Home' screen displays a list of Github Repos from Github for the Android topic
- By default the list of the Github Repos are sorted by the "Starred" number
- Clicking on any item on the user navigates the user to the "Repo list" screen for the clicked user
- Clicking on any item on the "Repo list" navigates the user to the "Repo Details" screen where user can see the "Name" and "Profile picture" of the Repo user, "Repo description", "Total Starred" for the repo, "Total Watches" number and "Last Updated" time.
- Implemented Clean Architecture as architecture pattern
- Implemented state management using Bloc pattern
- Caching data implementation
- Utilized a component-wise design pattern to promote code modularity and usability
- Made the app responsive for different screen sizes and orientations

## Project Config Roadmap

All the necessary config and dependencies have already been set and ready for use but there is an explanation of each step if you want to know more about the pre-config or customize it.

Initialize the Flutter project, add all the necessary dependencies mentioned above in the **pubspec.yaml** configuration file and run `pub get`.

**pubspec.yaml**
```yaml
dependencies:
  flutter:
    sdk: flutter
  # State Management
  flutter_bloc: ^8.1.4
  # Dependency Injection
  get_it: ^7.6.7
  # Network
  http: ^1.2.0
  internet_connection_checker: ^1.0.0
  # Local Storage
  sqflite: ^2.3.2
  path: ^1.8.3
  # Functional Programming
  dartz: ^0.10.1
  equatable: ^2.0.5
  # Date Formatting
  intl: ^0.19.0
  # Image Loading
  cached_network_image: ^3.3.1
  
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^2.0.0
```

# Future Scope 🎯

- Caching data implementation
- Search repository by User input
- Redirect github repo link from the app
