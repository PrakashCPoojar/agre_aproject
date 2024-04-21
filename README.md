# Agriculture flutter application
Please fallow the following steps to get the Project Source Code and Local configuration.
Installing Agriculture application locally. 
1.	Open the command prompt select D drive with command D:
2.	Type mkdir project // It will create folder with a name project.
3.	Type cd project // It will select the project folder and now you should be inside the folder in command prompt.
4.	Type ‘git clone https://github.com/PrakashCPoojar/agre_aproject.git ‘ // It will clone all the Agriculture application code to project folder and it will create folder with name of “agre_aproject” .
5.	Type cd agre_aproject
6.	Open the Agriculture project in your VS Code (IDE).
Note: We have added all required dependencies in pubspec.yml file.
7.	After opening Agriculture project in IDE click on Terminal -> New Terminal and IDE will select your project.
8.	Type flutter pub get // It will install all the dependencies.
Connecting with DB Firebase.
1.	Create an Account in Firebase https://firebase.google.com/ 
2.	Go to the Firebase Console https://console.firebase.google.com/ 
3.	Create a new project / Add project.
4.	Enter name of your project Agriculture-93001
5.	For the moment you don’t want Google Analytics, turn off Enable Google Analytics for this project.
6.	Click on the Create Project // It will take some time.
7.	It will popup Your Firebase project is ready. 
8.	Select your project in Firebase console // Agriculture-93001
9.	Select an option Get started by adding Firebase to your app
10.	Select the Android icon
 ![image](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/7d444432-8184-4599-824b-9b04a8ac08cf)
11.	Enter Android package name.
a.	Open IDE and select/open Android folder -> app ->  build.gradle
b.	Open the build.gradle file and scroll down to defaultConfig  section you will find the applicationID “com.example.agre_aproject” copy the applicationID and paste in register app in firebase.
c.	Next option Debug signing certificate SHA-1 Note: Important to add to get this follow the below steps.
i.	Open your Command prompt type
ii.	keytool -list -v -keystore C:\Users\ADD-YOUR-PROFILE-NAME-SYSTEM\.android\debug.keystore -alias androiddebugkey
iii.	It will ask you to enter password type “android”
![image](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/9b4f82e3-81f6-4cba-a726-1ad61240b39b)
d.	Copy the SHA1 and paste in your firebase input form.
e.	Click on Register app button.
f.	Next step is Download and then add configuration file.
g.	Click on the Download google-services.json
h.	Copy that file and paste inside the project/agre_aproject/android/app
i.	After that click Next button
j.	Next step Add Firebase ASK
k.	Select Groovy (build.gradle) radio button
l.	Open the project level build.gradle file project/agre_aproject/android/build.gradle
m.	Add ‘classpath 'com.google.gms:google-services:4.3.15' In the  dependencies section and it should look like refer below figure
![image](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/ae7d15de-2074-4516-98c8-f55668754690)

n.	On next Open the app level build.gradle file project/agre_aproject/android/app
o.	Add id 'com.google.gms.google-services'  in plugins section
 ![image](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/be2d68c0-04b0-4a92-a7ae-5deba91e15bb)
p.	Add implementation platform('com.google.firebase:firebase-bom:32.8.1') In dependencies section.
 ![image](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/a78ac900-5fde-4225-95b8-9b1be7794340)

q.	Click next and finish the Firebase setup.
r.	It will Automatically redirect to project settings page on the left side navigation you will find the Authentication option .
s.	Select Authentication and Follow the instructions on the page click on the Get started and enable Email/Password and Google authentication.
 ![image](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/88942d29-8d8b-4d10-a284-4fdb0c71c05d)
t.	On the left navigation section, you will find the Realtime Database select the option.
u.	On the right section you will find the tree dots … click on that and select the Import JSON option, on the popup select brows option. 
v.	And redirect to project/agre_aproject/DB-tables/ select the JSON file to import the project data.
w.	After that it should look like this.
 ![image](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/1d9a90b3-ab97-4c5b-81b5-31dfdfa5278b)

12.	And come back to IDE in terminal type.
i.	Flutter pub get // It will install all the dependency and make the project in running condition * Optional
ii.	After that type flutter run
iii.	Select the desired platform to Run the application.
