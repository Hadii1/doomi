# doomi

A simple todo app build using flutter.

The app is multi-language (English-Arabic) and multi-theme. The user creates an account using email and password
and can then create projects. The project can contain multiple statuses(todo, in progres..) and each status can contain 
multiple tasks that the user create. The user can also track each task time accross app sessions and mark the task as completed
so that it is archived in the project completed taks section. Exporting data in csv file is available inside the project details section.
The exported csv will contain the project details and all the tasks associated with this project.

The app uses firebase firestore and firebase auth services.

After downloading the repo, run "flutter pub get" to fetch the required dependencies.

Here's also an android apk link: https://www.dropbox.com/s/db8ry0le92idr8g/app-release.apk?dl=0
