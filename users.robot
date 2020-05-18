***Settings***
Documentation   Page containg keywords and variables for user handling 

***Variables***
${User Menu}   //app-user-menu
${Browser}        Chrome
${URL}      http://bd.metait.cz/
${Valid Email} 
${Old Password Value}    testtest
${New Password Value}    testtest1
${Login Button}    //button[contains(text(),'Login')]
${Email Input}    //input[@id="email"]
${Password Input}    //input[@id="password"]
${Login Button Modal}   //app-login-modal//button[text() = 'Log In']
${Password Link Modal}    //a[contains(text(),'Password')]
${User Icon Button}    //app-user-menu-toggle/div[2]/figure
${Old Password}    //input[@id="oldPassword"]
${New Password}    //input[@id="newPassword"]
${Back Button}    //app-breadcrumbs/div/a
${Save Button}    //app-btn-loader/button
${Cancel Button}    //button[contains(text(),'Clear')]
${Password Change Toaster}    //div[@id="toast-container"]/div
${Password Change Successful}    Password Change Successful
${Logout Button}    //button[contains(text(),'Logout')]

***Keywords***
Login In User
    [Arguments]    ${Valid Email}    ${Valid Password}
    Wait Until Element is Visible    ${Login Button}
    Click Button    ${Login Button}
    Input Text    ${Email Input}    ${Valid Email}
    Input Password    ${Password Input}    ${Valid Password}
    Wait Until Element Is Enabled    ${Login Button Modal}
    Click Button    ${Login Button Modal}
    Sleep    3s

Click on the User icon button
    Click Element    ${User Icon Button}
    Page Should Contain Element    ${User Menu}
    Page Should Contain Element    ${Password Link Modal}

Click on the Password button
    Click Element    ${Password Link Modal}
    Wait Until Element is Visible    ${Old Password}
    Element Text Should Be    ${Old Password}    ${EMPTY}
    Element Text Should Be    ${New Password}    ${EMPTY}
    Element Should Be Disabled    ${Save Button}
    Element Should be Enabled    ${Cancel Button}
    Element Should be Enabled   ${Back Button}

Put testtest into Old password input box
    Input Text    ${Old Password}    ${Old Password Value}
    Element Should Be Disabled    ${Save Button}
    Element Should be Enabled    ${Cancel Button}

Put testtest into New password input box
    Input Text    ${New Password}    ${New Password Value}
    Element Should Be Enabled    ${Save Button}
    Element Should be Enabled    ${Cancel Button}

Click on Clear button
    Click Element    ${Cancel Button}
    Element Text Should Be    ${Old Password}    ${EMPTY}
    Element Text Should Be    ${New Password}    ${EMPTY}
    Element Should Be Disabled    ${Save Button}
    Element Should be Enabled    ${Cancel Button}

Click on Save button
    Click Element    ${Save Button}
    Wait Until Element is Visible    ${Password Change Toaster}
    Element Text Should Be    ${Password Change Toaster}    ${Password Change Successful}
    Wait Until Element is Visible    ${Old Password}
    Element Text Should Be    ${Old Password}    ${EMPTY}
    Element Text Should Be    ${New Password}    ${EMPTY}
    Element Should Be Disabled    ${Save Button}
    Element Should be Enabled    ${Cancel Button}
    Element Should be Enabled   ${Back Button}

Logout User
    Click Element    ${User Icon Button}
    Click Element    ${Logout Button}
    