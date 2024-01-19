# doomi

A proof of concept to-do app built using Flutter.

The app is multi-language (English-Arabic) and multi-theme. The user creates an account using email and password
and can then create projects. The project can contain multiple statuses(todo, in progress..) and each status can contain 
multiple tasks that the user creates. The user can also track each task time across app sessions and mark the task as completed
so that it is archived in the project completed tasks section. Exporting data in a CSV file is available inside the project details section.
The exported CSV will contain the project details and all the tasks associated with this project.

The app uses Firebase Firestore and firebase auth services.

After downloading the repo, run "flutter pub get" to fetch the required dependencies.
