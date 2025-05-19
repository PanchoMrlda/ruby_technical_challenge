## CONSIDERATIONS ABOUT THE CODE

The application doesn't care about the length of the input.txt file as long as the file follows the same structure that appears in the original file. This mean that you can add as many reservations as you want.

Also, reservation types can be added in an easy way to the constants on the file `models/reservation.rb`, so we can manage them in an easy way as well. After doing so, we can manage its specifications in the `initialize` function.

The time library was used to manage the time requirements for the flight connections. Better using that library than creating misleading, dense code. The set library was used to manage huge amount of data in a more efficient way.

Another consideration was to add translations, as any user could be using the application to show data. All the strings are specific and easy-going to be replaced by translations in _config/locale/*.yml_ files. The same applies to the exceptions.  The i18n library was added for this purpose. 
