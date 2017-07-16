# exchange-rate
A simple iOS app for currency exchange rates.

This app fetchs currency information in Json format from the http://fixer.io/ API.

### Key Features
 - Convert money between Russian Rubles (₽), US Dollars ($) and European Euros (€); 
 - Bidirectional conversion. You can either type on the left or on the right side;
 - Possibility to use older rates from previous dates;
 - Autolayout support that works across different devices and orientations:
 
![iphone6s](https://user-images.githubusercontent.com/428736/28249458-e88566f6-6a5e-11e7-8196-c565e272cb0a.png)
![ipadair](https://user-images.githubusercontent.com/428736/28249462-06a9e10c-6a5f-11e7-8af9-c34c2392e49c.png)

Here is the UML diagram.
![uml](https://user-images.githubusercontent.com/428736/28249889-078eafdc-6a67-11e7-8d94-91bbb9214e4c.png)

This app has no "update" button to call the API and make the conversion.  
The conversion is done automatically on every keystroke, or more precisely, 1 second after the last keystroke, hence the reason for a timer.
