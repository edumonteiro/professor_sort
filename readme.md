#Easy sort 

This app was developed to address a real and common problem in universities: assigning professors to classes

The scenario considered was the Statistics Department at the Universidade de Brasilia and the courses and offerings considered are the reality of the department for the first semester in 2016.

The focus of the app is to automate the process of publishing to the professors the required courses to be offered, gather the professors preferences and assign professors to the offered courses based on a set of rules.

Reports on past preferences and lectures are also available.


Naming conventions related to the business logic:
* Courses: topics of the classes eventually taught by the professors of the department
* Offerings: instances of the courses that will be offered to the students at a given semester
* Preferences: preferences of the professors on what to teach based on the offerings for a given semester
* Lectures: classes that are assigned and taught by a professor

#Magic procedure
##Rules used to assign the professors

1. Offerings with no ties on the highest preference level chosen by a professor are assigned to this professor
2. Professor who taught the course once but no twice on the past 2 semester have priority on ties
3. Professor who had the same preference on past semester and did not get the course have priority on ties
4. All remaining ties are decided randomly
5. All offerings prefered by no professor are assigned randomly to the remaining available professors
w
#Random procedure
1. Professors are assigned randomly to all the "n" offerings and an objective score function is calculated. 
2. The process is repeated a number k of times and the case with the biggest score is saved. 

The initial score function used is given by:

![score function](/score.png)

##Bellow are some UML diagrams to describe the use of the application.

![workflow diagram](/workflows.png)

![usecase diagram](/usecase.png)
