

Assume we have to implement login screen with some features:

2 text fields. Login and Password. Hint for login we receive from some backend. And password hint is static and never be changed.
1 switch that should enable or disable emailing for user.
1 text field with user's greeting text without validation.
1 login button. 



On login tap we should verify user's input:
If login and password are satisfying some conditions — show congratulation dialog, and after 2 seconds close dialog and screen
If user with given login exist — show snackbar with warning text
If login and/or password don't satisfy given conditions — show error under the input fields with warnings.

Loading indicator should be over screen.


Additional requirements:

If user start editing the input field with error — remove error only under the field user editing
