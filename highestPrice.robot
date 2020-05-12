***Settings***
Documentation    Basic Test Case, that is for testing sorting products by descending price and adding them to the cart.
Library           SeleniumLibrary
Library           String

***Variables***
${URL}      https://www.czc.cz/
${BROWSER}        Chrome
${CONTINUE SHOPPING}    //html/body/div[3]/div[3]/div[1]/div[2]/div/div/div[2]/button
${EMPTY SHOPPING CART}    Prázdný košík

***Test Cases***
Highest Price
    Open Browser    about:blank    ${BROWSER}
    Set Window Size    1440    900
    Go To    ${URL}
    Title Should Be    CZC.cz - rozumíme vám i elektronice
    Mouse Over    //html/body/div[3]/header/div[2]/nav/div/div[3]/div[1]
    Wait and Click Element    //a[contains(text(),'Do notebooku')]
    Location Should Be    https://www.czc.cz/pevne-disky-do-notebooku/produkty
    Title Should Be    Pevné disky do notebooku | CZC.cz
    Wait and Click Element    //html/body/div[3]/div[3]/div[1]/div[2]/div[1]/div[6]/div/ul[1]/li[3]/a
    Sleep    1s
    Element Should Contain    //a[@class='active']    Nejdražší    #Set descending prices
    ${SHOPPING CART}=    Get Shopping Cart Value
    Should Be Equal    ${SHOPPING CART}    ${EMPTY SHOPPING CART}
    Scroll Element Into View    //html/body/div[3]/div[3]/div[1]/div[2]/div[1]/div[8]/div[1]/div[1]/div[2]/div[3]
    ${BIGGER PRICE}=    Get Price    //html/body/div[3]/div[3]/div[1]/div[2]/div[1]/div[8]/div[1]/div[1]/div[2]/div[2]/div/span/span[2]  
    ${SMALLER PRICE}=    Get Price    //html/body/div[3]/div[3]/div[1]/div[2]/div[1]/div[8]/div[1]/div[2]/div[2]/div[2]/div/span/span[2]
    Should Be True    "${BIGGER PRICE}" > "${SMALLER PRICE}"
    ${MORE EXPENSIVE ITEM}=    Get Text    //html/body/div[3]/div[3]/div[1]/div[2]/div[1]/div[8]/div[1]/div[1]/div[2]/div[1]/h5/a
    Wait and Click Button    //html/body/div[3]/div[3]/div[1]/div[2]/div[1]/div[8]/div[1]/div[1]/div[2]/div[2]/button    #Add Item to Shopping Cart
    Wait and Click Button    ${CONTINUE SHOPPING}
    ${SHOPPING CART}=    Get Shopping Cart Value
    Should Be True    "${SHOPPING CART}" != "${EMPTY SHOPPING CART}"
    ${LESS EXPENSIVE ITEM}=    Get Text    //html/body/div[3]/div[3]/div[1]/div[2]/div[1]/div[8]/div[1]/div[2]/div[2]/div[1]/h5/a
    Wait and Click Button    //html/body/div[3]/div[3]/div[1]/div[2]/div[1]/div[8]/div[1]/div[2]/div[2]/div[2]/button    #Add Item to Shopping Cart
    Wait and Click Button    ${CONTINUE SHOPPING}
    ${SHOPPING CART TWO}=    Get Shopping Cart Value
    Should Be True    "${SHOPPING CART TWO}" != "${EMPTY SHOPPING CART}" and "${SHOPPING CART TWO}" != "${SHOPPING CART}"
    Scroll Page To Location    0    0
    Wait and Click Element    //html/body/div[3]/header/div[2]/div/div/div[3]/div[4]
    Location Should Be    https://www.czc.cz/kosik
    ${SHOPPING CART BIGGER PRICE}=    Get Price    //html/body/div[2]/div[2]/div[1]/div/div/form/div[1]/div/div[1]/div/div[1]/div[5]/span[2]/span
    Should Be Equal    ${SHOPPING CART BIGGER PRICE}    ${BIGGER PRICE}
    ${MORE EXPENSIVE ITEM CART}=    Get Text    //html/body/div[2]/div[2]/div[1]/div/div/form/div[1]/div/div[1]/div/div[1]/div[1]/a
    Should Be Equal    ${MORE EXPENSIVE ITEM}    ${MORE EXPENSIVE ITEM CART}
    ${SHOPPING CART SMALLER PRICE}=    Get Price    //html/body/div[2]/div[2]/div[1]/div/div/form/div[1]/div/div[2]/div/div[1]/div[5]/span[2]/span
    Should Be Equal    ${SHOPPING CART SMALLER PRICE}    ${SMALLER PRICE}
    ${LESS EXPENSIVE ITEM CART}=    Get Text    //html/body/div[2]/div[2]/div[1]/div/div/form/div[1]/div/div[2]/div/div[1]/div[1]/a
    Should Be Equal    ${LESS EXPENSIVE ITEM CART}    ${LESS EXPENSIVE ITEM}
    [Teardown]    Shutdown

***Keywords***
Shutdown
    Wait and Click Element    //html/body/div[2]/div[2]/div[1]/div/div/form/div[1]/div/div[2]/div/div[1]/div[6]/a    #Cleans enviroment, removes items from shopping cart
    Wait and Click Element    //html/body/div[2]/div[2]/div[1]/div/div/form/div[1]/div/div[1]/div/div[1]/div[6]/a
    Close Browser

Wait and Click Element
    [Arguments]    ${Link}
    Wait Until Element Is Visible    ${Link}
    Click Element    ${Link}

Wait and Click Button
    [Arguments]    ${Link}
    Wait Until Element Is Visible   ${Link}
    FOR    ${i}    IN RANGE    0    10
        ${status}=    Run Keyword and return status    Click Button    ${Link}
        Exit For Loop If    ${status}
    END

Scroll Page To Location
    [Arguments]    ${x_location}    ${y_location}
    Execute JavaScript    window.scrollTo(${x_location},${y_location})

Get Shopping Cart Value
    Scroll Page To Location    0    0
    ${SHOPPING LIST}=    Get Text    //html/body/div[3]/header/div[2]/div/div/div[3]/div[4]/a/span
    [Return]    ${SHOPPING LIST}

Get Price
    [Arguments]    ${LOCATOR}
    ${PRICE}=    Get Text    ${LOCATOR}
    ${PRICE}=    Remove String   ${PRICE}        Kč
    ${PRICE}=    Convert To Number    ${PRICE}
    [Return]    ${PRICE}