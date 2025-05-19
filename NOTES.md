## CONSIDERATIONS ABOUT THE CODE

The application doesn't care about the length of the input.txt file as long as the file follows the same structure that appears in the original file. This mean that you can add as many reservations as you want.

Also, reservation types can be added in an easy way to the constants in the model `Reservation`, so we can manage them in an easy way. After doing so, we can manage its specifications in the `initialize` function.

The time library was used to manage the time requirements for the flight connections. Better using that library than creating misleading, dense code. The set library was used to add better performance to the code, as it is a collection of unordered and unique elements. The i18n library was used to manage the translations of the strings in the application.

Another consideration was to add translations, as any user could be using the application to show data. All strings are centralized in the file `lib/messages.rb` All strings are specific and easy-going to be replaced by translations in _config/locale/*.yml_ files. The same applies to the exceptions.
