***Settings***
Documentation    Basic Test Case, that is for testing sorting products by descending price and adding them to the cart.
Library           SeleniumLibrary
Library           String

***Variables***
${URL}      https://www.czc.cz/
${BROWSER}        Chrome
${CONTINUE SHOPPING}    //button[@class="btn btn-signal close"]
${EMPTY SHOPPING CART}    Prázdný košík

***Test Cases***
Highest Price
    Open Browser    about:blank    ${BROWSER}
    Set Window Size    1440    900
    Go To    ${URL}
    Title Should Be    CZC.cz - rozumíme vám i elektronice
    Mouse Over    //*[@class="main-menu__dep"][3]
    Wait and Click Element    //a[contains(text(),'Do notebooku')]
    Location Should Be    https://www.czc.cz/pevne-disky-do-notebooku/produkty
    Title Should Be    Pevné disky do notebooku | CZC.cz
    Wait and Click Element    //li[@class="filter-row"][3]
    Sleep    2s
    Element Should Contain    //a[@class='active']    Nejdražší    #Set descending prices
    ${SHOPPING CART}=    Get Shopping Cart Value
    Should Be Equal    ${SHOPPING CART}    ${EMPTY SHOPPING CART}
    Scroll Element Into View    //div[@id='tiles']//div[1]
    ${BIGGER PRICE}=    Get Price    //div[@class='new-tile'][1]//span[@class='price-vatin']
    ${SMALLER PRICE}=    Get Price    //div[@class='new-tile'][2]//span[@class='price-vatin']
    Should Be True    "${BIGGER PRICE}" > "${SMALLER PRICE}"
    ${MORE EXPENSIVE ITEM}=    Get Text    //div[@class='new-tile'][1]//div[@class='tile-title']/h5/a
    Wait and Click Button    //div[@class='new-tile'][1]//button[@class='btn btn-buy h-800']     #Add Item to Shopping Cart
    Wait and Click Button    ${CONTINUE SHOPPING}
    ${SHOPPING CART}=    Get Shopping Cart Value
    Should Be True    "${SHOPPING CART}" != "${EMPTY SHOPPING CART}"
    ${LESS EXPENSIVE ITEM}=    Get Text    //div[@class='new-tile'][2]//div[@class='tile-title']/h5/a
    Wait and Click Button    //div[@class='new-tile'][2]//button[@class='btn btn-buy h-800']    #Add Item to Shopping Cart
    Wait and Click Button    ${CONTINUE SHOPPING}
    ${SHOPPING CART TWO}=    Get Shopping Cart Value
    Should Be True    "${SHOPPING CART TWO}" != "${EMPTY SHOPPING CART}" and "${SHOPPING CART TWO}" != "${SHOPPING CART}"
    Scroll Page To Location    0    0
    Wait and Click Element   //div[@id='basket-preview']/a
    Location Should Be    https://www.czc.cz/kosik
    Sleep    2s
    ${SHOPPING CART BIGGER PRICE}=    Get Price    //div[@class='op-item'][1]//span[@class='price-vatin']
    Should Be Equal    ${SHOPPING CART BIGGER PRICE}    ${BIGGER PRICE}
    ${MORE EXPENSIVE ITEM CART}=    Get Text    //div[@class='op-item'][1]//a[@class='title']
    Should Be Equal    ${MORE EXPENSIVE ITEM}    ${MORE EXPENSIVE ITEM CART}
    ${SHOPPING CART SMALLER PRICE}=    Get Price    //div[@class='op-item'][2]//span[@class='price-vatin']
    Should Be Equal    ${SHOPPING CART SMALLER PRICE}    ${SMALLER PRICE}
    ${LESS EXPENSIVE ITEM CART}=    Get Text    //div[@class='op-item'][2]//a[@class='title']
    Should Be Equal    ${LESS EXPENSIVE ITEM CART}    ${LESS EXPENSIVE ITEM}
    [Teardown]    Shutdown

***Keywords***
Shutdown
    Wait and Click Element    //div[@class='td op-remove']/a    #Cleans enviroment, removes items from shopping cart
    Sleep    1s
    Wait and Click Element    //div[@class='td op-remove']/a
    Sleep    1s
    Element Should Contain    //div[@class="op-box"]/h1   Váš nákupní košík je prázdný
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
    ${SHOPPING LIST}=    Get Text    //*[@id="basket-preview"]/a/span
    [Return]    ${SHOPPING LIST}

Get Price
    [Arguments]    ${LOCATOR}
    Log    ${LOCATOR}
    ${PRICE}=    Get Text    ${LOCATOR}
    ${PRICE}=    Remove String   ${PRICE}        Kč
    ${PRICE}=    Convert To Number    ${PRICE}
    [Return]    ${PRICE}