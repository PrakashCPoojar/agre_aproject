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

#Screenshots
![1](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/9e58e280-5962-48fd-8b29-0cf0a9766398)
![2](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/58eb4118-6e71-4090-b41b-cd949b15fbe6)
![3](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/8cfd9c29-78aa-4e1f-b099-8f48ca4bdda2)
![3-1](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/9e06aa9f-5844-4ac1-b5a4-cecb4148d612)
![4](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/bbc05290-81a0-42cb-956c-bc5a75357ef4)
![5](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/84b86559-a433-44de-b70c-7bf50927be0f)
![6](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/0764e329-82a4-4341-bdab-92f04dbcc7d8)
![7](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/b3d9abfd-ea89-4595-b373-90d22238b7b4)
![8](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/5e2abea8-d033-40cc-b78c-da1924e09cea)
![9](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/e43c483b-1cc6-4c65-acdd-91a35301a8c4)
![10](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/72b4db06-fb3b-4d50-b9d2-4fb172566beb)
![11](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/85af64d9-8d2c-4ba4-8e72-a4addddcb397)
![12](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/fb688831-7324-462b-a362-38ec46aa0bca)
![13](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/f3189173-57be-4a41-a2a3-55d6d2b49a44)
![14](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/2035d2a0-79c8-4744-809e-d18730a99185)
![15](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/96e3a135-405c-431e-9dd7-d8d51d37f89d)
![16](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/4973c9aa-b8e2-401c-b992-bc17d0d08ac1)
![17](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/97ec466a-7d78-465c-808b-58881a836ffc)
![18](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/b28bdca7-3cd9-4d1b-85a3-24558bc0b4bc)
![19](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/b2f17a67-3ea8-4226-b933-9ba50425651d)
![20](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/90e53a38-9931-4b82-96bf-fad87fc0bca2)
![21](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/9ccfa61e-7a39-4c49-bf4c-d2001431c8e6)
![22](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/c9d99b48-bc9b-4ba0-a5d2-fe2939577bd7)
![23](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/015e9e51-3820-4786-82d0-01cd9e3357ae)
![24](https://github.com/PrakashCPoojar/agre_aproject/assets/126979638/9854d9a9-0ad0-4cf8-ab78-40913a5093db)

