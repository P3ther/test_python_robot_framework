***Settings***
Documentation
Library           SeleniumLibrary

***Variables***
${LOGIN URL}      https://www.emp-shop.cz/
${BROWSER}        Firefox

***Test Cases***
Highest Price
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Set Window Size    1280    800
    Title Should Be    EMP Online Shop, Rock & Metal, hry, filmy & seriály
    Mouse Over    //html/body/div[1]/header/div[3]/nav/ul/li[3]/a
    Wait and Click Element    //html/body/div[1]/header/div[3]/nav/ul/li[3]/div/div/div[2]/div/div/a[1]/span[2]
    Wait until element is visible    //*[@id="sort_by"]
    Select From List By Index   //*[@id="sort_by"]    4
    Sleep   5s
    Wait and Click Element    //html/body/div[2]/div[2]/div[3]/div/div[2]/div[3]/div/div[1]/div/a/div[1]/span
    Sleep    5s
    #[Teardown]    Shutdown
    

***Keywords***
Shutdown
    Close Browser

Wait and Click Element
    [Arguments]    ${Link}
    Wait until element is visible    ${Link}
    Click Element    ${Link}