*** Settings ***
Library  SeleniumLibrary
Library    String
Library  BuiltIn

*** Test Cases ***
Test
    Open Browser    https://automationexercise.com/     chrome
    Click Link  xpath://*[@id="header"]/div/div/div/div[2]/div/ul/li[2]/a
    Element Should Be Visible    xpath=//*[@id="search_product"]
    Search Product      men tshirt
    Get Value1
    Add Product To Cart
    Search Product      winter top
    Get Value2
    Add Product To Cart
    Click Link  xpath://*[@id="header"]/div/div/div/div[2]/div/ul/li[3]/a
    Element Should Not Be Visible     id:empty_cart
    Verify Sum

*** Keywords ***
Search Product
    [Arguments]  ${name}
    Input Text  id:search_product     ${name}
    Click Element  id:submit_search

Add Product To Cart
    Mouse Over  xpath:/html/body/section[2]/div/div/div[2]/div/div[2]/div/div[1]
    Wait Until Element Is Visible   xpath:/html/body/section[2]/div/div/div[2]/div/div[2]/div/div[1]/div[2]
    Click Element   xpath:/html/body/section[2]/div/div/div[2]/div/div[2]/div/div[1]/div[2]/div/a
    Wait Until Element Is Visible   xpath://*[@id="cartModal"]/div/div/div[3]/button
    Click Element   xpath://*[@id="cartModal"]/div/div/div[3]/button

Get Value1
    ${value1}   Get Text  xpath:/html/body/section[2]/div/div/div[2]/div/div[2]/div/div[1]/div[1]/h2
    ${value1}=   Fetch From Right  ${value1}  ${SPACE}
    Set Test Variable   ${value1}

Get Value2
    ${value2}   Get Text  xpath:/html/body/section[2]/div/div/div[2]/div/div[2]/div/div[1]/div[1]/h2
    ${value2}=   Fetch From Right  ${value2}  ${SPACE}
    Set Test Variable   ${value2}

Verify Sum
    ${val1}     Get Text    xpath://*[@id="product-2"]/td[3]/p
    ${val1}=   Fetch From Right  ${val1}  ${SPACE}
    ${val2}     Get Text    xpath://*[@id="product-5"]/td[3]/p
    ${val2}=   Fetch From Right  ${val2}  ${SPACE}
    ${result}   Evaluate    int(${val1})+int(${val2})
    ${sum}   Evaluate    ${value1}+${value2}
    Should Be Equal As Numbers      ${result}       ${sum}
