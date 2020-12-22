# swiftui-servey

- It's an app for defining and answering surveys (each survey contains multiple questions)
- The main screen has two tabs `Manage` and `Answer` the answer part is not implemented, it only shows list of defined surveys
- In the `Manage` tab you can define questions, and then define a survey using that questions
- The question form is also very simple now only title, question and a flag for optionality

The main purpose of this app is making a SwifUI app using MVVM structure, handling loading, errors, and dependencies


The backend is deployed on Heroku, it uses in-memory database so after being idle for a while the data will be disappeared
