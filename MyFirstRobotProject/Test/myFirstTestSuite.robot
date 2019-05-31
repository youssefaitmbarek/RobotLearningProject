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
${tableLocator}     //table[@id='resultTable']


***Comment***  
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
    
MyFirstSeleniumTest
    Open Browser     https://www.google.com    chrome
    Input Text       name=q                    Youssef ait mbarek
    Press Keys       none                      ENTER
LoginTest
    Open Browser        ${url}            ${browser}
    Set Browser Implicit Wait    5
    LoginKW    ${userLocator}    ${pwdLocator}    ${logBtnLocator}    &{Credentials}
    Click Element    id=welcome
    Click Element    link=Logout
    
*** Test Cases ***
VariablesTest
    Open Browser    ${url}    ${browser}
    Set Browser Implicit Wait    5
    LoginKW    ${userLocator}    ${pwdLocator}    ${logBtnLocator}    &{Credentials}
    Click Element    id=menu_admin_viewAdminModule
    Click Element    id=menu_admin_Job
    Click Element    id=menu_admin_workShift
    &{returnValues}=  GetDataKW
    
    Log    &{returnValues}[firstKey]
    Log    &{returnValues}[secondKey]
    ${somme}=    Evaluate    &{returnValues}[firstKey]+&{returnValues}[secondKey]
    Log     ${somme}
    Should Not Be Equal    ${somme}    &{returnValues}[firstKey]
    
*** Keywords ***
LoginKW
    [Arguments]    ${usernameLocator}    ${passwordLocator}    ${loginBtnLocator}    &{CredentialsDictionary}
    Input Text          ${usernameLocator}    &{CredentialsDictionary}[username]
    Input Password      ${passwordLocator}    &{CredentialsDictionary}[password]
    Click button        ${loginBtnLocator}
GetDataKW
    ${firstValueString}=     Get Text   ${tableLocator}/tbody[1]/tr[1]/td[5]
    Log   ${firstValueString} 
    ${firstValue}=     Convert To Number    ${firstValueString}    
    Log     ${firstValue}
    ${secondValueString}=    Get Text   ${tableLocator}/tbody[1]/tr[2]/td[5]
    Log    ${secondValueString}
    ${secondValue}=    Convert To Number      ${secondValueString}  
    Log    ${secondValue}
    &{Values}    Create Dictionary    firstKey=${firstValue}    secondKey=${secondValue}
    Log    &{Values}[firstKey]
    Log    &{Values}[secondKey]
    [Return]    &{Values}
ListeComptageGetValuesForModificationCalcul
    [Arguments]    ${tableLocator}    ${row}    @{listColumns}
    ${listColumnsLength}    Get length    @{listColumns}
    @{listValtForCalcul}=    Create List
    :FOR    ${var}    IN RANGE    0    ${listColumnsLength}
    \    ${valueString}=    WebTableGetCellInputValue    ${tableLocator}    ${row}    @{listColumns}[${var}]
    \    ${value}    Convert To Number    ${valueString}
    \    Append To List    @{listValtForCalcul}    ${value}
    [Teardown]
    [Return]    @{listValtForCalcul}
ListeComptageVerifierCalculTotalModifie
    [Arguments]    @{totalModifie}    @{totalCalcule}    @{valInitial}    @{valModifie}
    ${totalModifieLenght}=    Get Length    @{totalModifie}
    :FOR    ${var}    IN RANGE    0    ${totalModifieLenght}
    \    ${valTotalApresModif}    Evaluate    @{totalCalcule}[${var}]-@{valInitial}[${var}]+@{valModifie}[${var}]
    \    log    ${valTotalApresModif}
    \    Should Be Equal    ${valTotalApresModif}    @{totalModifie}[${var}]
    