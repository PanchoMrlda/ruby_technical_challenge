## CONSIDERATIONS ABOUT THE CODE

The application doesn't care about the length of the input.txt file as long as the file follows the same structure that appears in the original file. This mean that you can add as many reservations as you want.

Also, reservation types can be added in an easy way to the constants so we can manage them in an easy way. After doing so, we can manage its specifications in the function `line_to_reservation`.

The time library was used to manage the time requirements for the flight connections. Better using that library than creating misleading, dense code.

Another consideration was to add translations, as any user could be using the application to show data. Except for the strings with interpolation, all the other strings are specific and easy-going to be replaced by translations in _config/locale/*.yml_ files. The same applies to the exceptions. 
