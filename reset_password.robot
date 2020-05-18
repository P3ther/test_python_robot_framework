***Settings***
Documentation   Test Case for changing password.
Library     SeleniumLibrary
Resource    users.robot

***Test Cases***
Change password
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Login In User    ${Valid Email}    ${Old Password Value}
    Click on the User icon button
    Click on the Password button
    Put testtest into Old password input box
    Put testtest into New password input box
    Click on Clear button
    Put testtest into Old password input box
    Put testtest into New password input box
    Click on Save button
    Logout User
    Login In User    ${Valid Email}    ${New Password Value}
