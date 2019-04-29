*** Settings ***
Library    SeleniumLibrary
Suite Setup       Log    I'm in the Suite Setup
Suite Teardown    Log    I'm in the Suite Teardown
Test Setup        Log    I'm in the Test Setup
Test Teardown     Log    I'm in the Test Setup
Default Tags    sanity
*** Variables ***
${url}    https://opensource-demo.orangehrmlive.com/
${browser}    chrome
&{Credentials}    username=Admin    password=admin123
${userLocator}      id=txtUsername
${pwdLocator}       id=txtPassword
${logBtnLocator}    id=btnLogin

*** Test Cases ***
MyFirstTestCase
    [Tags]    smoke
    Log    Hello World..
    
MySecondTestCase
    Log    Second Test..
    Set Tags    regression1   
    remove Tags    sanity 
MyThirdTestCase
    Log    Third Test..
    
MyFourthTestCase
    Log    Fourth Test..
    
#MyFirstSeleniumTest
#    Open Browser     https://www.google.com    chrome
#    Input Text       name=q                    Youssef ait mbarek
#    Press Keys       none                      ENTER
#LoginTest
#    Open Browser        ${url}            ${browser}
#    Set Browser Implicit Wait    5
#    LoginKW    ${userLocator}    ${pwdLocator}    ${logBtnLocator}    &{Credentials}
#    Click Element    id=welcome
#    Click Element    link=Logout
*** Keywords ***
LoginKW
    [Arguments]    ${usernameLocator}    ${passwordLocator}    ${loginBtnLocator}    &{CredentialsDictionary}
    Input Text          ${usernameLocator}    &{CredentialsDictionary}[username]
    Input Password      ${passwordLocator}    &{CredentialsDictionary}[password]
    Click button        ${loginBtnLocator}
    

    